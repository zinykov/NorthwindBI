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
    public class UnitTestDW : SqlDatabaseTestClass
    {

        public UnitTestDW()
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UnitTestDW));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition IntegrationCreateLoadTableOrderReturn0;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Maintenance_InsertDatabaseFilesDataTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition MaintenanceInsertDatabaseFilesDataReturn1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition MaintenanceOptimizeOrdersPartitionsMonthlyReturn0;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Integration_SetCutoffTimeTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition IntegrationSetCutoffTimeReturnedValue;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition IntegtationSetCutoffTimeProcudureStatus;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Repors_CustomerSCD2Test_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerNameValue;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition CustomerSCD2RowCount;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerCityValue;
            this.Integration_CreateLoadTableOrderTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.Maintenance_InsertDatabaseFilesDataTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.Maintenance_OptimizeOrdersPartitionsMonthlyTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.Integration_SetCutoffTimeTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.Repors_CustomerSCD2TestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Integration_CreateLoadTableOrderTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            IntegrationCreateLoadTableOrderReturn0 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            Maintenance_InsertDatabaseFilesDataTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            MaintenanceInsertDatabaseFilesDataReturn1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            Integration_SetCutoffTimeTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            IntegrationSetCutoffTimeReturnedValue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            IntegtationSetCutoffTimeProcudureStatus = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            Repors_CustomerSCD2Test_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CustomerNameValue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2RowCount = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            CustomerCityValue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // Integration_CreateLoadTableOrderTest_TestAction
            // 
            Integration_CreateLoadTableOrderTest_TestAction.Conditions.Add(IntegrationCreateLoadTableOrderReturn0);
            resources.ApplyResources(Integration_CreateLoadTableOrderTest_TestAction, "Integration_CreateLoadTableOrderTest_TestAction");
            // 
            // IntegrationCreateLoadTableOrderReturn0
            // 
            IntegrationCreateLoadTableOrderReturn0.ColumnNumber = 1;
            IntegrationCreateLoadTableOrderReturn0.Enabled = true;
            IntegrationCreateLoadTableOrderReturn0.ExpectedValue = "0";
            IntegrationCreateLoadTableOrderReturn0.Name = "IntegrationCreateLoadTableOrderReturn0";
            IntegrationCreateLoadTableOrderReturn0.NullExpected = false;
            IntegrationCreateLoadTableOrderReturn0.ResultSet = 1;
            IntegrationCreateLoadTableOrderReturn0.RowNumber = 1;
            // 
            // Maintenance_InsertDatabaseFilesDataTest_TestAction
            // 
            Maintenance_InsertDatabaseFilesDataTest_TestAction.Conditions.Add(MaintenanceInsertDatabaseFilesDataReturn1);
            resources.ApplyResources(Maintenance_InsertDatabaseFilesDataTest_TestAction, "Maintenance_InsertDatabaseFilesDataTest_TestAction");
            // 
            // MaintenanceInsertDatabaseFilesDataReturn1
            // 
            MaintenanceInsertDatabaseFilesDataReturn1.ColumnNumber = 1;
            MaintenanceInsertDatabaseFilesDataReturn1.Enabled = true;
            MaintenanceInsertDatabaseFilesDataReturn1.ExpectedValue = "1";
            MaintenanceInsertDatabaseFilesDataReturn1.Name = "MaintenanceInsertDatabaseFilesDataReturn1";
            MaintenanceInsertDatabaseFilesDataReturn1.NullExpected = false;
            MaintenanceInsertDatabaseFilesDataReturn1.ResultSet = 1;
            MaintenanceInsertDatabaseFilesDataReturn1.RowNumber = 1;
            // 
            // Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction
            // 
            Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction.Conditions.Add(MaintenanceOptimizeOrdersPartitionsMonthlyReturn0);
            resources.ApplyResources(Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction, "Maintenance_OptimizeOrdersPartitionsMonthlyTest_TestAction");
            // 
            // MaintenanceOptimizeOrdersPartitionsMonthlyReturn0
            // 
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0.ColumnNumber = 1;
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0.Enabled = true;
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0.ExpectedValue = "0";
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0.Name = "MaintenanceOptimizeOrdersPartitionsMonthlyReturn0";
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0.NullExpected = false;
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0.ResultSet = 1;
            MaintenanceOptimizeOrdersPartitionsMonthlyReturn0.RowNumber = 1;
            // 
            // Integration_SetCutoffTimeTest_TestAction
            // 
            Integration_SetCutoffTimeTest_TestAction.Conditions.Add(IntegrationSetCutoffTimeReturnedValue);
            Integration_SetCutoffTimeTest_TestAction.Conditions.Add(IntegtationSetCutoffTimeProcudureStatus);
            resources.ApplyResources(Integration_SetCutoffTimeTest_TestAction, "Integration_SetCutoffTimeTest_TestAction");
            // 
            // IntegrationSetCutoffTimeReturnedValue
            // 
            IntegrationSetCutoffTimeReturnedValue.ColumnNumber = 1;
            IntegrationSetCutoffTimeReturnedValue.Enabled = true;
            IntegrationSetCutoffTimeReturnedValue.ExpectedValue = "12/31/1997";
            IntegrationSetCutoffTimeReturnedValue.Name = "IntegrationSetCutoffTimeReturnedValue";
            IntegrationSetCutoffTimeReturnedValue.NullExpected = false;
            IntegrationSetCutoffTimeReturnedValue.ResultSet = 1;
            IntegrationSetCutoffTimeReturnedValue.RowNumber = 1;
            // 
            // IntegtationSetCutoffTimeProcudureStatus
            // 
            IntegtationSetCutoffTimeProcudureStatus.ColumnNumber = 1;
            IntegtationSetCutoffTimeProcudureStatus.Enabled = true;
            IntegtationSetCutoffTimeProcudureStatus.ExpectedValue = "0";
            IntegtationSetCutoffTimeProcudureStatus.Name = "IntegtationSetCutoffTimeProcudureStatus";
            IntegtationSetCutoffTimeProcudureStatus.NullExpected = false;
            IntegtationSetCutoffTimeProcudureStatus.ResultSet = 2;
            IntegtationSetCutoffTimeProcudureStatus.RowNumber = 1;
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
            // Integration_SetCutoffTimeTestData
            // 
            this.Integration_SetCutoffTimeTestData.PosttestAction = null;
            this.Integration_SetCutoffTimeTestData.PretestAction = null;
            this.Integration_SetCutoffTimeTestData.TestAction = Integration_SetCutoffTimeTest_TestAction;
            // 
            // Repors_CustomerSCD2TestData
            // 
            this.Repors_CustomerSCD2TestData.PosttestAction = null;
            this.Repors_CustomerSCD2TestData.PretestAction = null;
            this.Repors_CustomerSCD2TestData.TestAction = Repors_CustomerSCD2Test_TestAction;
            // 
            // Repors_CustomerSCD2Test_TestAction
            // 
            Repors_CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2RowCount);
            Repors_CustomerSCD2Test_TestAction.Conditions.Add(CustomerNameValue);
            Repors_CustomerSCD2Test_TestAction.Conditions.Add(CustomerCityValue);
            resources.ApplyResources(Repors_CustomerSCD2Test_TestAction, "Repors_CustomerSCD2Test_TestAction");
            // 
            // CustomerNameValue
            // 
            CustomerNameValue.ColumnNumber = 3;
            CustomerNameValue.Enabled = true;
            CustomerNameValue.ExpectedValue = "1234";
            CustomerNameValue.Name = "CustomerNameValue";
            CustomerNameValue.NullExpected = false;
            CustomerNameValue.ResultSet = 1;
            CustomerNameValue.RowNumber = 1;
            // 
            // CustomerSCD2RowCount
            // 
            CustomerSCD2RowCount.Enabled = true;
            CustomerSCD2RowCount.Name = "CustomerSCD2RowCount";
            CustomerSCD2RowCount.ResultSet = 1;
            CustomerSCD2RowCount.RowCount = 2;
            // 
            // CustomerCityValue
            // 
            CustomerCityValue.ColumnNumber = 2;
            CustomerCityValue.Enabled = true;
            CustomerCityValue.ExpectedValue = "Moscow";
            CustomerCityValue.Name = "CustomerCityValue";
            CustomerCityValue.NullExpected = false;
            CustomerCityValue.ResultSet = 1;
            CustomerCityValue.RowNumber = 7;
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
        [TestMethod()]
        public void Integration_SetCutoffTimeTest()
        {
            SqlDatabaseTestActions testActions = this.Integration_SetCutoffTimeTestData;
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
        public void Repors_CustomerSCD2Test()
        {
            SqlDatabaseTestActions testActions = this.Repors_CustomerSCD2TestData;
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
        
        public static void ETLTests(DateTime CutoffTime)
        {
            UnitTestDW unitTestDW = new UnitTestDW();

            if (CutoffTime > DateTime.Parse("1998-1-3"))
            {
                unitTestDW.Repors_CustomerSCD2Test();
            }
        }




        private SqlDatabaseTestActions Integration_CreateLoadTableOrderTestData;
        private SqlDatabaseTestActions Maintenance_InsertDatabaseFilesDataTestData;
        private SqlDatabaseTestActions Maintenance_OptimizeOrdersPartitionsMonthlyTestData;
        private SqlDatabaseTestActions Integration_SetCutoffTimeTestData;
        private SqlDatabaseTestActions Repors_CustomerSCD2TestData;
    }
}
