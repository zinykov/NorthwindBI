using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace UnitTestsDW
{
    [TestClass()]
    public class UnitTestsDW : SqlDatabaseTestClass
    {

        public UnitTestsDW()
        {
            InitializeComponent();
        }

        [TestInitialize()]
        public void TestInitialize()
        {
            base.InitializeTest();
        }
        [TestCleanup()]
        public void TestCleanup()
        {
            base.CleanupTest();
        }

        #region Designer support code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Integration_CreateLoadTableOrderTest_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UnitTestsDW));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Maintenance_InsertDatabaseFilesDataTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProcedureCreateLoadTableOrderReturnd0;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProcedureOptimizeOrdersPartitionsMonthlyReturnd0;
            this.Integration_CreateLoadTableOrderTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.Maintenance_InsertDatabaseFilesDataTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.Maintenance_OptimizeOrdersPartitionsMonthlyTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Integration_CreateLoadTableOrderTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            Maintenance_InsertDatabaseFilesDataTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ProcedureCreateLoadTableOrderReturnd0 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // Integration_CreateLoadTableOrderTest_TestAction
            // 
            Integration_CreateLoadTableOrderTest_TestAction.Conditions.Add(ProcedureCreateLoadTableOrderReturnd0);
            resources.ApplyResources(Integration_CreateLoadTableOrderTest_TestAction, "Integration_CreateLoadTableOrderTest_TestAction");
            // 
            // Maintenance_InsertDatabaseFilesDataTest_TestAction
            // 
            resources.ApplyResources(Maintenance_InsertDatabaseFilesDataTest_TestAction, "Maintenance_InsertDatabaseFilesDataTest_TestAction");
            // 
            // Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction
            // 
            Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction.Conditions.Add(ProcedureOptimizeOrdersPartitionsMonthlyReturnd0);
            resources.ApplyResources(Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction, "Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction");
            // 
            // Integration_CreateLoadTableOrderTestData
            // 
            this.Integration_CreateLoadTableOrderTestData.PosttestAction = null;
            this.Integration_CreateLoadTableOrderTestData.PretestAction = null;
            this.Integration_CreateLoadTableOrderTestData.TestAction = Integration_CreateLoadTableOrderTest_TestAction;
            // 
            // Maintenance_InsertDatabaseFilesDataTestData
            // 
            this.Maintenance_InsertDatabaseFilesDataTestData.PosttestAction = null;
            this.Maintenance_InsertDatabaseFilesDataTestData.PretestAction = null;
            this.Maintenance_InsertDatabaseFilesDataTestData.TestAction = Maintenance_InsertDatabaseFilesDataTest_TestAction;
            // 
            // Maintenance_OptimizeOrdersPartitionsMonthlyTestData
            // 
            this.Maintenance_OptimizeOrdersPartitionsMonthlyTestData.PosttestAction = null;
            this.Maintenance_OptimizeOrdersPartitionsMonthlyTestData.PretestAction = null;
            this.Maintenance_OptimizeOrdersPartitionsMonthlyTestData.TestAction = Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction;
            // 
            // ProcedureCreateLoadTableOrderReturnd0
            // 
            ProcedureCreateLoadTableOrderReturnd0.ColumnNumber = 1;
            ProcedureCreateLoadTableOrderReturnd0.Enabled = true;
            ProcedureCreateLoadTableOrderReturnd0.ExpectedValue = "0";
            ProcedureCreateLoadTableOrderReturnd0.Name = "ProcedureCreateLoadTableOrderReturnd0";
            ProcedureCreateLoadTableOrderReturnd0.NullExpected = false;
            ProcedureCreateLoadTableOrderReturnd0.ResultSet = 1;
            ProcedureCreateLoadTableOrderReturnd0.RowNumber = 1;
            // 
            // ProcedureOptimizeOrdersPartitionsMonthlyReturnd0
            // 
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0.ColumnNumber = 1;
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0.Enabled = true;
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0.ExpectedValue = "0";
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0.Name = "ProcedureOptimizeOrdersPartitionsMonthlyReturnd0";
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0.NullExpected = false;
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0.ResultSet = 1;
            ProcedureOptimizeOrdersPartitionsMonthlyReturnd0.RowNumber = 1;
        }

        #endregion


        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        #endregion

        [TestMethod()]
        public void Integration_CreateLoadTableOrderTest()
        {
            SqlDatabaseTestActions testActions = this.Integration_CreateLoadTableOrderTestData;
            // Выполнить скрипт перед тестом
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Выполняется скрипт перед тестом…");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Выполнить скрипт теста
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Выполняется скрипт тест…");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Выполнить скрипт после теста
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Выполняется скрипт после теста…");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod(), ExpectedSqlException(Severity = 16, MatchFirstError = false, State = 1)]
        public void Maintenance_InsertDatabaseFilesDataTest()
        {
            SqlDatabaseTestActions testActions = this.Maintenance_InsertDatabaseFilesDataTestData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void Maintenance_OptimizeOrdersPartitionsMonthlyTest()
        {
            SqlDatabaseTestActions testActions = this.Maintenance_OptimizeOrdersPartitionsMonthlyTestData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }


        private SqlDatabaseTestActions Integration_CreateLoadTableOrderTestData;
        private SqlDatabaseTestActions Maintenance_InsertDatabaseFilesDataTestData;
        private SqlDatabaseTestActions Maintenance_OptimizeOrdersPartitionsMonthlyTestData;
    }
}
