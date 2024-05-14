using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.SqlClient;

namespace NorthwindETLTest
{
    /// <summary>
    /// Сводное описание для UnitTest1
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
        public void NorthwindETLtest()
        {
            DateTime LoadDateInitialEnd = new DateTime(1997, 12, 31, 0, 0, 0);
            DateTime LoadDateIncrementalEnd = new DateTime(1998, 1, 3, 0, 0, 0);
            string ProgramFiles = Environment.GetEnvironmentVariable("ProgramFiles");
            string SSISFolderName = "NorthwindBI";
            string SSISProjectName = "NorthwindETL";
            string SSISServerName = "SWIFT3";
            string referenceid = String.Empty;

            SqlConnection SSISConnection = new SqlConnection("Data Source=SWIFT3;Initial Catalog=SSISDB;Persist Security Info=True;Integrated Security=SSPI");
            SSISConnection.Open();
            SqlCommand getReferenceQuery = new SqlCommand("SELECT [reference_id] FROM [catalog].[environment_references] WHERE [environment_name] = N'Release'", SSISConnection);
            using (SqlDataReader reader = getReferenceQuery.ExecuteReader())
            {
                if (reader.Read())
                {
                    referenceid = (string)reader["reference_id"];
                }
            }
            SSISConnection.Close();

            if (!string.IsNullOrEmpty(referenceid))
            {
                System.Diagnostics.Process dtexec = new System.Diagnostics.Process();
                dtexec.StartInfo.FileName = $"{ProgramFiles}\\Microsoft SQL Server\\150\\DTS\\Binn\\DTExec.exe";
                dtexec.StartInfo.Arguments = $"/ISServer \"\\SSISDB\\{SSISFolderName}\\{SSISProjectName}\\Initial load.dtsx\" /Server \"{SSISServerName}\" /EnvReference {referenceid} /Parameter \"$Package::CutoffTime(DateTime)\";\"{string.Format("{0:yyyy-MM-dd H:mm:ss}", LoadDateInitialEnd)}\" /Parameter \"$Package::LoadDateInitialEnd(DateTime)\";\"{string.Format("{0:yyyy-MM-dd H:mm:ss}", LoadDateInitialEnd)}\" /Parameter \"$ServerOption::SYNCHRONIZED(Boolean)\";True";
                dtexec.StartInfo.UseShellExecute = false;
                dtexec.StartInfo.RedirectStandardOutput = true;
                dtexec.StartInfo.RedirectStandardError = true;
                dtexec.Start();

                string StandartOutput = dtexec.StandardOutput.ReadToEnd();
                string ErrorOutput = dtexec.StandardError.ReadToEnd();
            }
        }
    }
}
