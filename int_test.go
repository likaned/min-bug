package casegenerator

import (
	"context"
	"fmt"
	"os"
	"testing"

	"github.com/joho/godotenv"
	log "github.com/sirupsen/logrus"
	"github.com/stretchr/testify/require"
	"github.com/stretchr/testify/suite"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"

	"github.com/anzx/xplore-evaluation-engine/pkg/integrationtest/integration"
	"github.com/anzx/xplore-evaluation-engine/pkg/integrationtest/xsql"
	"github.com/anzx/xplore-evaluation-engine/pkg/outcomes/outcomedb"
	xlogger "github.com/anzx/xplore-pkg/sql/logger"
	"github.com/anzx/xplore-pkg/sql/migration"
)

func TestMain(m *testing.M) {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("error loading .env file")
	}

	os.Exit(m.Run())
}

type caseGeneratorTestSuite struct {
	suite.Suite
	db            *gorm.DB
	migrationPath string
}

func TestIntegrationCaseGenerator(t *testing.T) {
	if testing.Short() {
		t.Skip("skipping integration tests in short mode.")
	}
	suite.Run(t, new(caseGeneratorTestSuite))
}

func (s *caseGeneratorTestSuite) SetupSuite() {
	s.migrationPath = os.Getenv("DB_MIGRATIONS_PATH")

	var port string
	var err error
	ctx := context.Background()
	s.db, port, err = integration.StartPostgresInstance(ctx)
	integration.SetDatabaseEnvironment(port, "")
	require.NoError(s.T(), err)

	os.Setenv("LOG_LEVEL", "trace")
}

func (s *caseGeneratorTestSuite) wipeDB() error {
	log.Warn("cleaning DB")
	err := s.db.Transaction(func(tx *gorm.DB) error {
		tx.Exec(`DROP TABLE IF EXISTS case_histories CASCADE`)
		tx.Exec(`DROP TABLE IF EXISTS activities CASCADE`)
		tx.Exec(`DROP TABLE IF EXISTS issues CASCADE`)
		tx.Exec(`DROP TABLE IF EXISTS case_controls CASCADE`)
		tx.Exec(`DROP TABLE IF EXISTS control_references CASCADE`)
		tx.Exec(`DROP TABLE IF EXISTS cases CASCADE`)
		tx.Exec(`DROP TABLE IF EXISTS processed_messages CASCADE`)
		tx.Exec(`DROP TABLE IF EXISTS schema_migrations CASCADE`)
		return tx.Error
	})
	if err != nil {
		return nil
	}
	return migration.Do(s.db, s.migrationPath)
}

func (s *caseGeneratorTestSuite) SetupTest() {
	log.Info("db spun up, migrating")
	require.NoError(s.T(), s.wipeDB(), "failed to clear database")
}

func (s *caseGeneratorTestSuite) TestCreateIssuesMin() {
	t := s.T()

	options := make([]xsql.ClientOption, 0)
	options = append(options, xsql.WithBasicAuthentication())
	sqlClient, err := xsql.New(options...)
	require.NoError(t, err)

	if sqlClient.DB != nil {
		sqlClient.DB.Logger = &xlogger.AuditLogger{}
	}

	caze := &outcomedb.Case{
		Alert:     false,
		Status:    "Open",
		CaseTag:   "",
		AutoClose: false,
	}
	for i := 0; i < 7; i++ {
		dbTx := sqlClient.DB.Session(&gorm.Session{
			CreateBatchSize: 0,
		})
		require.NoError(t, err, fmt.Sprintf("session failed for i: %d", i))

		err = dbTx.Transaction(func(db *gorm.DB) error {
			if i == 6 {
				log.Info("Problem step")
			}
			tx := sqlClient.DB.Omit(clause.Associations)
			require.NoError(t, tx.Error)
			tx = tx.Create(caze)
			require.NoError(t, tx.Error, fmt.Sprintf("create failed for i: %d", i))
			return nil
		})
		require.NoError(t, err, fmt.Sprintf("transaction failed for i: %d", i))
	}
}
