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
            string SSISFolderName = "NorthwindBI";
            string SSISProjectName = "NorthwindETL";
            string SSISServerName = Environment.MachineName;
            Int64 executionid = -1;

            //Initial load
            ProjectInfo NorthwindETL = new IntegrationServices(new SqlConnection($"Data Source={SSISServerName};Initial Catalog=master;Integrated Security=SSPI;")).Catalogs["SSISDB"].Folders[SSISFolderName].Projects[SSISProjectName];
            EnvironmentReference referenceid = NorthwindETL.References[new EnvironmentReference.Key("Release", ".")];
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
            try
            {
                executionid = InitialLoad.Execute(false, referenceid, setValueParameters);
                Console.WriteLine($"Execution ID {executionid.ToString()}");
            }
            catch (Exception e)
            {
                Assert.Fail($"Failed launch SSIS package {InitialLoad.Name} with error: \"{e.Message}\"");
            }
        }
    }
}
