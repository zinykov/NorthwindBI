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
    public class NorthwindDWTest : SqlDatabaseTestClass
    {

        public NorthwindDWTest()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CustomerSCD2Test_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NorthwindDWTest));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition CustomerSCD2CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2CustomerName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2CountryName;
            this.CustomerSCD2TestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            CustomerSCD2Test_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CustomerSCD2CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            CustomerSCD2CustomerName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // CustomerSCD2TestData
            // 
            this.CustomerSCD2TestData.PosttestAction = null;
            this.CustomerSCD2TestData.PretestAction = null;
            this.CustomerSCD2TestData.TestAction = CustomerSCD2Test_TestAction;
            // 
            // CustomerSCD2Test_TestAction
            // 
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CountRows);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CustomerName);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CityName);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CountryName);
            resources.ApplyResources(CustomerSCD2Test_TestAction, "CustomerSCD2Test_TestAction");
            // 
            // CustomerSCD2CountRows
            // 
            CustomerSCD2CountRows.Enabled = true;
            CustomerSCD2CountRows.Name = "CustomerSCD2CountRows";
            CustomerSCD2CountRows.ResultSet = 1;
            CustomerSCD2CountRows.RowCount = 2;
            // 
            // CustomerSCD2CustomerName
            // 
            CustomerSCD2CustomerName.ColumnNumber = 3;
            CustomerSCD2CustomerName.Enabled = true;
            CustomerSCD2CustomerName.ExpectedValue = "Dnasrevneknarf";
            CustomerSCD2CustomerName.Name = "CustomerSCD2CustomerName";
            CustomerSCD2CustomerName.NullExpected = false;
            CustomerSCD2CustomerName.ResultSet = 1;
            CustomerSCD2CustomerName.RowNumber = 1;
            // 
            // CustomerSCD2CityName
            // 
            CustomerSCD2CityName.ColumnNumber = 7;
            CustomerSCD2CityName.Enabled = true;
            CustomerSCD2CityName.ExpectedValue = "Moscow";
            CustomerSCD2CityName.Name = "CustomerSCD2CityName";
            CustomerSCD2CityName.NullExpected = false;
            CustomerSCD2CityName.ResultSet = 1;
            CustomerSCD2CityName.RowNumber = 2;
            // 
            // CustomerSCD2CountryName
            // 
            CustomerSCD2CountryName.ColumnNumber = 6;
            CustomerSCD2CountryName.Enabled = true;
            CustomerSCD2CountryName.ExpectedValue = "Russia";
            CustomerSCD2CountryName.Name = "CustomerSCD2CountryName";
            CustomerSCD2CountryName.NullExpected = false;
            CustomerSCD2CountryName.ResultSet = 1;
            CustomerSCD2CountryName.RowNumber = 2;
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
        public void CustomerSCD2Test()
        {
            SqlDatabaseTestActions testActions = this.CustomerSCD2TestData;
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
        private SqlDatabaseTestActions CustomerSCD2TestData;

        public static void ETLTests (DateTime CutoffTime)
        {
            System.Diagnostics.Trace.WriteLine("Started ETLTests Method...");
            NorthwindDWTest northwindDWTest = new NorthwindDWTest();
            northwindDWTest.InitializeComponent();
            northwindDWTest.InitializeTest();

            if (CutoffTime == DateTime.Parse("1998-1-3"))
            {
                System.Diagnostics.Trace.WriteLine("Started Customer SCD2 test...");
                northwindDWTest.CustomerSCD2Test();
            }

            northwindDWTest.CleanupTest();
        }
    }
}
