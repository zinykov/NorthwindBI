using Microsoft.SqlServer.Management.IntegrationServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
//using Microsoft.SqlServer.Management.IntegrationServices;

namespace NorthwindETLTest
{
    /// <summary>
    /// Тестирование ETL в рамках CI/CD
    /// </summary>
    [TestClass]
    public class NorthwindTest
    {
        public NorthwindTest()
        {
            //
            // TODO: добавьте здесь логику конструктора
            //
        }

        private TestContext testContextInstance;

        /// <summary>
        ///Получает или устанавливает контекст теста, в котором предоставляются
        ///сведения о текущем тестовом запуске и обеспечивается его функциональность.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Дополнительные атрибуты тестирования
        //
        // При написании тестов можно использовать следующие дополнительные атрибуты:
        //
        // ClassInitialize используется для выполнения кода до запуска первого теста в классе
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // ClassCleanup используется для выполнения кода после завершения работы всех тестов в классе
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // TestInitialize используется для выполнения кода перед запуском каждого теста 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // TestCleanup используется для выполнения кода после завершения каждого теста
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        [TestMethod]
        public void NorthwindETLTest()
        {
            //Initializing Variables
            DateTime LoadDateInitialEnd = new DateTime(1997, 12, 31, 0, 0, 0);
            DateTime LoadDateIncrementalEnd = new DateTime(1998, 1, 3, 0, 0, 0);
            string SSISServerName = Environment.MachineName;
            string SSISCatalogName = "SSISDB";
            string SSISFolderName = "NorthwindBI";
            string SSISProjectName = "NorthwindETL";
            Int64 executionid = -1;
            Catalog SSISDB = new IntegrationServices(new SqlConnection($"Data Source={SSISServerName};Initial Catalog=master;Integrated Security=SSPI;")).Catalogs[SSISCatalogName];
            ProjectInfo NorthwindETL = SSISDB.Folders[SSISFolderName].Projects[SSISProjectName];
            EnvironmentReference referenceid = NorthwindETL.References[new EnvironmentReference.Key("Release", ".")];

            //Initial load
            PackageInfo InitialLoad = NorthwindETL.Packages["Initial Load.dtsx"];
            var setValueParameters = new Collection<PackageInfo.ExecutionValueParameterSet>();
            setValueParameters.Add(
                new PackageInfo.ExecutionValueParameterSet
                {
                    ObjectType = 30,
                    ParameterName = "CutoffTime",
                    ParameterValue = LoadDateInitialEnd
                });
            setValueParameters.Add(
                new PackageInfo.ExecutionValueParameterSet
                {
                    ObjectType = 30,
                    ParameterName = "LoadDateInitialEnd",
                    ParameterValue = LoadDateInitialEnd
                });
            setValueParameters.Add(
                new PackageInfo.ExecutionValueParameterSet
                {
                    ObjectType = 50,
                    ParameterName = "SYNCHRONIZED",
                    ParameterValue = true
                });
            try
            {
                executionid = InitialLoad.Execute(false, referenceid, setValueParameters);
            }
            catch (Exception e)
            {
                Assert.Fail($"Failed launch SSIS package {InitialLoad.Name} with error: \"{e.Message}\"");
            }
            Console.WriteLine($"{InitialLoad.Name} execution ID {executionid.ToString()}");
            string catalogExecutions = SSISDB.Executions[new ExecutionOperation.Key(executionid)].Status.ToString();
            if (catalogExecutions == "Failed") { Assert.Fail($"Executing SSIS package {InitialLoad.Name} status - {catalogExecutions}"); }
        }
    }
}
