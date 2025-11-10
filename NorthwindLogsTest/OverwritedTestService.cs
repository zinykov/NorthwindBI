using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Common;
using System.Data.SqlClient;

namespace NorthwindLogsTest
{
    public class OverwritedTestService : SqlDatabaseTestService
    {
        private static string BuildConfiguration;
        private static string InitialCatalog;
        private static string ExternalFilesPath;
        private static string Provider;

        private static string sqlConnectionString;

        public OverwritedTestService(TestContext testContextInstance)
        {
            BuildConfiguration = (string)testContextInstance.Properties["BuildConfiguration"];
            InitialCatalog = (string)testContextInstance.Properties["LogsDatabaseName"];
            ExternalFilesPath = (string)testContextInstance.Properties["ExternalFilesPath"];
            Provider = (string)testContextInstance.Properties["Provider"];
            sqlConnectionString = new SqlConnectionStringBuilder
            {
                ApplicationName = "FunctionalETLTest",
                DataSource = (string)testContextInstance.Properties["LogsServerName"],
                InitialCatalog = InitialCatalog,
                IntegratedSecurity = true,
                PersistSecurityInfo = false,
                Pooling = false,
                MultipleActiveResultSets = false,
                Encrypt = true,
                TrustServerCertificate = true
            }.ToString();
        }

        public override ConnectionContext OpenExecutionContext()
        {
            ConnectionContext connectionContext = new ConnectionContext();
            connectionContext.Provider = DbProviderFactories.GetFactory(Provider);
            connectionContext.Provider.CreateConnection();
            connectionContext.Connection = new SqlConnection(sqlConnectionString);
            connectionContext.Connection.Open();
            return connectionContext;
        }

        public override ConnectionContext OpenPrivilegedContext()
        {
            ConnectionContext connectionContext = new ConnectionContext();
            connectionContext.Provider = DbProviderFactories.GetFactory(Provider);
            connectionContext.Provider.CreateConnection();
            connectionContext.Connection = new SqlConnection(sqlConnectionString);
            connectionContext.Connection.Open();
            return connectionContext;
        }

        public override void DeployDatabaseProject()
        {
            DeployDatabaseProject(
                databaseProjectFileName: $"{ExternalFilesPath}\\{InitialCatalog}\\{InitialCatalog}.sqlproj",
                configuration: BuildConfiguration,
                providerInvariantName: Provider,
                connectionString: sqlConnectionString
            );
        }
    }
}
