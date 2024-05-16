using Microsoft.SqlServer.Management.IntegrationServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace NorthwindETLTest
{
    /// <summary>
    /// Тестирование работы ETL и правильности данных в рамках CD
    /// </summary>
    [TestClass]
    public class NorthwindETLTest
    {
        /// <summary>
        /// Initializing variables
        /// </summary>
        private static DateTime LoadDateInitialEnd = new DateTime(1997, 12, 31, 0, 0, 0);
        private static DateTime LoadDateIncrementalEnd = new DateTime(1998, 1, 3, 0, 0, 0);
        /// <summary>
        /// Initializing technical variables
        /// </summary>
        private static string SSISServerName = Environment.MachineName;
        private static string SSISCatalogName = "SSISDB";
        private static string SSISFolderName = "NorthwindBI";
        private static string SSISProjectName = "NorthwindETL";
        private static Catalog SSISDB = new IntegrationServices(new SqlConnection($"Data Source={SSISServerName};Initial Catalog=master;Integrated Security=SSPI;")).Catalogs[SSISCatalogName];
        private static ProjectInfo NorthwindETL = SSISDB.Folders[SSISFolderName].Projects[SSISProjectName];
        private static EnvironmentReference referenceid = NorthwindETL.References[new EnvironmentReference.Key("Release", ".")];

        public NorthwindETLTest()
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

        // ClassInitialize используется для выполнения кода до запуска первого теста в классе
        [ClassInitialize()]
        public static void MyClassInitialize(TestContext testContext)
        {
            Int64 executionid = -1;

            PackageInfo IncrementalLoad = NorthwindETL.Packages["PreTest.dtsx"];
            var setValueParameters = new Collection<PackageInfo.ExecutionValueParameterSet>();
            setValueParameters.Add(
                new PackageInfo.ExecutionValueParameterSet
                {
                    ObjectType = 30,
                    ParameterName = "LoadDateIncrementalEnd",
                    ParameterValue = LoadDateIncrementalEnd
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
                executionid = IncrementalLoad.Execute(false, referenceid, setValueParameters);
            }
            catch (Exception e)
            {
                Assert.Fail($"Failed launch SSIS package {IncrementalLoad.Name} with error: \"{e.Message}\"");
            }

            System.Diagnostics.Trace.WriteLine($"{IncrementalLoad.Name} execution ID {executionid.ToString()}");
            string catalogExecutions = SSISDB.Executions[new ExecutionOperation.Key(executionid)].Status.ToString();

            if (catalogExecutions == "Failed")
            {
                Assert.Fail($"Executing SSIS package {IncrementalLoad.Name} status - {catalogExecutions}");
            }
            else
            {
                System.Diagnostics.Trace.WriteLine($"Executing SSIS package {IncrementalLoad.Name} status - {catalogExecutions}");
            }
        }

        [TestMethod]
        public void NorthwindTest()
        {
            this.ExecuteLoadPackage("Initial Load.dtsx", LoadDateInitialEnd);

            DateTime CutoffTime = LoadDateInitialEnd.AddDays(1);

            while (CutoffTime <= LoadDateIncrementalEnd)
            {
                this.ExecuteLoadPackage("Incremental Load.dtsx", CutoffTime);
            }

            //NorthwindETLDataTest.NorthwindETLDataTest test = new NorthwindETLDataTest.NorthwindETLDataTest();
            //test.TestInitialize();
            //test.CustomerSCD2TestStage1();
        }

        private void ExecuteLoadPackage(string PackageName, DateTime CutoffTime)
        {
            Int64 executionid = -1;
            
            PackageInfo IncrementalLoad = NorthwindETL.Packages[PackageName];
            var setValueParameters = new Collection<PackageInfo.ExecutionValueParameterSet>();
            setValueParameters.Add(
                new PackageInfo.ExecutionValueParameterSet
                {
                    ObjectType = 30,
                    ParameterName = "CutoffTime",
                    ParameterValue = CutoffTime
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
                executionid = IncrementalLoad.Execute(false, referenceid, setValueParameters);
            }
            catch (Exception e)
            {
                Assert.Fail($"Failed launch SSIS package {IncrementalLoad.Name} with error: \"{e.Message}\"");
            }

            System.Diagnostics.Trace.WriteLine($"{IncrementalLoad.Name} execution ID {executionid.ToString()}");
            string catalogExecutions = SSISDB.Executions[new ExecutionOperation.Key(executionid)].Status.ToString();

            if (catalogExecutions == "Failed")
            {
                Assert.Fail($"Executing SSIS package {IncrementalLoad.Name} status - {catalogExecutions}");
            }
            else
            {
                System.Diagnostics.Trace.WriteLine($"Executing SSIS package {IncrementalLoad.Name} status - {catalogExecutions}");
            }
        }
    }
}
