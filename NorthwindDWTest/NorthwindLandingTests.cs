using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace NorthwindDWTest
{
    [TestClass()]
    public class NorthwindLandingTests : SqlDatabaseTestClass
    {

        public NorthwindLandingTests()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction Landing_CheckChangedHolidaysTest_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NorthwindLandingTests));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition LandingCheckChangedHolidaysReturnValues;
            this.Landing_CheckChangedHolidaysTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            Landing_CheckChangedHolidaysTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            LandingCheckChangedHolidaysReturnValues = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // Landing_CheckChangedHolidaysTest_TestAction
            // 
            Landing_CheckChangedHolidaysTest_TestAction.Conditions.Add(LandingCheckChangedHolidaysReturnValues);
            resources.ApplyResources(Landing_CheckChangedHolidaysTest_TestAction, "Landing_CheckChangedHolidaysTest_TestAction");
            // 
            // Landing_CheckChangedHolidaysTestData
            // 
            this.Landing_CheckChangedHolidaysTestData.PosttestAction = null;
            this.Landing_CheckChangedHolidaysTestData.PretestAction = null;
            this.Landing_CheckChangedHolidaysTestData.TestAction = Landing_CheckChangedHolidaysTest_TestAction;
            // 
            // LandingCheckChangedHolidaysReturnValues
            // 
            LandingCheckChangedHolidaysReturnValues.ColumnNumber = 1;
            LandingCheckChangedHolidaysReturnValues.Enabled = true;
            LandingCheckChangedHolidaysReturnValues.ExpectedValue = "0";
            LandingCheckChangedHolidaysReturnValues.Name = "LandingCheckChangedHolidaysReturnValues";
            LandingCheckChangedHolidaysReturnValues.NullExpected = false;
            LandingCheckChangedHolidaysReturnValues.ResultSet = 1;
            LandingCheckChangedHolidaysReturnValues.RowNumber = 1;
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
        public void Landing_CheckChangedHolidaysTest()
        {
            SqlDatabaseTestActions testActions = this.Landing_CheckChangedHolidaysTestData;
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
        private SqlDatabaseTestActions Landing_CheckChangedHolidaysTestData;
    }
}
