// sql package.
package xsql

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"net"
	"strconv"
	"time"

	"github.com/kelseyhightower/envconfig"
	log "github.com/sirupsen/logrus"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/google"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"

	_ "github.com/lib/pq"

	"github.com/anzx/xplore-pkg/sql/migration"
)

var (
	ErrUnknownAuthenticationMethod = errors.New("could not determine connection type from options")
)

type Client struct {
	env              *Environment
	connectionString string
	token            *oauth2.Token
	tokenService     TokenService
	openFunc         func(dialector gorm.Dialector, opts ...gorm.Option) (db *gorm.DB, err error)
	closeFunc        func(db *gorm.DB) error
	DB               *gorm.DB
}

type ClientOption interface {
	Apply(*Client) error
}

type Environment struct {
	Host     string `envconfig:"DB_HOST"`
	Database string `envconfig:"DB_NAME"`
	Port     int    `envconfig:"DB_PORT" default:"5432"`
	User     string `envconfig:"DB_USER"`
	Password string `envconfig:"DB_PASSWORD"`
}

func New(options ...ClientOption) (*Client, error) {
	return NewWithPrefix("", options...)
}

func NewWithPrefix(prefix string, options ...ClientOption) (*Client, error) {
	cli, err := newClient(prefix, options...)
	if err != nil {
		return nil, err
	}

	db, err := cli.connect()
	if err != nil {
		return nil, err
	}

	cli.DB = db
	return cli, nil
}

func newClient(prefix string, opts ...ClientOption) (*Client, error) {
	env := &Environment{}
	if err := envconfig.Process(prefix, env); err != nil {
		return nil, err
	}

	client := &Client{
		env:       env,
		openFunc:  gorm.Open,
		closeFunc: closeDB,
	}
	for _, op := range opts {
		if err := op.Apply(client); err != nil {
			return nil, err
		}
	}

	if client.connectionString == "" {
		return nil, ErrUnknownAuthenticationMethod
	}
	return client, nil
}

func (client *Client) Migrate(migrationPath string) error {
	return migration.Do(client.DB, migrationPath)
}
func (client *Client) ForceMigrate(migrationPath string, version int) error {
	return migration.ForceToVersion(client.DB, migrationPath, version)
}

// WithBasicAuthentication simply takes username and password values and
// injects them into a standard connection string.
func WithBasicAuthentication() ClientOption {
	return &withBasicAuthentication{}
}

type withBasicAuthentication struct{}

func (option *withBasicAuthentication) Apply(client *Client) error {
	hostPort := net.JoinHostPort(client.env.Host, strconv.Itoa(client.env.Port))
	client.connectionString = fmt.Sprintf("postgres://%s:%s@%s/%s?sslmode=disable",
		client.env.User, client.env.Password, hostPort, client.env.Database)
	return nil
}

// WithTokenAuthentication will build the client connection string by
// attempting to load a token with the current set of Google Default Credentials.
func WithTokenAuthentication(ctx context.Context, service TokenService) ClientOption {
	return &withTokenAuthentication{ctx, service}
}

type withTokenAuthentication struct {
	ctx     context.Context //nolint:containedctx // Only way to pass ctx without changing signature of options
	service TokenService
}

func (option *withTokenAuthentication) Apply(client *Client) error {
	client.tokenService = option.service
	token, err := client.tokenService.Fetch(option.ctx)
	if err != nil {
		return err
	}

	client.token = token
	client.connectionString = fmt.Sprintf("host=%v user=%v password=%v port=%v dbname=%v",
		client.env.Host, client.env.User, token.AccessToken, client.env.Port, client.env.Database)
	return nil
}

type TokenService interface {
	Fetch(ctx context.Context) (*oauth2.Token, error)
}

type googleTokenService struct{}

func (r *googleTokenService) Fetch(ctx context.Context) (*oauth2.Token, error) {
	creds, err := google.FindDefaultCredentials(ctx)
	if err != nil {
		return nil, err
	}

	token, err := creds.TokenSource.Token()
	if err != nil {
		return nil, err
	}

	return token, nil
}

var GoogleTokenService = &googleTokenService{}

// RefreshToken only needs to be called when using IAM Authentication method.
// When using this method it will check the token that is currently being used
// on the open connection, if it is expired or expiring in the next 10 minutes then
// it will open a new connection.
func (client *Client) RefreshToken(ctx context.Context) error {
	// We aren't using token auth
	if client.tokenService == nil {
		client.logEntry().Debug("skipping token refresh: using basic auth")
		return nil
	}

	// The token has not expired and not expiring soon.
	if client.token.Valid() && time.Until(client.token.Expiry) > 10*time.Minute {
		client.logEntry().Debug("skipping token refresh: token is still valid")
		return nil
	}

	client.logEntry().Debug("refreshing token: token is no longer valid or expiring soon")
	// Token refreshed
	token, err := client.tokenService.Fetch(ctx)
	if err != nil {
		return err
	}

	client.connectionString = fmt.Sprintf("host=%v user=%v password=%v port=%v dbname=%v",
		client.env.Host, client.env.User, token.AccessToken, client.env.Port, client.env.Database)

	db, err := client.connect()
	if err != nil {
		return err
	}

	originalDB := client.DB
	if err != nil {
		return err
	}
	defer func() {
		log.Info("close original DB after refreshing token")
		client.close(originalDB)
	}()

	client.DB = db
	client.token = token

	return nil
}

func (client *Client) close(db *gorm.DB) error {
	return client.closeFunc(db)
}

func closeDB(db *gorm.DB) error {
	originalDB, err := db.DB()
	if err != nil {
		return err
	}

	return originalDB.Close()
}

// connect opens a new connection to a sql instance given the current
// client connection string.
func (client *Client) connect() (*gorm.DB, error) {
	sqlDB, err := sql.Open("postgres", client.connectionString)
	if err != nil {
		log.Fatal(err)
	}
	gormConfig := &gorm.Config{}
	if log.GetLevel() >= log.DebugLevel {
		gormConfig.Logger = logger.Default.LogMode(logger.Info)
	}
	return client.openFunc(postgres.New(postgres.Config{
		Conn: sqlDB,
	}), gormConfig)
}

func (client *Client) logEntry() *log.Entry {
	return log.WithFields(log.Fields{
		"hostname": client.env.Host,
		"database": client.env.Database,
		"port":     client.env.Port,
		"username": client.env.User,
	})
}
