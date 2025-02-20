using Microsoft.SqlServer.Management.IntegrationServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NorthwindDWTest;
using NorthwindLogsTest;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace FunctionalETLTest
{
    [TestClass]
    public class FunctionalETLTestClass
    {
        private static DateTime LoadDateInitialEnd;
        private static DateTime LoadDateIncrementalEnd;
        private static string ExternalFilesPath;
        private static string XMLCalendarFolder;
        private static string BuildConfiguration;

        private static string SQLServerFiles;
        private static NorthwindDWDataTest DWDataTest;
        private static NorthwindLogsDataTest LogsDataTest;
        private static readonly string SSISServerName = Environment.MachineName;
        private static readonly string SSISDatabaseName = "SSISDB";
        private static readonly string SSISFolderName = "NorthwindBI";
        private static readonly string SSISProjectName = "NorthwindETL";
        private static string TestData;

        private TestContext testContextInstance;

        public FunctionalETLTestClass(TestContext testContextInstance) => this.testContextInstance = testContextInstance;

        static bool testPassed;

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

        [ClassInitialize]
        public static void ClassInitialize(TestContext TestContext)
        {
            System.Diagnostics.Trace.WriteLine("**********Started class initialize**********");
            testPassed = true;

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Setting test context...");
            LoadDateInitialEnd = DateTime.Parse((string)TestContext.Properties["LoadDateInitialEnd"]);
            LoadDateIncrementalEnd = DateTime.Parse((string)TestContext.Properties["LoadDateIncrementalEnd"]);
            SQLServerFiles = (string)TestContext.Properties["SQLServerFiles"];
            BuildConfiguration = (string)TestContext.Properties["BuildConfiguration"];
            string DBFilesPath = (string)TestContext.Properties["DBFilesPath"];
            ExternalFilesPath = (string)TestContext.Properties["ExternalFilesPath"];
            XMLCalendarFolder = (string)TestContext.Properties["XMLCalendarFolder"];
            string IngestData = $"{ExternalFilesPath}\\IngestData";
            TestData = $"{IngestData}\\TestData";

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Checking parameters...");
            if (LoadDateInitialEnd > LoadDateIncrementalEnd)
            {
                Assert.Fail($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] LoadDateInitialEnd > LoadDateIncrementalEnd");
            }

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring TestData folder...");
            Directory.CreateDirectory(TestData);
            CleanupFolder(TestData);

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring Backup folder...");
            Directory.CreateDirectory($"{ExternalFilesPath}\\Backup");
            CleanupFolder($"{ExternalFilesPath}\\Backup");
            Directory.CreateDirectory($"{ExternalFilesPath}\\Backup\\ReadOnly");

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring logs folder...");
            Directory.CreateDirectory($"{ExternalFilesPath}\\logs");
            CleanupFolder($"{ExternalFilesPath}\\logs");

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring no change files...");
            Directory.CreateDirectory($"{ExternalFilesPath}\\NoChange");
            CreateCSVFileEncodedASCII($"{ExternalFilesPath}\\NoChange\\Customer.csv");
            CreateCSVFileEncodedASCII($"{ExternalFilesPath}\\NoChange\\Employee.csv");
            CreateCSVFileEncodedASCII($"{ExternalFilesPath}\\NoChange\\Product.csv");

            //Creating logins, roles, users
            if (BuildConfiguration != "Release")
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating SQL server logins...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {Environment.MachineName}" +
                    $" -d master" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateLogins.sql\"" +
                    $" -v DWHServerName=\"{Environment.MachineName}\""
                );

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating databases roles...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {Environment.MachineName}" +
                    $" -d MDS" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateRoles.sql\"" +
                    $" -v MDSDatabaseName=\"MDS\""
                );

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating databases users...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {Environment.MachineName}" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateUsers.sql\"" +
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
            if (BuildConfiguration != "Release")
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preparing SSIS environment...");

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Deleteing {BuildConfiguration} SSIS environment...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -Q \"EXECUTE [catalog].[delete_environment]" +
                    $" @folder_name = N'{SSISFolderName}'," +
                    $" @environment_name = N'{BuildConfiguration}'"
                );

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating {BuildConfiguration} SSIS environment...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateEnvironment.sql\"" +
                    $" -v DBFilesPath=\"{SQLServerFiles}\\{DBFilesPath}\"" +
                    $" DQS_STAGING_DATA_DatabaseName=\"DQS_STAGING_DATA\"" +
                    $" DQS_STAGING_DATA_ServerName=\"{Environment.MachineName}\"" +
                    $" DQSServerName=\"{Environment.MachineName}\"" +
                    $" DWHDatabaseName=\"NorthwindDW\"" +
                    $" DWHServerName=\"{Environment.MachineName}\"" +
                    $" ExternalFilesPath=\"{ExternalFilesPath}\"" +
                    $" LogsDatabaseName=\"NorthwindLogs\"" +
                    $" LogsServerName=\"{Environment.MachineName}\"" +
                    $" MDSDatabaseName=\"MDS\"" +
                    $" MDSServerName=\"{Environment.MachineName}\"" +
                    $" RetrainWeeks=\"3\"" +
                    $" SSISDatabaseName=\"{SSISDatabaseName}\"" +
                    $" BuildConfiguration=\"{BuildConfiguration}\"" +
                    $" SSISFolderName=\"{SSISFolderName}\"" +
                    $" SSISProjectName=\"{SSISProjectName}\"" +
                    $" SSISServerName=\"{SSISServerName}\"" +
                    $" XMLCalendarFolder=\"{XMLCalendarFolder}\"" +
                    $" LandingDatabaseName=\"NorthwindLanding\"" +
                    $" LandingServerName=\"{Environment.MachineName}\"" +
                    $" CutoffTime=\"1997-12-31\"" +
                    $" LoadDateInitialEnd=\"1997-12-31\""
                );

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Mapping {BuildConfiguration} SSIS environment with NorthwindETL project...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\SetEnvironmentVars.sql\"" +
                    $" -v  BuildConfiguration=\"{BuildConfiguration}\"" +
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
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating {testDataFolder}");
                Directory.CreateDirectory(testDataFolder);

                PrepareCustomersTestData(CutoffTime, testDataFolder);
                PrepareEmployeesTestData(CutoffTime, testDataFolder);
                PrepareProductsTestData(CutoffTime, testDataFolder);
                PrepareCategoriesTestData(CutoffTime, testDataFolder);
                PrepareOrdersTestData(CutoffTime, testDataFolder);
                PrepareOrderDetailsTestData(CutoffTime, testDataFolder);
            }

            //Cleaning up NorthwindLanding
            sqlExpression = "EXECUTE [Landing].[TruncateLanding]";
            ExecuteSqlCommand(sqlExpression);

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing NorthwindDWTests...");
            SqlConnectionStringBuilder sqlConnectionString = new SqlConnectionStringBuilder
            {
                ApplicationName = "FunctionalETLTest",
                DataSource = Environment.MachineName,
                InitialCatalog = (string)TestContext.Properties["DWHDatabaseName"],
                IntegratedSecurity = true,
                PersistSecurityInfo = false,
                Pooling = false,
                MultipleActiveResultSets = false,
                Encrypt = true,
                TrustServerCertificate = true
            };
            DWDataTest = new NorthwindDWDataTest(sqlConnectionString.ToString());
            DWDataTest.TestInitialize();

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing NorthwindLogsTests...");
            sqlConnectionString.InitialCatalog = (string)TestContext.Properties["LogsDatabaseName"];
            LogsDataTest = new NorthwindLogsDataTest(sqlConnectionString.ToString());
            LogsDataTest.TestInitialize();

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating Event session...");
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                $"-S {Environment.MachineName}" +
                $" -d master" +
                $" -i \"{ExternalFilesPath}\\Scripts\\CreateEventSession.sql\"" +
                $" -v ExternalFilesPath=\"{ExternalFilesPath}\""
            );

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Starting Event session...");
            ExecuteSqlCommand(
                "ALTER EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER\r\n    STATE = START;",
                "NorthwindLogs");

            //System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Starting logman...");
            //CallProcess($"C:\\Windows\\System32\\logman.exe", $"start -n \"SQL Server\" -as", true);

            System.Diagnostics.Trace.WriteLine("**********Finished class initialize**********");
        }

        [ClassCleanup(ClassCleanupBehavior.EndOfClass)]
        public static void ClassCleanup()
        {
            System.Diagnostics.Trace.WriteLine("**********Started class cleanup**********");

            //System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Stopping logman...");
            //CallProcess($"C:\\Windows\\System32\\logman.exe", $"stop -n \"SQL Server\" -as", true);

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Stopping Event session...");
            ExecuteSqlCommand(
                "ALTER EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER\r\n    STATE = STOP;",
                $"NorthwindLogs");

            if (testPassed)
            {
                CleanupFolder(TestData);
                CleanupFolder($"{ExternalFilesPath}\\Backup");
            }

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up NorthwindDWTests...");
            DWDataTest.TestCleanup();

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up NorthwindLogsTests...");
            LogsDataTest.TestCleanup();

            System.Diagnostics.Trace.WriteLine("**********Finished class cleanup**********");
        }

        [TestCleanup]
        public void TestCleanup()
        {
            if (this.testContextInstance.CurrentTestOutcome == 0)
            {
                testPassed = false;
            }
        }

        [TestMethod]
        public void FunctionalETLTest()
        {
            System.Diagnostics.Trace.WriteLine($"**********Started FunctionalETLTest**********");
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Updating partition schema...");
            DWDataTest.UpdatePartitionSchema();

            for (DateTime CutoffTime = LoadDateInitialEnd; CutoffTime <= LoadDateIncrementalEnd; CutoffTime = CutoffTime.AddDays(1))
            {
                if (CutoffTime != new DateTime(1998, 1, 5, 0, 0, 0))
                {
                    try
                    {
                        NorthwindBITransformAndLoadJod(CutoffTime);
                    }
                    catch (Exception e)
                    {
                        Assert.Fail(e.Message);
                    }
                }
                else
                {
                    try
                    {
                        NorthwindBITransformAndLoadJod(CutoffTime);
                        Assert.Fail($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] OnError event handler was not call");
                    }
                    catch
                    {
                        LogsDataTest.EventHandlersOnErrorDataTest();
                    }
                }

                if (CutoffTime == new DateTime(1997, 12, 31, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing CutoffTimeTest...");
                    DWDataTest.CutoffTimeTest();
                }

                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage1...");
                    DWDataTest.EmployeeSCD2TestStage1();
                }
                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing ProductSCD1TestStage1...");
                    DWDataTest.ProductSCD1TestStage1();
                }

                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage1...");
                    DWDataTest.UnknownMemberTest();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage2...");
                    DWDataTest.EmployeeSCD2TestStage2();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing CustomerSCD2TestStage1...");
                    DWDataTest.CustomerSCD2TestStage1();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing ProductSCD1TestStage2...");
                    DWDataTest.ProductSCD1TestStage2();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing PartitionsManagingTest...");
                    DWDataTest.PartitionsManagingTest();
                }

                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing OrderShippingDateTest...");
                DWDataTest.OrderShippingDateTest();
            }

            System.Diagnostics.Trace.WriteLine("**********Finished FunctionalETLTest**********");
        }

        private void NorthwindBITransformAndLoadJod(DateTime CutoffTime)
        {
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********CUTOFF TIME = {CutoffTime:yyyy-MM-dd HH:mm:ss.fffffff}**********");
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********STEP TRANSFORM AND LOAD**********");
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing Transform and load.dtsx...");
            var setValueParameters = new Collection<PackageInfo.ExecutionValueParameterSet>
            {
                new PackageInfo.ExecutionValueParameterSet
                {
                    ObjectType = 30,
                    ParameterName = "CutoffTime",
                    ParameterValue = CutoffTime
                },
                new PackageInfo.ExecutionValueParameterSet
                {
                    ObjectType = 30,
                    ParameterName = "LoadDateInitialEnd",
                    ParameterValue = LoadDateInitialEnd
                }
            };
            ExecuteDtsxInSSISDB("Transform and load.dtsx", setValueParameters);

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********STEP DWH MAINTENANCE**********");
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing Maintenance Plans\\NorthwindBI\\DWH Maintenance...");
            CallProcess(
                "C:\\Program Files\\Microsoft SQL Server\\160\\DTS\\Binn\\DTExec.exe",
                $"/SQL \"\\\"Maintenance Plans\\NorthwindBI\\\"\" /SERVER {Environment.MachineName} /CHECKPOINTING OFF /SET \"\\\"\\Package\\DWH Maintenance.Disable\\\"\";false /REPORTING E");

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********STEP COPY DATABASEFILES INFO**********");
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing Maintenance copy DatabaseFiles.dtsx...");
            setValueParameters.Clear();
            ExecuteDtsxInSSISDB("Maintenance copy DatabaseFiles.dtsx", setValueParameters);
        }

        private void ExecuteDtsxInSSISDB(string PackgeName, Collection<PackageInfo.ExecutionValueParameterSet> setValueParameters)
        {
            Catalog SSISDB = new IntegrationServices(new SqlConnection($"Data Source={Environment.MachineName};Initial Catalog=master;Integrated Security=SSPI;")).Catalogs[SSISDatabaseName];
            ProjectInfo NorthwindETL = SSISDB.Folders[SSISFolderName].Projects[SSISProjectName];
            EnvironmentReference referenceid = NorthwindETL.References[new EnvironmentReference.Key(BuildConfiguration, ".")];
            Int64 executionid;

            PackageInfo package = NorthwindETL.Packages[PackgeName];
            try
            {
                if (setValueParameters.Count > 0)
                {
                    executionid = package.Execute(false, referenceid, setValueParameters);
                }
                else
                {
                    executionid = package.Execute(false, referenceid);
                }
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] {package.Name} execution ID {executionid}");

                ExecutionOperation operation = SSISDB.Executions[executionid];

                while (!operation.Completed)
                {
                    operation.Refresh();
                    System.Threading.Thread.Sleep(500);
                }
            }
            catch (Exception e)
            {
                throw new ArgumentException($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Failed launch SSIS package {package.Name} with error: \"{e.Message}\"");
            }

            string catalogExecutions = SSISDB.Executions[new ExecutionOperation.Key(executionid)].Status.ToString();

            if (catalogExecutions == "Failed")
            {
                throw new ArgumentException($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing SSIS package {package.Name} status - {catalogExecutions}");
            }
            else
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing SSIS package {package.Name} status - {catalogExecutions}");
            }
        }

        private static void CleanupFolder(string FolderPath)
        {
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up {FolderPath}");
            try
            {
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
            catch (Exception e)
            {
                System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up {FolderPath} failed with error: \"{e}\"");
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
            string connectionString =
                $"Data Source={Environment.MachineName};" +
                $"Initial Catalog={InitialCatalog};" +
                $"Integrated Security=SSPI;";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                command.ExecuteNonQuery();
                connection.Close();
            }
        }

        private static void PrepareCustomersTestData(DateTime CutoffTime, string testDataFolder)
        {
            string sqlExpression;
            string datFilePath = $"{testDataFolder}\\Customers.dat";
            string sqlQuery =
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
            if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Customers] " +
                    "SET [City] = N'Moscow', [Country] = N'Russia', [CompanyName] = REVERSE( [CompanyName] ) " +
                    "WHERE [CustomerID] = N'FRANK';";
                ExecuteSqlCommand(sqlExpression);
            }
            if (CutoffTime == new DateTime(1998, 1, 5, 0, 0, 0))
            {
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
                    $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})" +
                    $" UNION ALL" +
                    $" SELECT DISTINCT C.[CustomerID]" +
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
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");

        }

        private static void PrepareEmployeesTestData(DateTime CutoffTime, string testDataFolder)
        {
            string sqlExpression;
            string datFilePath = $"{testDataFolder}\\Employees.dat";
            string sqlQuery =
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
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Employees]" +
                    " SET[City] = N'Moscow', [Country] = N'Russia'" +
                    " WHERE[EmployeeID] = 2; ";
                ExecuteSqlCommand(sqlExpression);
            }
            if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Employees]" +
                    " SET [City] = N'Tacoma', [Country] = N'USA'" +
                    " WHERE[EmployeeID] = 2; ";
                ExecuteSqlCommand(sqlExpression);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");

        }

        private static void PrepareProductsTestData(DateTime CutoffTime, string testDataFolder)
        {
            string sqlExpression;
            string datFilePath = $"{testDataFolder}\\Products.dat";
            string sqlQuery =
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
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
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

        private static void PrepareCategoriesTestData(DateTime CutoffTime, string testDataFolder)
        {
            string sqlExpression;
            string datFilePath = $"{testDataFolder}\\Categories.dat";
            string sqlQuery =
                $"SELECT [CategoryID]" +
                $", [CategoryName]" +
                $", [Description]" +
                $" FROM [Landing].[Categories]";

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
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

        private static void PrepareOrdersTestData(DateTime CutoffTime, string testDataFolder)
        {
            string sqlExpression;
            string datFilePath = $"{testDataFolder}\\Orders.dat";
            string sqlQuery =
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
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Orders] " +
                    "SET [EmployeeID] = 99" +
                    ", [CustomerID] = 999" +
                    "WHERE [OrderID] = 10812;";
                ExecuteSqlCommand(sqlExpression);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
        }

        private static void PrepareOrderDetailsTestData(DateTime CutoffTime, string testDataFolder)
        {
            string sqlExpression;
            string datFilePath = $"{testDataFolder}\\Order Details.dat";
            string sqlQuery =
                $"SELECT OD.[OrderID]" +
                $", [ProductID]" +
                $", [UnitPrice]" +
                $", [Quantity]" +
                $", [Discount]" +
                $" FROM [Landing].[Order Details] AS OD" +
                $" INNER JOIN [Landing].[Orders] AS O ON O.[OrderID] = OD.[OrderID]" +
                $" AND O.[OrderDate] <= DATEFROMPARTS({CutoffTime.Year}, {CutoffTime.Month}, {CutoffTime.Day})";

            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Order Details] " +
                    "SET [ProductID] = 999" +
                    "WHERE [OrderID] = 10812" +
                    " AND [ProductID] = 31;";
                ExecuteSqlCommand(sqlExpression);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{Environment.MachineName}\" -d \"NorthwindLanding\" -x -c -T");
        }

        private static void CreateCSVFileEncodedASCII(string FilePath)
        {
            using (FileStream fs = File.Create(FilePath, 1024))
            {
                byte[] info = new ASCIIEncoding().GetBytes("");
                fs.Write(info, 0, info.Length);
            }
        }
    }
}
