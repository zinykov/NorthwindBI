using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace NorthwindLogsTest
{
    [TestClass()]
    public class NorthwindLogsDataTest : SqlDatabaseTestClass
    {

        public NorthwindLogsDataTest()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction EventHandlersOnErrorDataTest_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NorthwindLogsDataTest));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition ErrorLogNotEmptyResultSet;
            this.EventHandlersOnErrorDataTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            EventHandlersOnErrorDataTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ErrorLogNotEmptyResultSet = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.NotEmptyResultSetCondition();
            // 
            // EventHandlersOnErrorDataTestData
            // 
            this.EventHandlersOnErrorDataTestData.PosttestAction = null;
            this.EventHandlersOnErrorDataTestData.PretestAction = null;
            this.EventHandlersOnErrorDataTestData.TestAction = EventHandlersOnErrorDataTest_TestAction;
            // 
            // EventHandlersOnErrorDataTest_TestAction
            // 
            EventHandlersOnErrorDataTest_TestAction.Conditions.Add(ErrorLogNotEmptyResultSet);
            resources.ApplyResources(EventHandlersOnErrorDataTest_TestAction, "EventHandlersOnErrorDataTest_TestAction");
            // 
            // ErrorLogNotEmptyResultSet
            // 
            ErrorLogNotEmptyResultSet.Enabled = true;
            ErrorLogNotEmptyResultSet.Name = "ErrorLogNotEmptyResultSet";
            ErrorLogNotEmptyResultSet.ResultSet = 1;
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
        public void EventHandlersOnErrorDataTest()
        {
            SqlDatabaseTestActions testActions = this.EventHandlersOnErrorDataTestData;
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
        private SqlDatabaseTestActions EventHandlersOnErrorDataTestData;
    }
}
