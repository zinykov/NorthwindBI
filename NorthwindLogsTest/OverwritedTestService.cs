using Microsoft.Data.Schema.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.Common;
using System.Data.SqlClient;

namespace NorthwindDWTest
{
    public class OverwritedTestService : SqlDatabaseTestService
    {
        private SqlConnectionStringBuilder sqlConnectionString;

        public OverwritedTestService(TestContext TestContext)
        {
            sqlConnectionString = new SqlConnectionStringBuilder();
            sqlConnectionString.ApplicationName = "FunctionalETLTest";
            sqlConnectionString.DataSource = Environment.MachineName;
            sqlConnectionString.InitialCatalog = (string)TestContext.Properties["LogsDatabaseName"];
            sqlConnectionString.IntegratedSecurity = true;
            sqlConnectionString.PersistSecurityInfo = false;
            sqlConnectionString.Pooling = false;
            sqlConnectionString.MultipleActiveResultSets = false;
            sqlConnectionString.ConnectTimeout = 60;
            sqlConnectionString.Encrypt = true;
            sqlConnectionString.TrustServerCertificate = true;
        }

        public override ConnectionContext OpenExecutionContext()
        {
            ConnectionContext connectionContext = new ConnectionContext();
            connectionContext.Provider = DbProviderFactories.GetFactory("System.Data.SqlClient");
            connectionContext.Provider.CreateConnection();
            connectionContext.Connection = new SqlConnection(sqlConnectionString.ToString());
            connectionContext.Connection.Open();
            return connectionContext;
        }

        public override ConnectionContext OpenPrivilegedContext()
        {
            ConnectionContext connectionContext = new ConnectionContext();
            connectionContext.Provider = DbProviderFactories.GetFactory("System.Data.SqlClient");
            connectionContext.Provider.CreateConnection();
            connectionContext.Connection = new SqlConnection(sqlConnectionString.ToString());
            connectionContext.Connection.Open();
            return connectionContext;
        }
    }
}
