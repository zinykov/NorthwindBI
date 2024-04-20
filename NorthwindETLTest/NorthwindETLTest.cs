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
    public class NorthwindETLTest : SqlDatabaseTestClass
    {

        public NorthwindETLTest()
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NorthwindETLTest));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition CustomerSCD2CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2CustomerKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2CustomerName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2LineageKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition CustomerSCD2CountRowsInDimension;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2StartDate;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction EmployeeSCD2Test_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2CustomerKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2CustomerTitle;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2LineageKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2CountRowsInDimension;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmpoloyeeSCD2StartDate;
            this.CustomerSCD2TestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.EmployeeSCD2TestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            CustomerSCD2Test_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CustomerSCD2CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            CustomerSCD2CustomerKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2CustomerName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2LineageKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2CountRowsInDimension = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            CustomerSCD2StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Test_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            EmployeeSCD2CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmployeeSCD2CustomerKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2CustomerTitle = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2LineageKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2CountRowsInDimension = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmpoloyeeSCD2StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // CustomerSCD2Test_TestAction
            // 
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CountRows);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CustomerKey);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CustomerName);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2LineageKey);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CityName);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CountryName);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2CountRowsInDimension);
            CustomerSCD2Test_TestAction.Conditions.Add(CustomerSCD2StartDate);
            resources.ApplyResources(CustomerSCD2Test_TestAction, "CustomerSCD2Test_TestAction");
            // 
            // CustomerSCD2CountRows
            // 
            CustomerSCD2CountRows.Enabled = true;
            CustomerSCD2CountRows.Name = "CustomerSCD2CountRows";
            CustomerSCD2CountRows.ResultSet = 1;
            CustomerSCD2CountRows.RowCount = 2;
            // 
            // CustomerSCD2CustomerKey
            // 
            CustomerSCD2CustomerKey.ColumnNumber = 1;
            CustomerSCD2CustomerKey.Enabled = true;
            CustomerSCD2CustomerKey.ExpectedValue = "89";
            CustomerSCD2CustomerKey.Name = "CustomerSCD2CustomerKey";
            CustomerSCD2CustomerKey.NullExpected = false;
            CustomerSCD2CustomerKey.ResultSet = 1;
            CustomerSCD2CustomerKey.RowNumber = 2;
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
            // CustomerSCD2LineageKey
            // 
            CustomerSCD2LineageKey.ColumnNumber = 13;
            CustomerSCD2LineageKey.Enabled = true;
            CustomerSCD2LineageKey.ExpectedValue = "4";
            CustomerSCD2LineageKey.Name = "CustomerSCD2LineageKey";
            CustomerSCD2LineageKey.NullExpected = false;
            CustomerSCD2LineageKey.ResultSet = 1;
            CustomerSCD2LineageKey.RowNumber = 1;
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
            // 
            // CustomerSCD2CountRowsInDimension
            // 
            CustomerSCD2CountRowsInDimension.Enabled = true;
            CustomerSCD2CountRowsInDimension.Name = "CustomerSCD2CountRowsInDimension";
            CustomerSCD2CountRowsInDimension.ResultSet = 2;
            CustomerSCD2CountRowsInDimension.RowCount = 90;
            // 
            // CustomerSCD2StartDate
            // 
            CustomerSCD2StartDate.ColumnNumber = 10;
            CustomerSCD2StartDate.Enabled = true;
            CustomerSCD2StartDate.ExpectedValue = "1998-1-2";
            CustomerSCD2StartDate.Name = "CustomerSCD2StartDate";
            CustomerSCD2StartDate.NullExpected = false;
            CustomerSCD2StartDate.ResultSet = 1;
            CustomerSCD2StartDate.RowNumber = 2;
            // 
            // CustomerSCD2TestData
            // 
            this.CustomerSCD2TestData.PosttestAction = null;
            this.CustomerSCD2TestData.PretestAction = null;
            this.CustomerSCD2TestData.TestAction = CustomerSCD2Test_TestAction;
            // 
            // EmployeeSCD2TestData
            // 
            this.EmployeeSCD2TestData.PosttestAction = null;
            this.EmployeeSCD2TestData.PretestAction = null;
            this.EmployeeSCD2TestData.TestAction = EmployeeSCD2Test_TestAction;
            // 
            // EmployeeSCD2Test_TestAction
            // 
            EmployeeSCD2Test_TestAction.Conditions.Add(EmployeeSCD2CountRows);
            EmployeeSCD2Test_TestAction.Conditions.Add(EmployeeSCD2CustomerKey);
            EmployeeSCD2Test_TestAction.Conditions.Add(EmployeeSCD2CustomerTitle);
            EmployeeSCD2Test_TestAction.Conditions.Add(EmployeeSCD2LineageKey);
            EmployeeSCD2Test_TestAction.Conditions.Add(EmployeeSCD2CityName);
            EmployeeSCD2Test_TestAction.Conditions.Add(EmployeeSCD2CountryName);
            EmployeeSCD2Test_TestAction.Conditions.Add(EmployeeSCD2CountRowsInDimension);
            EmployeeSCD2Test_TestAction.Conditions.Add(EmpoloyeeSCD2StartDate);
            resources.ApplyResources(EmployeeSCD2Test_TestAction, "EmployeeSCD2Test_TestAction");
            // 
            // EmployeeSCD2CountRows
            // 
            EmployeeSCD2CountRows.Enabled = true;
            EmployeeSCD2CountRows.Name = "EmployeeSCD2CountRows";
            EmployeeSCD2CountRows.ResultSet = 1;
            EmployeeSCD2CountRows.RowCount = 2;
            // 
            // EmployeeSCD2CustomerKey
            // 
            EmployeeSCD2CustomerKey.ColumnNumber = 1;
            EmployeeSCD2CustomerKey.Enabled = true;
            EmployeeSCD2CustomerKey.ExpectedValue = "10";
            EmployeeSCD2CustomerKey.Name = "EmployeeSCD2CustomerKey";
            EmployeeSCD2CustomerKey.NullExpected = false;
            EmployeeSCD2CustomerKey.ResultSet = 1;
            EmployeeSCD2CustomerKey.RowNumber = 2;
            // 
            // EmployeeSCD2CustomerTitle
            // 
            EmployeeSCD2CustomerTitle.ColumnNumber = 5;
            EmployeeSCD2CustomerTitle.Enabled = true;
            EmployeeSCD2CustomerTitle.ExpectedValue = "selaS ,tnediserP eciV";
            EmployeeSCD2CustomerTitle.Name = "EmployeeSCD2CustomerTitle";
            EmployeeSCD2CustomerTitle.NullExpected = false;
            EmployeeSCD2CustomerTitle.ResultSet = 1;
            EmployeeSCD2CustomerTitle.RowNumber = 1;
            // 
            // EmployeeSCD2LineageKey
            // 
            EmployeeSCD2LineageKey.ColumnNumber = 13;
            EmployeeSCD2LineageKey.Enabled = true;
            EmployeeSCD2LineageKey.ExpectedValue = "3";
            EmployeeSCD2LineageKey.Name = "EmployeeSCD2LineageKey";
            EmployeeSCD2LineageKey.NullExpected = false;
            EmployeeSCD2LineageKey.ResultSet = 1;
            EmployeeSCD2LineageKey.RowNumber = 1;
            // 
            // EmployeeSCD2CityName
            // 
            EmployeeSCD2CityName.ColumnNumber = 7;
            EmployeeSCD2CityName.Enabled = true;
            EmployeeSCD2CityName.ExpectedValue = "Moscow";
            EmployeeSCD2CityName.Name = "EmployeeSCD2CityName";
            EmployeeSCD2CityName.NullExpected = false;
            EmployeeSCD2CityName.ResultSet = 1;
            EmployeeSCD2CityName.RowNumber = 2;
            // 
            // EmployeeSCD2CountryName
            // 
            EmployeeSCD2CountryName.ColumnNumber = 6;
            EmployeeSCD2CountryName.Enabled = true;
            EmployeeSCD2CountryName.ExpectedValue = "Russia";
            EmployeeSCD2CountryName.Name = "EmployeeSCD2CountryName";
            EmployeeSCD2CountryName.NullExpected = false;
            EmployeeSCD2CountryName.ResultSet = 1;
            EmployeeSCD2CountryName.RowNumber = 2;
            // 
            // EmployeeSCD2CountRowsInDimension
            // 
            EmployeeSCD2CountRowsInDimension.Enabled = true;
            EmployeeSCD2CountRowsInDimension.Name = "EmployeeSCD2CountRowsInDimension";
            EmployeeSCD2CountRowsInDimension.ResultSet = 2;
            EmployeeSCD2CountRowsInDimension.RowCount = 11;
            // 
            // EmpoloyeeSCD2StartDate
            // 
            EmpoloyeeSCD2StartDate.ColumnNumber = 10;
            EmpoloyeeSCD2StartDate.Enabled = true;
            EmpoloyeeSCD2StartDate.ExpectedValue = "1998-1-1";
            EmpoloyeeSCD2StartDate.Name = "EmpoloyeeSCD2StartDate";
            EmpoloyeeSCD2StartDate.NullExpected = false;
            EmpoloyeeSCD2StartDate.ResultSet = 1;
            EmpoloyeeSCD2StartDate.RowNumber = 2;
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
        [TestMethod()]
        public void EmployeeSCD2Test()
        {
            SqlDatabaseTestActions testActions = this.EmployeeSCD2TestData;
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
        private SqlDatabaseTestActions EmployeeSCD2TestData;
    }
}
