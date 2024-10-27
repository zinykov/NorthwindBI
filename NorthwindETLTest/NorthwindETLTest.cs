using Microsoft.SqlServer.Management.IntegrationServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.IO;

namespace NorthwindETLTest
{
    [TestClass]
    public class NorthwindETLTest
    {
        private static DateTime LoadDateInitialEnd;
        private static DateTime LoadDateIncrementalEnd;
        private static string workingFolder;
        private static string SSISEnvironmentName;

        private static string SQLServerFiles;
        private static NorthwindETLDataTest ETLTest = new NorthwindETLDataTest();
        private static string SSISServerName = Environment.MachineName;
        private static string SSISDatabaseName = "SSISDB";
        private static string SSISFolderName = "NorthwindBI";
        private static string SSISProjectName = "NorthwindETL";

        private TestContext testContextInstance;

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

        [TestInitialize()]
        public void TestInitialize()
        {
            System.Diagnostics.Trace.WriteLine("**********Started test initialize**********");

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Setting test context...");
            LoadDateInitialEnd = DateTime.Parse((string)testContextInstance.Properties["LoadDateInitialEnd"]);
            LoadDateIncrementalEnd = DateTime.Parse((string)testContextInstance.Properties["LoadDateIncrementalEnd"]);
            SQLServerFiles = (string)testContextInstance.Properties["SQLServerFiles"];
            SSISEnvironmentName = (string)testContextInstance.Properties["SSISEnvironmentName"];
            string DBFilesPath = (string)testContextInstance.Properties["DBFilesPath"];
            string reposFolder = (string)testContextInstance.Properties["reposFolder"];
            workingFolder = $"{reposFolder}Northwind_BI_Solution";

            string IngestData = $"{workingFolder}\\IngestData";
            string TestData = $"{IngestData}\\TestData";

            Directory.CreateDirectory($"{workingFolder}\\Backup");

            //Cleaning up folders
            CleanupFolder(TestData);
            CleanupFolder($"{workingFolder}\\Backup");

            //Creating logins, roles, users
            if (SSISEnvironmentName == "Debug")
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating SQL server logins...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {Environment.MachineName}" +
                    $" -d master" +
                    $" -i \"{workingFolder}\\Scripts\\CreateLogins.sql\"" +
                    $" -v DWHServerName=\"{Environment.MachineName}\""
                );

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating databases roles...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {Environment.MachineName}" +
                    $" -d MDS" +
                    $" -i \"{workingFolder}\\Scripts\\CreateRoles.sql\"" +
                    $" -v MDSDatabaseName=\"MDS\""
                );

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating databases users...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {Environment.MachineName}" +
                    $" -i \"{workingFolder}\\Scripts\\CreateUsers.sql\"" +
                    $" -v DWHDatabaseName=\"NorthwindDW\"" +
                    $" DWHServerName=\"{Environment.MachineName}\"" +
                    $" DQS_STAGING_DATA_DatabaseName=\"DQS_STAGING_DATA\"" +
                    $" DQS_STAGING_DATA_ServerName=\"{Environment.MachineName}\"" +
                    $" LogsDatabaseName=\"NorthwindLogs\"" +
                    $" LogsServerName=\"{Environment.MachineName}\"" +
                    $" MDSDatabaseName=\"MDS\"" +
                    $" MDSServerName=\"{Environment.MachineName}\"" +
                    $" LandingDatabaseName=\"NorthwindLanding\"" +
                    $" LandingServerName=\"{Environment.MachineName}\""
                );
            }

            //Preparing SSIS environment
            if (SSISEnvironmentName == "Debug")
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preparing SSIS environment...");

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Deleteing debug environment...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -Q \"EXECUTE [catalog].[delete_environment]" +
                    $" @folder_name = N'{SSISFolderName}'," +
                    $" @environment_name = N'Debug';");

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating SSIS environment...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -i \"{workingFolder}\\Scripts\\CreateEnvironment.sql\"" +
                    $" -v BackupFilesPath=\"{workingFolder}\\Backup\\\"" +
                    $" DBFilesPath=\"{SQLServerFiles}\\{DBFilesPath}\"" +
                    $" DQS_STAGING_DATA_DatabaseName=\"DQS_STAGING_DATA\"" +
                    $" DQS_STAGING_DATA_ServerName=\"{Environment.MachineName}\"" +
                    $" DQSServerName=\"{Environment.MachineName}\"" +
                    $" DWHDatabaseName=\"NorthwindDW\"" +
                    $" DWHServerName=\"{Environment.MachineName}\"" +
                    $" ExternalFilesPath=\"{workingFolder}\\\"" +
                    $" LogsDatabaseName=\"NorthwindLogs\"" +
                    $" LogsServerName=\"{Environment.MachineName}\"" +
                    $" MDSDatabaseName=\"MDS\"" +
                    $" MDSServerName=\"{Environment.MachineName}\"" +
                    $" RetrainWeeks=\"3\"" +
                    $" SSISDatabaseName=\"{SSISDatabaseName}\"" +
                    $" SSISEnvironmentName=\"{SSISEnvironmentName}\"" +
                    $" SSISFolderName=\"{SSISFolderName}\"" +
                    $" SSISProjectName=\"{SSISProjectName}\"" +
                    $" SSISServerName=\"{SSISServerName}\"" +
                    $" XMLCalendarFolder=\"{reposFolder}XMLCalendar\\\"" +
                    $" LandingDatabaseName=\"NorthwindLanding\"" +
                    $" LandingServerName=\"{Environment.MachineName}\""
                );

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Setting SSIS environment...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -i \"{workingFolder}\\Scripts\\SetEnvironmentVars.sql\"" +
                    $" -v  SSISEnvironmentName=\"{SSISEnvironmentName}\"" +
                    $" SSISFolderName=\"{SSISFolderName}\"" +
                    $" SSISProjectName=\"{SSISProjectName}\""
                );
            }

            //load data into landing zone
            DirectoryInfo FormatFiles = new DirectoryInfo($"{IngestData}\\FormatFiles");
            foreach (var file in FormatFiles.GetFiles("*.fmt"))
            {
                string TableName = Path.GetFileNameWithoutExtension(file.FullName);

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Inserting data into [NorthwindLanding].[Landing].[{TableName}]...");
                string Arguments = $"\"[Landing].[{TableName}]\" in \"{IngestData}\\OriginalData\\{TableName}.dat\" -f \"{file.FullName}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -T -h \"TABLOCK\"";
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe", Arguments);
            }

            string sqlExpression;

            //iterate dates between start(initial) and end(incremental) dates
            for (DateTime CutoffTime = LoadDateInitialEnd; CutoffTime <= LoadDateIncrementalEnd; CutoffTime = CutoffTime.AddDays(1))
            {
                string testDataFolder = $"{TestData}\\{CutoffTime:yyyy-MM-dd}";
                string datFilePath;
                string sqlQuery;
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating {testDataFolder}");
                Directory.CreateDirectory(testDataFolder);

                // Prepare Customers test data
                {
                    datFilePath = $"{testDataFolder}\\Customers.dat";
                    sqlQuery =
                        $"SELECT DISTINCT C.[CustomerID]" +
                        $", [CompanyName]" +
                        $", [ContactName]" +
                        $", [ContactTitle]" +
                        $", [City]" +
                        $", [Country]" +
                        $", [Phone]" +
                        $", [Fax]" +
                        $" FROM [Landing].[Customers] AS C" +
                        $" INNER JOIN [Landing].[Orders] AS O ON C.[CustomerID] = O.[CustomerID]" +
                        $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})";

                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
                    if (CutoffTime == new DateTime(1998, 1, 3))
                    {
                        sqlExpression = "UPDATE [Landing].[Customers] " +
                            "SET [City] = N'Moscow', [Country] = N'Russia', [CompanyName] = REVERSE( [CompanyName] ) " +
                            "WHERE [CustomerID] = N'FRANK';";
                        ExecuteSqlCommand(sqlExpression);
                    }
                    CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                        $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
                }

                // Prepare Employees test data
                {
                    datFilePath = $"{testDataFolder}\\Employees.dat";
                    sqlQuery =
                        $"SELECT DISTINCT E.[EmployeeID]" +
                        $", [LastName]" +
                        $", [FirstName]" +
                        $", [Title]" +
                        $", [TitleOfCourtesy]" +
                        $", [City]" +
                        $", [Country]" +
                        $" FROM [Landing].[Employees] AS E" +
                        $" INNER JOIN [Landing].[Orders] AS O ON E.[EmployeeID] = O.[EmployeeID]" +
                        $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})";

                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
                    if (CutoffTime == new DateTime(1998, 1, 2))
                    {
                        sqlExpression = "UPDATE [Landing].[Employees]" +
                            " SET[City] = N'Moscow', [Country] = N'Russia'" +
                            " WHERE[EmployeeID] = 2; ";
                        ExecuteSqlCommand(sqlExpression);
                    }
                    if (CutoffTime == new DateTime(1998, 1, 3))
                    {
                        sqlExpression = "UPDATE [Landing].[Employees]" +
                            " SET [City] = N'Tacoma', [Country] = N'USA'" +
                            " WHERE[EmployeeID] = 2; ";
                        ExecuteSqlCommand(sqlExpression);
                    }
                    CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                        $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
                }

                // Prepare Products test data
                {
                    datFilePath = $"{testDataFolder}\\Products.dat";
                    sqlQuery =
                        $"SELECT DISTINCT P.[ProductID]" +
                        $", [ProductName]" +
                        $", [SupplierID]" +
                        $", [CategoryID]" +
                        $", P.[UnitPrice]" +
                        $" FROM[Landing].[Products] AS P" +
                        $" INNER JOIN [Landing].[Order Details] AS OD ON P.[ProductID] = OD.[ProductID]" +
                        $" INNER JOIN [Landing].[Orders] AS O ON OD.[OrderID] = O.[OrderID]" +
                        $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})";

                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
                    if (CutoffTime == new DateTime(1998, 1, 2))
                    {
                        sqlExpression =
                            "UPDATE [Landing].[Products]" +
                            " SET [ProductName] = REVERSE( [ProductName] ), [CategoryID] = 2" +
                            " WHERE[ProductID] = 2;";
                        ExecuteSqlCommand(sqlExpression);
                    }
                    CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                        $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
                }

                // Prepare Categories test data
                {
                    datFilePath = $"{testDataFolder}\\Categories.dat";
                    sqlQuery =
                        $"SELECT [CategoryID]" +
                        $", [CategoryName]" +
                        $", [Description]" +
                        $" FROM [Landing].[Categories]";

                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
                    if (CutoffTime == new DateTime(1998, 1, 3))
                    {
                        sqlExpression =
                            "UPDATE [Landing].[Categories]" +
                            " SET [CategoryName] = REVERSE( [CategoryName] )" +
                            " WHERE[CategoryID] = 2;";
                        ExecuteSqlCommand(sqlExpression);
                    }
                    CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                        $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
                }

                // Prepare Orders test data
                {
                    datFilePath = $"{testDataFolder}\\Orders.dat";
                    sqlQuery =
                        $"SELECT [OrderID]" +
                        $", [CustomerID]" +
                        $", [EmployeeID]" +
                        $", [OrderDate]" +
                        $", [RequiredDate]" +
                        $", CASE WHEN [ShippedDate] > DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day}) THEN NULL ELSE [ShippedDate] END AS [ShippedDate]" +
                        $", [ShipCity]" +
                        $", [ShipCountry]" +
                        $" FROM [Landing].[Orders]" +
                        $" WHERE [OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})";

                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
                    CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                        $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
                }

                // Prepare Order Details test data
                {
                    datFilePath = $"{testDataFolder}\\Order Details.dat";
                    sqlQuery =
                        $"SELECT OD.[OrderID]" +
                        $", [ProductID]" +
                        $", [UnitPrice]" +
                        $", [Quantity]" +
                        $", [Discount]" +
                        $" FROM [Landing].[Order Details] AS OD" +
                        $" INNER JOIN [Landing].[Orders] AS O ON O.[OrderID] = OD.[OrderID]" +
                        $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})";

                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
                    CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                        $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
                }
            }

            //Cleaning up NorthwindLanding
            sqlExpression = "EXECUTE [Landing].[TruncateLanding]";
            ExecuteSqlCommand(sqlExpression);

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing NorthwindETLDataTests...");
            ETLTest.TestInitialize();

            //System.Diagnostics.Trace.WriteLine($"Starting perfomance monitor...");
            //CallProcess("logman", "start -name \"SQL\"");

            //System.Diagnostics.Trace.WriteLine($"Starting SQL profiler...");


            System.Diagnostics.Trace.WriteLine("**********Finished test initialize**********");
        }

        [TestCleanup()]
        public void TestCleanup()
        {
            System.Diagnostics.Trace.WriteLine("**********Started test cleanup**********");

            //System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Stoped SQL profiler");

            //System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Stop perfomance monitor");
            //CallProcess("logman", "stop -name \"SQL\"");

            if ((int)testContextInstance.CurrentTestOutcome == 2)
            {
                CleanupFolder($"{workingFolder}\\IngestData\\TestData");
                CleanupFolder($"{workingFolder}\\Backup");
            }
            //if (SSISEnvironmentName == "Debug")
            //{
            //    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] open Monitoring report");
            //    System.Diagnostics.Process.Start($"http://{Environment.MachineName}/Reports/report/Monitoring/Monitoring");
            //}

            System.Diagnostics.Trace.WriteLine("**********Finished test cleanup**********");
        }

        [TestMethod]
        public void NorthwindTest()
        {
            System.Diagnostics.Trace.WriteLine("**********Started test**********");

            string PackageName = "Transform and load.dtsx";

            for (DateTime CutoffTime = LoadDateInitialEnd; CutoffTime <= LoadDateIncrementalEnd; CutoffTime = CutoffTime.AddDays(1))
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing {PackageName} with CutoffTime = {CutoffTime:yyyy-MM-dd}...");
                ExecuteLoadPackage(PackageName, CutoffTime);

                if (CutoffTime == new DateTime(1997, 12, 31, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing CountRowsInDWH test...");
                    ETLTest.CountRowsInDWH();
                }

                if (CutoffTime == new DateTime(1997, 12, 31, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing CutoffTimeTest test...");
                    ETLTest.CutoffTimeTest();
                }

                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage1 test...");
                    ETLTest.EmployeeSCD2TestStage1();
                }
                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing ProductSCD1TestStage1 test...");
                    ETLTest.ProductSCD1TestStage1();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage2 test...");
                    ETLTest.EmployeeSCD2TestStage2();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing CustomerSCD2TestStage1 test...");
                    ETLTest.CustomerSCD2TestStage1();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing ProductSCD1TestStage2 test...");
                    ETLTest.ProductSCD1TestStage2();
                }

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing OrderShippingDateTest test...");
                ETLTest.OrderShippingDateTest();
            }

            System.Diagnostics.Trace.WriteLine("**********Finished test**********");
        }

        private static void ExecuteLoadPackage(string PackageName, DateTime CutoffTime)
        {
            Catalog SSISDB = new IntegrationServices(new SqlConnection($"Data Source={Environment.MachineName};Initial Catalog=master;Integrated Security=SSPI;")).Catalogs[SSISDatabaseName];
            ProjectInfo NorthwindETL = SSISDB.Folders[SSISFolderName].Projects[SSISProjectName];
            EnvironmentReference referenceid = NorthwindETL.References[new EnvironmentReference.Key(SSISEnvironmentName, ".")];
            Int64 executionid = -1;

            PackageInfo package = NorthwindETL.Packages[PackageName];
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

            try
            {
                executionid = package.Execute(false, referenceid, setValueParameters);
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] {package.Name} execution ID {executionid.ToString()}");

                ExecutionOperation operation = SSISDB.Executions[executionid];

                while (!operation.Completed)
                {
                    operation.Refresh();
                    System.Threading.Thread.Sleep(500);
                }
            }
            catch (Exception e)
            {
                Assert.Fail($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Failed launch SSIS package {package.Name} with error: \"{e.Message}\"");
            }

            string catalogExecutions = SSISDB.Executions[new ExecutionOperation.Key(executionid)].Status.ToString();

            if (catalogExecutions == "Failed")
            {
                Assert.Fail($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing SSIS package {package.Name} status - {catalogExecutions}");
            }
            else
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing SSIS package {package.Name} status - {catalogExecutions}");
            }
        }

        private static void CleanupFolder(string FolderPath)
        {
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up {FolderPath}");
            DirectoryInfo TestData = new DirectoryInfo(FolderPath);
            foreach (var subDir in TestData.GetDirectories())
            {
                if (subDir.Exists)
                {
                    subDir.Delete(true);
                }
            }
            foreach (var file in TestData.GetFiles())
            {
                if (file.Exists)
                {
                    file.Delete();
                }
            }
        }

        private static void CallProcess(string FileName, string Arguments)
        {
            System.Diagnostics.Process myProcess = new System.Diagnostics.Process();
            myProcess.StartInfo.FileName = FileName;
            myProcess.StartInfo.Arguments = Arguments;
            myProcess.StartInfo.UseShellExecute = false;
            myProcess.StartInfo.RedirectStandardOutput = true;
            myProcess.StartInfo.RedirectStandardError = true;
            myProcess.Start();

            string ErrorOutput = myProcess.StandardError.ReadToEnd();
            string StandartOutput = myProcess.StandardOutput.ReadToEnd();

            if (myProcess.ExitCode != 0)
            {
                Assert.Fail($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] {ErrorOutput}\r\n{StandartOutput}");
            }
        }

        private static void ExecuteSqlCommand(string sqlExpression, string InitialCatalog = "NorthwindLanding")
        {
            string connectionString = $"Data Source={Environment.MachineName};Initial Catalog={InitialCatalog};Integrated Security=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                command.ExecuteNonQuery();
                connection.Close();
            }
        }
    }
}
