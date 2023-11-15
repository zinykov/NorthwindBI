using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace LandingTestProject
{
    [TestClass()]
    public class LandingUnitTests : SqlDatabaseTestClass
    {

        public LandingUnitTests()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Landing_ExtractCategoriesTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Landing_ExtractCategoriesTest_PretestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ExpectedSchemaCondition expectedSchema;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LandingUnitTests));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition rowCount;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition checksum;
            this.Landing_ExtractCategoriesTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Landing_ExtractCategoriesTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            Landing_ExtractCategoriesTest_PretestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            expectedSchema = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ExpectedSchemaCondition();
            rowCount = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            checksum = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            // 
            // Landing_ExtractCategoriesTest_TestAction
            // 
            Landing_ExtractCategoriesTest_TestAction.Conditions.Add(expectedSchema);
            Landing_ExtractCategoriesTest_TestAction.Conditions.Add(rowCount);
            Landing_ExtractCategoriesTest_TestAction.Conditions.Add(checksum);
            resources.ApplyResources(Landing_ExtractCategoriesTest_TestAction, "Landing_ExtractCategoriesTest_TestAction");
            // 
            // Landing_ExtractCategoriesTestData
            // 
            this.Landing_ExtractCategoriesTestData.PosttestAction = null;
            this.Landing_ExtractCategoriesTestData.PretestAction = Landing_ExtractCategoriesTest_PretestAction;
            this.Landing_ExtractCategoriesTestData.TestAction = Landing_ExtractCategoriesTest_TestAction;
            // 
            // Landing_ExtractCategoriesTest_PretestAction
            // 
            resources.ApplyResources(Landing_ExtractCategoriesTest_PretestAction, "Landing_ExtractCategoriesTest_PretestAction");
            // 
            // expectedSchema
            // 
            expectedSchema.Enabled = true;
            expectedSchema.Name = "expectedSchema";
            resources.ApplyResources(expectedSchema, "expectedSchema");
            expectedSchema.Verbose = false;
            // 
            // rowCount
            // 
            rowCount.Enabled = true;
            rowCount.Name = "rowCount";
            rowCount.ResultSet = 1;
            rowCount.RowCount = 8;
            // 
            // checksum
            // 
            checksum.Checksum = "-885027208";
            checksum.Enabled = false;
            checksum.Name = "checksum";
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
        public void Landing_ExtractCategoriesTest()
        {
            SqlDatabaseTestActions testActions = this.Landing_ExtractCategoriesTestData;
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
        private SqlDatabaseTestActions Landing_ExtractCategoriesTestData;
    }
}
