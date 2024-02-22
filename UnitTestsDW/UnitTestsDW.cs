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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Reports_GetViewInfo_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ExpectedSchemaCondition ReportGetViewInfoexpectedSchema;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UnitTestsDW));
            this.Reports_GetViewInfoData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Reports_GetViewInfo_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ReportGetViewInfoexpectedSchema = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ExpectedSchemaCondition();
            // 
            // Reports_GetViewInfoData
            // 
            this.Reports_GetViewInfoData.PosttestAction = null;
            this.Reports_GetViewInfoData.PretestAction = null;
            this.Reports_GetViewInfoData.TestAction = Reports_GetViewInfo_TestAction;
            // 
            // Reports_GetViewInfo_TestAction
            // 
            Reports_GetViewInfo_TestAction.Conditions.Add(ReportGetViewInfoexpectedSchema);
            resources.ApplyResources(Reports_GetViewInfo_TestAction, "Reports_GetViewInfo_TestAction");
            // 
            // ReportGetViewInfoexpectedSchema
            // 
            ReportGetViewInfoexpectedSchema.Enabled = true;
            ReportGetViewInfoexpectedSchema.Name = "ReportGetViewInfoexpectedSchema";
            resources.ApplyResources(ReportGetViewInfoexpectedSchema, "ReportGetViewInfoexpectedSchema");
            ReportGetViewInfoexpectedSchema.Verbose = false;
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
        public void Reports_GetViewInfo()
        {
            SqlDatabaseTestActions testActions = this.Reports_GetViewInfoData;
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
        private SqlDatabaseTestActions Reports_GetViewInfoData;
    }
}
