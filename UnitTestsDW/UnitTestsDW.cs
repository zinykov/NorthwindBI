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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Integration_LoadDateDimensionTest_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UnitTestsDW));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Integration_LoadDateDimensionTest_PretestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition unknownMemberYear;
            this.Integration_LoadDateDimensionTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Integration_LoadDateDimensionTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            Integration_LoadDateDimensionTest_PretestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            unknownMemberYear = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // Integration_LoadDateDimensionTest_TestAction
            // 
            Integration_LoadDateDimensionTest_TestAction.Conditions.Add(unknownMemberYear);
            resources.ApplyResources(Integration_LoadDateDimensionTest_TestAction, "Integration_LoadDateDimensionTest_TestAction");
            // 
            // Integration_LoadDateDimensionTestData
            // 
            this.Integration_LoadDateDimensionTestData.PosttestAction = null;
            this.Integration_LoadDateDimensionTestData.PretestAction = Integration_LoadDateDimensionTest_PretestAction;
            this.Integration_LoadDateDimensionTestData.TestAction = Integration_LoadDateDimensionTest_TestAction;
            // 
            // Integration_LoadDateDimensionTest_PretestAction
            // 
            resources.ApplyResources(Integration_LoadDateDimensionTest_PretestAction, "Integration_LoadDateDimensionTest_PretestAction");
            // 
            // unknownMemberYear
            // 
            unknownMemberYear.ColumnNumber = 7;
            unknownMemberYear.Enabled = true;
            unknownMemberYear.ExpectedValue = "1996";
            unknownMemberYear.Name = "unknownMemberYear";
            unknownMemberYear.NullExpected = false;
            unknownMemberYear.ResultSet = 1;
            unknownMemberYear.RowNumber = 1;
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
        public void Integration_LoadDateDimensionTest()
        {
            SqlDatabaseTestActions testActions = this.Integration_LoadDateDimensionTestData;
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
        private SqlDatabaseTestActions Integration_LoadDateDimensionTestData;
    }
}
