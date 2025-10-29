using Microsoft.SqlServer.Management.IntegrationServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NorthwindDWTest;
using NorthwindLogsTest;
using NorthwindLandingTest;
using DQS_STAGING_DATA_test;
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
        private TestContext testContextInstance;
        private static NorthwindDWDataTest DWDataTest;
        private static NorthwindLogsDataTest LogsDataTest;
        private static NorthwindLandingDataTest LandingDataTest;
        private static DQS_STAGING_DATA_DataTest DQS_STAGING_DATA_Test;

        private static string BuildConfiguration;
        private static string DBFilesPath;
        private static string DQS_STAGING_DATA_DatabaseName;
        private static string DQS_STAGING_DATA_ServerName;
        private static string DQSServerName;
        private static string DWHDatabaseName;
        private static string DWHServerName;
        private static string ExternalFilesPath;
        private static string IngestData;
        private static string LandingDatabaseName;
        private static string LandingServerName;
        private static DateTime LoadDateIncrementalEnd;
        private static DateTime LoadDateInitialEnd;
        private static string LogsDatabaseName;
        private static string LogsServerName;
        private static string MDSDatabaseName;
        private static string MDSServerName;
        private static string PBIRSDatabaseName;
        private static string PBIRSServerName;
        private static string SQLServerFiles;
        private static string SSISDatabaseName;
        private static string SSISFolderName;
        private static string SSISProjectName;
        private static string SSISServerName;
        private static string TestData;
        static bool testPassed;
        private static string XMLCalendarFolder;

        public FunctionalETLTestClass(TestContext testContextInstance) => this.testContextInstance = testContextInstance;

        [ClassInitialize]
        public static void ClassInitialize(TestContext testContextInstance)
        {
            Console.WriteLine("**********Started class initialize**********");
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Setting test context...");
            BuildConfiguration = (string)testContextInstance.Properties["BuildConfiguration"];
            DBFilesPath = (string)testContextInstance.Properties["DBFilesPath"];
            DQS_STAGING_DATA_DatabaseName = (string)testContextInstance.Properties["DQS_STAGING_DATA_DatabaseName"];
            DQS_STAGING_DATA_ServerName = (string)testContextInstance.Properties["DQS_STAGING_DATA_ServerName"];
            DQSServerName = (string)testContextInstance.Properties["DQSServerName"];
            DWHDatabaseName = (string)testContextInstance.Properties["DWHDatabaseName"];
            DWHServerName = (string)testContextInstance.Properties["DWHServerName"];
            ExternalFilesPath = (string)testContextInstance.Properties["ExternalFilesPath"];
            IngestData = $"{ExternalFilesPath}\\IngestData";
            LandingDatabaseName = (string)testContextInstance.Properties["LandingDatabaseName"];
            LandingServerName = (string)testContextInstance.Properties["LandingServerName"];
            LoadDateIncrementalEnd = DateTime.Parse((string)testContextInstance.Properties["LoadDateIncrementalEnd"]);
            LoadDateInitialEnd = DateTime.Parse((string)testContextInstance.Properties["LoadDateInitialEnd"]);
            LogsDatabaseName = (string)testContextInstance.Properties["LogsDatabaseName"];
            LogsServerName = (string)testContextInstance.Properties["LogsServerName"];
            MDSDatabaseName = (string)testContextInstance.Properties["MDSDatabaseName"];
            MDSServerName = (string)testContextInstance.Properties["MDSServerName"];
            PBIRSDatabaseName = (string)testContextInstance.Properties["PBIRSDatabaseName"];
            PBIRSServerName = (string)testContextInstance.Properties["PBIRSServerName"];
            SQLServerFiles = (string)testContextInstance.Properties["SQLServerFiles"];
            SSISDatabaseName = (string)testContextInstance.Properties["SSISDatabaseName"];
            SSISFolderName = (string)testContextInstance.Properties["SSISFolderName"];
            SSISProjectName = (string)testContextInstance.Properties["SSISProjectName"];
            SSISServerName = (string)testContextInstance.Properties["SSISServerName"];
            TestData = $"{IngestData}\\TestData";
            XMLCalendarFolder = (string)testContextInstance.Properties["XMLCalendarFolder"];
            testPassed = true;

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Checking parameters...");
            if (LoadDateInitialEnd > LoadDateIncrementalEnd)
            {
                Assert.Fail($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] LoadDateInitialEnd > LoadDateIncrementalEnd");
            }

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring TestData folder...");
            Directory.CreateDirectory(TestData);
            CleanupFolder(TestData);

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring Backup folder...");
            Directory.CreateDirectory($"{ExternalFilesPath}\\Backup");
            CleanupFolder($"{ExternalFilesPath}\\Backup");
            Directory.CreateDirectory($"{ExternalFilesPath}\\Backup\\ReadOnly");

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring logs folder...");
            Directory.CreateDirectory($"{ExternalFilesPath}\\logs");
            CleanupFolder($"{ExternalFilesPath}\\logs");

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preraring no change files...");
            Directory.CreateDirectory($"{ExternalFilesPath}\\NoChange");
            CreateCSVFileEncodedASCII($"{ExternalFilesPath}\\NoChange\\Customer.csv");
            CreateCSVFileEncodedASCII($"{ExternalFilesPath}\\NoChange\\Employee.csv");
            CreateCSVFileEncodedASCII($"{ExternalFilesPath}\\NoChange\\Product.csv");

            if (BuildConfiguration == "Debug")
            {
                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing NorthwindDWTests...");
                DWDataTest = new NorthwindDWDataTest(testContextInstance);
                DWDataTest.TestInitialize();

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing NorthwindLogsTests...");
                LogsDataTest = new NorthwindLogsDataTest(testContextInstance);
                LogsDataTest.TestInitialize();

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing LandingDataTests...");
                LandingDataTest = new NorthwindLandingDataTest(testContextInstance);
                LandingDataTest.TestInitialize();

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Initializing DQS_STAGING_DATA_Tests...");
                DQS_STAGING_DATA_Test = new DQS_STAGING_DATA_DataTest(testContextInstance);
                DQS_STAGING_DATA_Test.TestInitialize();

                //Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Deploying SSRS Monitoring project...");
                //ReportService.ReportingService2010SoapClient rs = new ReportService();
                //rs.Url = "http://<servername>/ReportServer/ReportService2010.asmx"; // Ensure this matches
                //rs.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials; // Or specify explicit credentials
            }

            if (BuildConfiguration != "Release")
            {
                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating SQL server logins...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {DWHServerName}" +
                    $" -d master" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateLogins.sql\"" +
                    $" -v DWHServerName=\"{DWHServerName}\""
                );

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating databases roles...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {MDSServerName}" +
                    $" -d MDS" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateRoles.sql\"" +
                    $" -v MDSDatabaseName=\"{MDSDatabaseName}\""
                );

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating databases users...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {Environment.MachineName}" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateUsers.sql\"" +
                    $" -v DWHDatabaseName=\"{DWHDatabaseName}\"" +
                    $" DWHServerName=\"{DWHServerName}\"" +
                    $" DQS_STAGING_DATA_DatabaseName=\"{DQS_STAGING_DATA_DatabaseName}\"" +
                    $" DQS_STAGING_DATA_ServerName=\"{DQS_STAGING_DATA_ServerName}\"" +
                    $" LogsDatabaseName=\"{LogsDatabaseName}\"" +
                    $" LogsServerName=\"{LogsServerName}\"" +
                    $" MDSDatabaseName=\"{MDSDatabaseName}\"" +
                    $" MDSServerName=\"{MDSServerName}\"" +
                    $" PBIRSDatabaseName=\"{PBIRSDatabaseName}\"" +
                    $" PBIRSServerName=\"{PBIRSServerName}\"" +
                    $" LandingDatabaseName=\"{LandingDatabaseName}\"" +
                    $" LandingServerName=\"{LandingServerName}\""
                );

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Preparing SSIS environment...");

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Deleteing {BuildConfiguration} SSIS environment...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -Q \"EXECUTE [catalog].[delete_environment]" +
                    $" @folder_name = N'{SSISFolderName}'," +
                    $" @environment_name = N'{BuildConfiguration}'"
                );

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating {BuildConfiguration} SSIS environment...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\CreateEnvironment.sql\"" +
                    $" -v DBFilesPath=\"{SQLServerFiles}\\{DBFilesPath}\"" +
                    $" DQS_STAGING_DATA_DatabaseName=\"{DQS_STAGING_DATA_DatabaseName}\"" +
                    $" DQS_STAGING_DATA_ServerName=\"{DQS_STAGING_DATA_ServerName}\"" +
                    $" DQSServerName=\"{DQSServerName}\"" +
                    $" DWHDatabaseName=\"{DWHDatabaseName}\"" +
                    $" DWHServerName=\"{DWHServerName}\"" +
                    $" ExternalFilesPath=\"{ExternalFilesPath}\"" +
                    $" LogsDatabaseName=\"{LogsDatabaseName}\"" +
                    $" LogsServerName=\"{LogsServerName}\"" +
                    $" MDSDatabaseName=\"{MDSDatabaseName}\"" +
                    $" MDSServerName=\"{MDSServerName}\"" +
                    $" SSISDatabaseName=\"{SSISDatabaseName}\"" +
                    $" BuildConfiguration=\"{BuildConfiguration}\"" +
                    $" SSISFolderName=\"{SSISFolderName}\"" +
                    $" SSISProjectName=\"{SSISProjectName}\"" +
                    $" SSISServerName=\"{SSISServerName}\"" +
                    $" XMLCalendarFolder=\"{XMLCalendarFolder}\"" +
                    $" LandingDatabaseName=\"{LandingDatabaseName}\"" +
                    $" LandingServerName=\"{LandingServerName}\""
                );

                if (BuildConfiguration == "Debug")
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Deploying {SSISProjectName} project...");
                    SqlConnection sqlConnection = new SqlConnection(CreateConnectionString(SSISServerName, "master"));
                    new IntegrationServices(sqlConnection).Catalogs[SSISDatabaseName].Folders[SSISFolderName].DeployProject(
                        SSISProjectName,
                        File.ReadAllBytes($"{ExternalFilesPath}\\{SSISProjectName}\\bin\\{BuildConfiguration}\\{SSISProjectName}.ispac")
                        );
                    sqlConnection.Close();
                }

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Mapping {BuildConfiguration} SSIS environment with NorthwindETL project...");
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                    $"-S {SSISServerName}" +
                    $" -d {SSISDatabaseName}" +
                    $" -i \"{ExternalFilesPath}\\Scripts\\SetEnvironmentVars.sql\"" +
                    $" -v  BuildConfiguration=\"{BuildConfiguration}\"" +
                    $" SSISFolderName=\"{SSISFolderName}\"" +
                    $" SSISProjectName=\"{SSISProjectName}\""
                );
            }

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Loading data into landing zone...");
            DirectoryInfo FormatFiles = new DirectoryInfo($"{IngestData}\\FormatFiles");
            foreach (var file in FormatFiles.GetFiles("*.fmt"))
            {
                string TableName = Path.GetFileNameWithoutExtension(file.FullName);

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Inserting data into [NorthwindLanding].[Landing].[{TableName}]...");
                string Arguments = $"\"[Landing].[{TableName}]\" in \"{IngestData}\\OriginalData\\{TableName}.dat\" -f \"{file.FullName}\" -S \"{LandingServerName}\" -d \"{LandingDatabaseName}\" -T -h \"TABLOCK\"";
                CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe", Arguments);
            }

            string sqlExpression;

            //iterate dates between start(initial) and end(incremental) dates
            for (DateTime CutoffTime = LoadDateInitialEnd; CutoffTime <= LoadDateIncrementalEnd; CutoffTime = CutoffTime.AddDays(1))
            {
                var testDataFolder = BuildConfiguration == "Release" ? $"{IngestData}\\{CutoffTime:yyyy-MM-dd}" : $"{TestData}\\{CutoffTime:yyyy-MM-dd}";
                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating {testDataFolder}");
                Directory.CreateDirectory(testDataFolder);

                PrepareCustomersTestData(CutoffTime, testDataFolder);
                PrepareEmployeesTestData(CutoffTime, testDataFolder);
                PrepareProductsTestData(CutoffTime, testDataFolder);
                PrepareCategoriesTestData(CutoffTime, testDataFolder);
                PrepareOrdersTestData(CutoffTime, testDataFolder);
                PrepareOrderDetailsTestData(CutoffTime, testDataFolder);
            }

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up NorthwindLanding...");
            sqlExpression = "EXECUTE [Landing].[TruncateLanding]";
            ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Creating Event session...");
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\SQLCMD.EXE",
                $"-S {DWHServerName}" +
                $" -d master" +
                $" -i \"{ExternalFilesPath}\\Scripts\\CreateEventSession.sql\"" +
                $" -v ExternalFilesPath=\"{ExternalFilesPath}\""
            );

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Starting Event session...");
            ExecuteSqlCommand(
                "ALTER EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER\r\n    STATE = START;", DWHServerName, "master"
            );

            //Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Starting logman...");
            //CallProcess($"C:\\Windows\\System32\\logman.exe", $"start -n \"SQL Server\" -as", true);

            Console.WriteLine("**********Finished class initialize**********");
        }

        [ClassCleanup(ClassCleanupBehavior.EndOfClass)]
        public static void ClassCleanup()
        {
            Console.WriteLine("**********Started class cleanup**********");

            //Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Stopping logman...");
            //CallProcess($"C:\\Windows\\System32\\logman.exe", $"stop -n \"SQL Server\" -as", true);

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Stopping Event session...");
            ExecuteSqlCommand(
                "ALTER EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER\r\n    STATE = STOP;", DWHServerName, "master"
            );

            if (testPassed)
            {
                CleanupFolder(TestData);
                CleanupFolder($"{ExternalFilesPath}\\Backup");
            }

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up NorthwindDWTests...");
            DWDataTest.TestCleanup();

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up NorthwindLogsTests...");
            LogsDataTest.TestCleanup();

            Console.WriteLine("**********Finished class cleanup**********");
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
            Console.WriteLine($"**********Started FunctionalETLTest**********");
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Updating partition schema...");
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
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing CutoffTimeTest...");
                    DWDataTest.CutoffTimeTest();
                }

                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage1...");
                    DWDataTest.EmployeeSCD2TestStage1();
                }
                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing ProductSCD1TestStage1...");
                    DWDataTest.ProductSCD1TestStage1();
                }

                if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage1...");
                    DWDataTest.UnknownMemberTest();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing EmployeeSCD2TestStage2...");
                    DWDataTest.EmployeeSCD2TestStage2();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing CustomerSCD2TestStage1...");
                    DWDataTest.CustomerSCD2TestStage1();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing ProductSCD1TestStage2...");
                    DWDataTest.ProductSCD1TestStage2();
                }
                if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
                {
                    Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing PartitionsManagingTest...");
                    DWDataTest.PartitionsManagingTest();
                }

                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing OrderShippingDateTest...");
                DWDataTest.OrderShippingDateTest();
            }

            Console.WriteLine("**********Finished FunctionalETLTest**********");
        }

        private void NorthwindBITransformAndLoadJod(DateTime CutoffTime)
        {
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********CUTOFF TIME = {CutoffTime:yyyy-MM-dd HH:mm:ss.fffffff}**********");
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********STEP TRANSFORM AND LOAD**********");
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing Transform and load.dtsx...");
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

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********STEP DWH MAINTENANCE**********");
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing Maintenance Plans\\NorthwindBI\\DWH Maintenance...");
            CallProcess(
                "C:\\Program Files\\Microsoft SQL Server\\160\\DTS\\Binn\\DTExec.exe",
                $"/SQL \"\\\"Maintenance Plans\\NorthwindBI\\\"\" /SERVER {SSISServerName} /CHECKPOINTING OFF /SET \"\\\"\\Package\\DWH Maintenance.Disable\\\"\";false /REPORTING E");

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********STEP COPY DATABASEFILES INFO**********");
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing Maintenance copy DatabaseFiles.dtsx...");
            setValueParameters.Clear();
            ExecuteDtsxInSSISDB("Maintenance copy DatabaseFiles.dtsx", setValueParameters);

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] **********STEPS FINISHED**********");
        }

        private void ExecuteDtsxInSSISDB(string PackgeName, Collection<PackageInfo.ExecutionValueParameterSet> setValueParameters)
        {
            SqlConnection sqlConnection = new SqlConnection(CreateConnectionString(SSISServerName, "master"));
            Catalog SSISDB = new IntegrationServices(sqlConnection).Catalogs[SSISDatabaseName];
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
                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] {package.Name} execution ID {executionid}");

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
                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Executing SSIS package {package.Name} status - {catalogExecutions}");
            }
            sqlConnection.Close();
        }

        private static void CleanupFolder(string FolderPath)
        {
            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up {FolderPath}");
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
                Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Cleaning up {FolderPath} failed with error: \"{e}\"");
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

        private static void ExecuteSqlCommand(string sqlExpression, string DataSource, string InitialCatalog)
        {
            string connectionString = CreateConnectionString(DataSource, InitialCatalog);
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

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Customers] " +
                    "SET [City] = N'Moscow', [Country] = N'Russia', [CompanyName] = REVERSE( [CompanyName] ) " +
                    "WHERE [CustomerID] = N'FRANK';";
                ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);
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
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{LandingServerName}\" -d \"{LandingDatabaseName}\" -x -c -T");

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

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Employees]" +
                    " SET[City] = N'Moscow', [Country] = N'Russia'" +
                    " WHERE[EmployeeID] = 2; ";
                ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);
            }
            if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Employees]" +
                    " SET [City] = N'Tacoma', [Country] = N'USA'" +
                    " WHERE[EmployeeID] = 2; ";
                ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{LandingServerName}\" -d \"{LandingDatabaseName}\" -x -c -T");

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

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            {
                sqlExpression =
                    "UPDATE [Landing].[Products]" +
                    " SET [ProductName] = REVERSE( [ProductName] ), [CategoryID] = 2" +
                    " WHERE[ProductID] = 2;";
                ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{LandingServerName}\" -d \"{LandingDatabaseName}\" -x -c -T");

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

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 3, 0, 0, 0))
            {
                sqlExpression =
                    "UPDATE [Landing].[Categories]" +
                    " SET [CategoryName] = REVERSE( [CategoryName] )" +
                    " WHERE[CategoryID] = 2;";
                ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{LandingServerName}\" -d \"{LandingDatabaseName}\" -x -c -T");


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

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Orders] " +
                    "SET [EmployeeID] = 99" +
                    ", [CustomerID] = 999" +
                    "WHERE [OrderID] = 10812;";
                ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{LandingServerName}\" -d \"{LandingDatabaseName}\" -x -c -T");
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

            Console.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fffffff}] Coping data to {datFilePath}...");
            if (CutoffTime == new DateTime(1998, 1, 2, 0, 0, 0))
            {
                sqlExpression = "UPDATE [Landing].[Order Details] " +
                    "SET [ProductID] = 999" +
                    "WHERE [OrderID] = 10812" +
                    " AND [ProductID] = 31;";
                ExecuteSqlCommand(sqlExpression, LandingServerName, LandingDatabaseName);
            }
            CallProcess($"{SQLServerFiles}\\Client SDK\\ODBC\\170\\Tools\\Binn\\bcp.exe",
                $"\"{sqlQuery}\" queryout \"{datFilePath}\" -S \"{LandingServerName}\" -d \"{LandingDatabaseName}\" -x -c -T");
        }

        private static void CreateCSVFileEncodedASCII(string FilePath)
        {
            using (FileStream fs = File.Create(FilePath, 1024))
            {
                byte[] info = new ASCIIEncoding().GetBytes("");
                fs.Write(info, 0, info.Length);
            }
        }

        private static string CreateConnectionString(string DataSource, string InitialCatalog)
        {
            SqlConnectionStringBuilder sqlConnectionString = new SqlConnectionStringBuilder
            {
                ApplicationName = "FunctionalETLTest",
                DataSource = DataSource,
                InitialCatalog = InitialCatalog,
                IntegratedSecurity = true,
                PersistSecurityInfo = false,
                Pooling = false,
                MultipleActiveResultSets = false,
                Encrypt = true,
                TrustServerCertificate = true
            };

            return sqlConnectionString.ToString();
        }
    }
}
