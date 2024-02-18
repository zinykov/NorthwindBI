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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Maintenance_CheckReferenceDateTest_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UnitTestsDW));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition valueIsStartOptimization;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition valueIsSetFilegroupReadonly;
            this.Maintenance_CheckReferenceDateTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Maintenance_CheckReferenceDateTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            valueIsStartOptimization = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            valueIsSetFilegroupReadonly = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // Maintenance_CheckReferenceDateTestData
            // 
            this.Maintenance_CheckReferenceDateTestData.PosttestAction = null;
            this.Maintenance_CheckReferenceDateTestData.PretestAction = null;
            this.Maintenance_CheckReferenceDateTestData.TestAction = Maintenance_CheckReferenceDateTest_TestAction;
            // 
            // Maintenance_CheckReferenceDateTest_TestAction
            // 
            Maintenance_CheckReferenceDateTest_TestAction.Conditions.Add(valueIsStartOptimization);
            Maintenance_CheckReferenceDateTest_TestAction.Conditions.Add(valueIsSetFilegroupReadonly);
            resources.ApplyResources(Maintenance_CheckReferenceDateTest_TestAction, "Maintenance_CheckReferenceDateTest_TestAction");
            // 
            // valueIsStartOptimization
            // 
            valueIsStartOptimization.ColumnNumber = 1;
            valueIsStartOptimization.Enabled = true;
            valueIsStartOptimization.ExpectedValue = "False";
            valueIsStartOptimization.Name = "valueIsStartOptimization";
            valueIsStartOptimization.NullExpected = false;
            valueIsStartOptimization.ResultSet = 1;
            valueIsStartOptimization.RowNumber = 1;
            // 
            // valueIsSetFilegroupReadonly
            // 
            valueIsSetFilegroupReadonly.ColumnNumber = 2;
            valueIsSetFilegroupReadonly.Enabled = true;
            valueIsSetFilegroupReadonly.ExpectedValue = "False";
            valueIsSetFilegroupReadonly.Name = "valueIsSetFilegroupReadonly";
            valueIsSetFilegroupReadonly.NullExpected = false;
            valueIsSetFilegroupReadonly.ResultSet = 1;
            valueIsSetFilegroupReadonly.RowNumber = 1;
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
        public void Maintenance_CheckReferenceDateTest()
        {
            SqlDatabaseTestActions testActions = this.Maintenance_CheckReferenceDateTestData;
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

        private SqlDatabaseTestActions Maintenance_CheckReferenceDateTestData;
    }
}
