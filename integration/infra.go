package integration

import (
	"context"
	"fmt"
	"os"

	"github.com/ory/dockertest/v3"
	"github.com/ory/dockertest/v3/docker"
	log "github.com/sirupsen/logrus"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func applyDefaultHostConfig(hc *docker.HostConfig) {
	hc.AutoRemove = true
	hc.RestartPolicy = docker.NeverRestart()
}

func applyDefaultResourceRules(resource *dockertest.Resource) {
	//nolint:errcheck
	resource.Expire(2 * 60) // At most we want to keep this around for 2 minutes
}

// StartPostgresInstance starts a docker container runnign Postgres 9.6 and returns
// a gorm connection instance and port (for binding) to that instance.
func StartPostgresInstance(ctx context.Context) (*gorm.DB, string, error) {
	pool, err := dockertest.NewPool("")
	if err != nil {
		log.Fatalf("Could not connect to docker: %s", err)
	}
	resource, err := pool.RunWithOptions(
		&dockertest.RunOptions{
			Repository: "hub.artifactory.gcp.anz/postgres",
			Tag:        "9.6",
			Env:        []string{"POSTGRES_PASSWORD=secret"},
		}, applyDefaultHostConfig)
	if err != nil {
		return nil, "", fmt.Errorf("could not start resource: %w", err)
	}
	applyDefaultResourceRules(resource)

	var db *gorm.DB
	// exponential backoff-retry, because the application in the container might not be ready to accept connections yet
	if err := pool.Retry(func() error {
		var err error
		connectionString := fmt.Sprintf("host=localhost port=%s user=postgres password=secret dbname=postgres",
			resource.GetPort("5432/tcp"))

		db, err = gorm.Open(postgres.Open(connectionString), &gorm.Config{
			Logger: logger.Default.LogMode(logger.Silent),
		})

		return err
	}); err != nil {
		return nil, "", fmt.Errorf("could not connect to database: %w", err)
	}

	return db, resource.GetPort("5432/tcp"), nil
}

func SetDatabaseEnvironment(port string, prefix string) {
	str := ""
	if prefix != "" {
		str = prefix + "_"
	}
	os.Setenv(str+"DB_HOST", "localhost")
	os.Setenv(str+"DB_NAME", "postgres")
	os.Setenv(str+"DB_PORT", port)
	os.Setenv(str+"DB_USER", "postgres")
	os.Setenv(str+"DB_PASSWORD", "secret")
}
