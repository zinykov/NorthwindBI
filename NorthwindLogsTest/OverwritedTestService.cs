using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using System;
using System.Data.Common;
using System.Data.SqlClient;

namespace NorthwindDWTest
{
    public class OverwritedTestService : SqlDatabaseTestService
    {
        private string sqlConnectionString;

        public OverwritedTestService(String sqlConnectionString)
        {
            this.sqlConnectionString = sqlConnectionString;
        }

        public override ConnectionContext OpenExecutionContext()
        {
            ConnectionContext connectionContext = new ConnectionContext();
            connectionContext.Provider = DbProviderFactories.GetFactory("System.Data.SqlClient");
            connectionContext.Provider.CreateConnection();
            connectionContext.Connection = new SqlConnection(sqlConnectionString);
            connectionContext.Connection.Open();
            return connectionContext;
        }

        public override ConnectionContext OpenPrivilegedContext()
        {
            ConnectionContext connectionContext = new ConnectionContext();
            connectionContext.Provider = DbProviderFactories.GetFactory("System.Data.SqlClient");
            connectionContext.Provider.CreateConnection();
            connectionContext.Connection = new SqlConnection(sqlConnectionString);
            connectionContext.Connection.Open();
            return connectionContext;
        }
    }
}
