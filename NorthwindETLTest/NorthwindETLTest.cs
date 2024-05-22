using Microsoft.SqlServer.Management.IntegrationServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.IO;

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
        private static string workingFolder = "C:\\Users\\zinyk\\source\\repos\\Northwind_BI_Solution";
        private static string ProgramFiles = Environment.GetEnvironmentVariable("ProgramW6432");
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
        private static NorthwindETLDataTest ETLTest = new NorthwindETLDataTest();

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
            System.Diagnostics.Trace.WriteLine($"Initializing NorthwindETLDataTests...");
            ETLTest.TestInitialize();

            string IngestData = $"{workingFolder}\\IngestData";
            string TestData = $"{IngestData}\\TestData";

            CleanupFolder(TestData);
            CleanupFolder($"{workingFolder}\\logs");
            CleanupFolder($"{workingFolder}\\Backup");

            DirectoryInfo FormatFiles = new DirectoryInfo($"{IngestData}\\FormatFiles");
            foreach (var file in FormatFiles.GetFiles("*.fmt"))
            {
                string TableName = Path.GetFileNameWithoutExtension(file.FullName);

                System.Diagnostics.Trace.WriteLine($"Inserting data into [NorthwindLanding].[Landing].[{TableName}]...");
                string Arguments = $"\"[Landing].[{TableName}]\" in \"{IngestData}\\OriginalData\\{TableName}.dat\" -f \"{file.FullName}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -T -h \"TABLOCK\"";
                Callbcp(Arguments);
            }

            for (DateTime CutoffTime = LoadDateInitialEnd; CutoffTime <= LoadDateIncrementalEnd; CutoffTime = CutoffTime.AddDays(1))
            {
                string testDataFolder = $"{TestData}\\{CutoffTime:yyyy-MM-dd}";
                string datFilePath = $"{testDataFolder}\\Customers.dat";

                System.Diagnostics.Trace.WriteLine($"Creating {testDataFolder}...");
                Directory.CreateDirectory(testDataFolder);

                string sqlQuery =
                    $"\"SELECT DISTINCT C.[CustomerID]" +
                    $", [CompanyName]" +
                    $", [ContactName]" +
                    $", [ContactTitle]" +
                    $", [City]" +
                    $", [Country]" +
                    $", [Phone]" +
                    $", [Fax]" +
                    $" FROM [Landing].[Customers] AS C" +
                    $" INNER JOIN [Landing].[Orders] AS O ON C.[CustomerID] = O.[CustomerID]" +
                    $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})\"";

                System.Diagnostics.Trace.WriteLine($"Coping data to {datFilePath}...");
                if (CutoffTime == new DateTime(1998, 1, 3))
                {
                    string sqlExpression = "UPDATE [Landing].[Customers] " +
                        "SET [City] = N'Moscow', [Country] = N'Russia', [CompanyName] = REVERSE( [CompanyName] ) " +
                        "WHERE [CustomerID] = N'FRANK';";
                    ExecuteSqlCommand(sqlExpression);
                }
                Callbcp($"{sqlQuery} queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");

                datFilePath = $"{testDataFolder}\\Employees.dat";
                sqlQuery =
                    $"\"SELECT DISTINCT E.[EmployeeID]" +
                    $", [LastName]" +
                    $", [FirstName]" +
                    $", [Title]" +
                    $", [TitleOfCourtesy]" +
                    $", [City]" +
                    $", [Country]" +
                    $" FROM [Landing].[Employees] AS E" +
                    $" INNER JOIN [Landing].[Orders] AS O ON E.[EmployeeID] = O.[EmployeeID]" +
                    $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})\"";

                System.Diagnostics.Trace.WriteLine($"Coping data to {datFilePath}...");
                if (CutoffTime == new DateTime(1998, 1, 2))
                {
                    string sqlExpression = "UPDATE [Landing].[Employees]" +
                        " SET[City] = N'Moscow', [Country] = N'Russia'" +
                        " WHERE[EmployeeID] = 2; ";
                    ExecuteSqlCommand(sqlExpression);
                }
                if (CutoffTime == new DateTime(1998, 1, 3))
                {
                    string sqlExpression = "UPDATE [Landing].[Employees]" +
                        " SET [City] = N'Tacoma', [Country] = N'USA'" +
                        " WHERE[EmployeeID] = 2; ";
                    ExecuteSqlCommand(sqlExpression);
                }
                Callbcp($"{sqlQuery} queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
            }
        }

        [TestMethod]
        public void NorthwindTest()
        {
            System.Diagnostics.Trace.WriteLine($"Executing Initial load.dtsx...");
            //ExecuteLoadPackage("Initial Load.dtsx", LoadDateInitialEnd);

            //for (DateTime CutoffTime = LoadDateInitialEnd.AddDays(1); CutoffTime <= LoadDateIncrementalEnd; CutoffTime = CutoffTime.AddDays(1))
            //{
            //    System.Diagnostics.Trace.WriteLine($"Initializing Incremental Load.dtsx with CutoffTime = {CutoffTime:yyyy-MM-dd}...");
            //    ExecuteLoadPackage("Incremental Load.dtsx", CutoffTime);

            //    if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            //    {
            //        System.Diagnostics.Trace.WriteLine($"Executing EmployeeSCD2TestStage1 test...");
            //        ETLTest.EmployeeSCD2TestStage1();
            //    }
            //    if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            //    {
            //        System.Diagnostics.Trace.WriteLine($"Executing ProductSCD1TestStage1 test...");
            //        ETLTest.ProductSCD1TestStage1();
            //    }
            //    if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            //    {
            //        System.Diagnostics.Trace.WriteLine($"Executing EmployeeSCD2TestStage2 test...");
            //        ETLTest.EmployeeSCD2TestStage2();
            //    }
            //    if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            //    {
            //        System.Diagnostics.Trace.WriteLine($"Executing CustomerSCD2TestStage1 test...");
            //        ETLTest.CustomerSCD2TestStage1();
            //    }
            //    if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            //    {
            //        System.Diagnostics.Trace.WriteLine($"Executing ProductSCD1TestStage2 test...");
            //        ETLTest.ProductSCD1TestStage2();
            //    }
            //}
        }

        private static void ExecuteLoadPackage(string PackageName, DateTime CutoffTime)
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
        
        private static void CleanupFolder(string FolderPath)
        {
            System.Diagnostics.Trace.WriteLine($"Cleaning up {FolderPath}");
            DirectoryInfo TestData = new DirectoryInfo(FolderPath);
            foreach (var subDir in TestData.GetDirectories())
            {
                if (subDir.Exists)
                {
                    System.Diagnostics.Trace.WriteLine($"Deleteing {subDir.FullName}");
                    subDir.Delete(true);
                }
            }
        }

        private static void Callbcp(string Arguments)
        {
            System.Diagnostics.Process myProcess = new System.Diagnostics.Process();
            myProcess.StartInfo.FileName = $"{ProgramFiles}\\Microsoft SQL Server\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe";
            myProcess.StartInfo.Arguments = Arguments;
            myProcess.StartInfo.UseShellExecute = false;
            myProcess.StartInfo.RedirectStandardOutput = true;
            myProcess.StartInfo.RedirectStandardError = true;
            myProcess.Start();

            string ErrorOutput = myProcess.StandardError.ReadToEnd();
            string StandartOutput = myProcess.StandardOutput.ReadToEnd();

            if (myProcess.ExitCode != 0)
            {
                //Dts.Events.FireError(18, $"{TestName}", $"{ErrorOutput}\r\n{StandartOutput}", String.Empty, 0);
                System.Diagnostics.Trace.WriteLine($"{ErrorOutput}\r\n{StandartOutput}");
            }
            else
            {
                //bool fireAgain = false;
                //Dts.Events.FireInformation(3, $"{TestName}", $"{StandartOutput}", String.Empty, 0, ref fireAgain);
                System.Diagnostics.Trace.WriteLine(StandartOutput);
            }
        }

        private static void ExecuteSqlCommand(string sqlExpression)
        {
            string connectionString = $"Data Source={Environment.MachineName};Initial Catalog=NorthwindLanding;Integrated Security=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                connection.Close();
            }
        }
    }
}
