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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.InconclusiveCondition CreateLoadTableOrder_InconclusiveCondition;
            this.Integration_CreateLoadTableOrderTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Integration_CreateLoadTableOrderTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CreateLoadTableOrder_InconclusiveCondition = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.InconclusiveCondition();
            // 
            // Integration_CreateLoadTableOrderTestData
            // 
            this.Integration_CreateLoadTableOrderTestData.PosttestAction = null;
            this.Integration_CreateLoadTableOrderTestData.PretestAction = null;
            this.Integration_CreateLoadTableOrderTestData.TestAction = Integration_CreateLoadTableOrderTest_TestAction;
            // 
            // Integration_CreateLoadTableOrderTest_TestAction
            // 
            Integration_CreateLoadTableOrderTest_TestAction.Conditions.Add(CreateLoadTableOrder_InconclusiveCondition);
            resources.ApplyResources(Integration_CreateLoadTableOrderTest_TestAction, "Integration_CreateLoadTableOrderTest_TestAction");
            // 
            // CreateLoadTableOrder_InconclusiveCondition
            // 
            CreateLoadTableOrder_InconclusiveCondition.Enabled = true;
            CreateLoadTableOrder_InconclusiveCondition.Name = "CreateLoadTableOrder_InconclusiveCondition";
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
        private SqlDatabaseTestActions Integration_CreateLoadTableOrderTestData;
    }
}
