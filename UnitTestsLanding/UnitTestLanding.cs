using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace UnitTestsLanding
{
    [TestClass()]
    public class UnitTestLanding : SqlDatabaseTestClass
    {

        public UnitTestLanding()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction ExtractCustomersTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ExpectedSchemaCondition ExtractCustomersTestExpectedSchema;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UnitTestLanding));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition LandingExtractCustomersProcedureResult;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition LandingExtractCustomersReturnedValue;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition LandingChangedCustomersRowCount;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition HashUpdateHashCustomersProcedureResult;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction ExtractCustomersTest_PretestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction ExtractCustomersTest_PosttestAction;
            this.ExtractCustomersTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            ExtractCustomersTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ExtractCustomersTestExpectedSchema = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ExpectedSchemaCondition();
            LandingExtractCustomersProcedureResult = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            LandingExtractCustomersReturnedValue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            LandingChangedCustomersRowCount = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            HashUpdateHashCustomersProcedureResult = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ExtractCustomersTest_PretestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ExtractCustomersTest_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            // 
            // ExtractCustomersTest_TestAction
            // 
            ExtractCustomersTest_TestAction.Conditions.Add(ExtractCustomersTestExpectedSchema);
            ExtractCustomersTest_TestAction.Conditions.Add(LandingExtractCustomersProcedureResult);
            ExtractCustomersTest_TestAction.Conditions.Add(LandingExtractCustomersReturnedValue);
            ExtractCustomersTest_TestAction.Conditions.Add(LandingChangedCustomersRowCount);
            ExtractCustomersTest_TestAction.Conditions.Add(HashUpdateHashCustomersProcedureResult);
            resources.ApplyResources(ExtractCustomersTest_TestAction, "ExtractCustomersTest_TestAction");
            // 
            // ExtractCustomersTestExpectedSchema
            // 
            ExtractCustomersTestExpectedSchema.Enabled = true;
            ExtractCustomersTestExpectedSchema.Name = "ExtractCustomersTestExpectedSchema";
            resources.ApplyResources(ExtractCustomersTestExpectedSchema, "ExtractCustomersTestExpectedSchema");
            ExtractCustomersTestExpectedSchema.Verbose = false;
            // 
            // LandingExtractCustomersProcedureResult
            // 
            LandingExtractCustomersProcedureResult.ColumnNumber = 1;
            LandingExtractCustomersProcedureResult.Enabled = true;
            LandingExtractCustomersProcedureResult.ExpectedValue = "0";
            LandingExtractCustomersProcedureResult.Name = "LandingExtractCustomersProcedureResult";
            LandingExtractCustomersProcedureResult.NullExpected = false;
            LandingExtractCustomersProcedureResult.ResultSet = 1;
            LandingExtractCustomersProcedureResult.RowNumber = 1;
            // 
            // LandingExtractCustomersReturnedValue
            // 
            LandingExtractCustomersReturnedValue.ColumnNumber = 2;
            LandingExtractCustomersReturnedValue.Enabled = true;
            LandingExtractCustomersReturnedValue.ExpectedValue = "true";
            LandingExtractCustomersReturnedValue.Name = "LandingExtractCustomersReturnedValue";
            LandingExtractCustomersReturnedValue.NullExpected = false;
            LandingExtractCustomersReturnedValue.ResultSet = 1;
            LandingExtractCustomersReturnedValue.RowNumber = 1;
            // 
            // LandingChangedCustomersRowCount
            // 
            LandingChangedCustomersRowCount.Enabled = true;
            LandingChangedCustomersRowCount.Name = "LandingChangedCustomersRowCount";
            LandingChangedCustomersRowCount.ResultSet = 2;
            LandingChangedCustomersRowCount.RowCount = 91;
            // 
            // HashUpdateHashCustomersProcedureResult
            // 
            HashUpdateHashCustomersProcedureResult.ColumnNumber = 1;
            HashUpdateHashCustomersProcedureResult.Enabled = true;
            HashUpdateHashCustomersProcedureResult.ExpectedValue = "0";
            HashUpdateHashCustomersProcedureResult.Name = "HashUpdateHashCustomersProcedureResult";
            HashUpdateHashCustomersProcedureResult.NullExpected = false;
            HashUpdateHashCustomersProcedureResult.ResultSet = 1;
            HashUpdateHashCustomersProcedureResult.RowNumber = 1;
            // 
            // ExtractCustomersTest_PretestAction
            // 
            resources.ApplyResources(ExtractCustomersTest_PretestAction, "ExtractCustomersTest_PretestAction");
            // 
            // ExtractCustomersTest_PosttestAction
            // 
            resources.ApplyResources(ExtractCustomersTest_PosttestAction, "ExtractCustomersTest_PosttestAction");
            // 
            // ExtractCustomersTestData
            // 
            this.ExtractCustomersTestData.PosttestAction = ExtractCustomersTest_PosttestAction;
            this.ExtractCustomersTestData.PretestAction = ExtractCustomersTest_PretestAction;
            this.ExtractCustomersTestData.TestAction = ExtractCustomersTest_TestAction;
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
        public void ExtractCustomersTest()
        {
            SqlDatabaseTestActions testActions = this.ExtractCustomersTestData;
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



        private SqlDatabaseTestActions ExtractCustomersTestData;
    }
}
