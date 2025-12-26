using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Common;
using System.Data.SqlClient;

namespace NorthwindLandingTest
{
    public class OverwritedTestService : SqlDatabaseTestService
    {
        private string BuildConfiguration;
        private string InitialCatalog;
        private string ExternalFilesPath;
        private string Provider;

        private string sqlConnectionString;

        public OverwritedTestService(TestContext testContextInstance)
        {
            BuildConfiguration = (string)testContextInstance.Properties["BuildConfiguration"];
            InitialCatalog = (string)testContextInstance.Properties["LandingDatabaseName"];
            ExternalFilesPath = (string)testContextInstance.Properties["ExternalFilesPath"];
            Provider = (string)testContextInstance.Properties["Provider"];
            sqlConnectionString = new SqlConnectionStringBuilder
            {
                ApplicationName = "FunctionalETLTest",
                DataSource = (string)testContextInstance.Properties["LandingServerName"],
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
