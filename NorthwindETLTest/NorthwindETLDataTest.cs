using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace NorthwindETLDataTest
{
    [TestClass()]
    public class NorthwindETLDataTest : SqlDatabaseTestClass
    {

        public NorthwindETLDataTest()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CustomerSCD2TestStage1_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NorthwindETLDataTest));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition CustomerSCD2Stage1CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1CustomerName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1StartDate;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction EmployeeSCD2TestStage1_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage1CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage1EmployeeKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage1CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage1CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage1CountRowsInDimension;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmpoloyeeSCD2Stage1StartDate;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction EmployeeSCD2TestStage2_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage2CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2EmployeeKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage2CountRowsInDimension;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2StartDate;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction ProductSCD1TestStage2_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition ProductSCD1TestStage2CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage2CountChangedRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage2CountLineageValues;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction ProductSCD1TestStage1_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition ProductSCD1TestStage1CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage1ProductName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage1CategoryName;
            this.CustomerSCD2TestStage1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.EmployeeSCD2TestStage1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.EmployeeSCD2TestStage2Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.ProductSCD1TestStage2Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.ProductSCD1TestStage1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            CustomerSCD2TestStage1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CustomerSCD2Stage1CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            CustomerSCD2Stage1CustomerName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2Stage1CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2Stage1CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2Stage1StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2TestStage1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            EmployeeSCD2Stage1CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmployeeSCD2Stage1EmployeeKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage1CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage1CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage1CountRowsInDimension = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmpoloyeeSCD2Stage1StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2TestStage2_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            EmployeeSCD2Stage2CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmployeeSCD2Stage2EmployeeKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage2CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage2CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage2CountRowsInDimension = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmployeeSCD2Stage2StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage2_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ProductSCD1TestStage2CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            ProductSCD1TestStage2CountChangedRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage2CountLineageValues = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ProductSCD1TestStage1CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            ProductSCD1TestStage1ProductName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage1CategoryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // CustomerSCD2TestStage1_TestAction
            // 
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CountRows);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CustomerName);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CityName);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CountryName);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1StartDate);
            resources.ApplyResources(CustomerSCD2TestStage1_TestAction, "CustomerSCD2TestStage1_TestAction");
            // 
            // CustomerSCD2Stage1CountRows
            // 
            CustomerSCD2Stage1CountRows.Enabled = true;
            CustomerSCD2Stage1CountRows.Name = "CustomerSCD2Stage1CountRows";
            CustomerSCD2Stage1CountRows.ResultSet = 1;
            CustomerSCD2Stage1CountRows.RowCount = 2;
            // 
            // CustomerSCD2Stage1CustomerName
            // 
            CustomerSCD2Stage1CustomerName.ColumnNumber = 3;
            CustomerSCD2Stage1CustomerName.Enabled = true;
            CustomerSCD2Stage1CustomerName.ExpectedValue = "Dnasrevneknarf";
            CustomerSCD2Stage1CustomerName.Name = "CustomerSCD2Stage1CustomerName";
            CustomerSCD2Stage1CustomerName.NullExpected = false;
            CustomerSCD2Stage1CustomerName.ResultSet = 1;
            CustomerSCD2Stage1CustomerName.RowNumber = 1;
            // 
            // CustomerSCD2Stage1CityName
            // 
            CustomerSCD2Stage1CityName.ColumnNumber = 7;
            CustomerSCD2Stage1CityName.Enabled = true;
            CustomerSCD2Stage1CityName.ExpectedValue = "Moscow";
            CustomerSCD2Stage1CityName.Name = "CustomerSCD2Stage1CityName";
            CustomerSCD2Stage1CityName.NullExpected = false;
            CustomerSCD2Stage1CityName.ResultSet = 1;
            CustomerSCD2Stage1CityName.RowNumber = 2;
            // 
            // CustomerSCD2Stage1CountryName
            // 
            CustomerSCD2Stage1CountryName.ColumnNumber = 6;
            CustomerSCD2Stage1CountryName.Enabled = true;
            CustomerSCD2Stage1CountryName.ExpectedValue = "Russia";
            CustomerSCD2Stage1CountryName.Name = "CustomerSCD2Stage1CountryName";
            CustomerSCD2Stage1CountryName.NullExpected = false;
            CustomerSCD2Stage1CountryName.ResultSet = 1;
            CustomerSCD2Stage1CountryName.RowNumber = 2;
            // 
            // CustomerSCD2Stage1StartDate
            // 
            CustomerSCD2Stage1StartDate.ColumnNumber = 10;
            CustomerSCD2Stage1StartDate.Enabled = true;
            CustomerSCD2Stage1StartDate.ExpectedValue = "1998-1-2";
            CustomerSCD2Stage1StartDate.Name = "CustomerSCD2Stage1StartDate";
            CustomerSCD2Stage1StartDate.NullExpected = false;
            CustomerSCD2Stage1StartDate.ResultSet = 1;
            CustomerSCD2Stage1StartDate.RowNumber = 2;
            // 
            // EmployeeSCD2TestStage1_TestAction
            // 
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CountRows);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1EmployeeKey);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CityName);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CountryName);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CountRowsInDimension);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmpoloyeeSCD2Stage1StartDate);
            resources.ApplyResources(EmployeeSCD2TestStage1_TestAction, "EmployeeSCD2TestStage1_TestAction");
            // 
            // EmployeeSCD2Stage1CountRows
            // 
            EmployeeSCD2Stage1CountRows.Enabled = true;
            EmployeeSCD2Stage1CountRows.Name = "EmployeeSCD2Stage1CountRows";
            EmployeeSCD2Stage1CountRows.ResultSet = 1;
            EmployeeSCD2Stage1CountRows.RowCount = 2;
            // 
            // EmployeeSCD2Stage1EmployeeKey
            // 
            EmployeeSCD2Stage1EmployeeKey.ColumnNumber = 1;
            EmployeeSCD2Stage1EmployeeKey.Enabled = true;
            EmployeeSCD2Stage1EmployeeKey.ExpectedValue = "10";
            EmployeeSCD2Stage1EmployeeKey.Name = "EmployeeSCD2Stage1EmployeeKey";
            EmployeeSCD2Stage1EmployeeKey.NullExpected = false;
            EmployeeSCD2Stage1EmployeeKey.ResultSet = 1;
            EmployeeSCD2Stage1EmployeeKey.RowNumber = 2;
            // 
            // EmployeeSCD2Stage1CityName
            // 
            EmployeeSCD2Stage1CityName.ColumnNumber = 6;
            EmployeeSCD2Stage1CityName.Enabled = true;
            EmployeeSCD2Stage1CityName.ExpectedValue = "Moscow";
            EmployeeSCD2Stage1CityName.Name = "EmployeeSCD2Stage1CityName";
            EmployeeSCD2Stage1CityName.NullExpected = false;
            EmployeeSCD2Stage1CityName.ResultSet = 1;
            EmployeeSCD2Stage1CityName.RowNumber = 2;
            // 
            // EmployeeSCD2Stage1CountryName
            // 
            EmployeeSCD2Stage1CountryName.ColumnNumber = 7;
            EmployeeSCD2Stage1CountryName.Enabled = true;
            EmployeeSCD2Stage1CountryName.ExpectedValue = "Russia";
            EmployeeSCD2Stage1CountryName.Name = "EmployeeSCD2Stage1CountryName";
            EmployeeSCD2Stage1CountryName.NullExpected = false;
            EmployeeSCD2Stage1CountryName.ResultSet = 1;
            EmployeeSCD2Stage1CountryName.RowNumber = 2;
            // 
            // EmployeeSCD2Stage1CountRowsInDimension
            // 
            EmployeeSCD2Stage1CountRowsInDimension.Enabled = true;
            EmployeeSCD2Stage1CountRowsInDimension.Name = "EmployeeSCD2Stage1CountRowsInDimension";
            EmployeeSCD2Stage1CountRowsInDimension.ResultSet = 2;
            EmployeeSCD2Stage1CountRowsInDimension.RowCount = 11;
            // 
            // EmpoloyeeSCD2Stage1StartDate
            // 
            EmpoloyeeSCD2Stage1StartDate.ColumnNumber = 8;
            EmpoloyeeSCD2Stage1StartDate.Enabled = true;
            EmpoloyeeSCD2Stage1StartDate.ExpectedValue = "1998-1-1";
            EmpoloyeeSCD2Stage1StartDate.Name = "EmpoloyeeSCD2Stage1StartDate";
            EmpoloyeeSCD2Stage1StartDate.NullExpected = false;
            EmpoloyeeSCD2Stage1StartDate.ResultSet = 1;
            EmpoloyeeSCD2Stage1StartDate.RowNumber = 2;
            // 
            // EmployeeSCD2TestStage2_TestAction
            // 
            EmployeeSCD2TestStage2_TestAction.Conditions.Add(EmployeeSCD2Stage2CountRows);
            EmployeeSCD2TestStage2_TestAction.Conditions.Add(EmployeeSCD2Stage2EmployeeKey);
            EmployeeSCD2TestStage2_TestAction.Conditions.Add(EmployeeSCD2Stage2CityName);
            EmployeeSCD2TestStage2_TestAction.Conditions.Add(EmployeeSCD2Stage2CountryName);
            EmployeeSCD2TestStage2_TestAction.Conditions.Add(EmployeeSCD2Stage2CountRowsInDimension);
            EmployeeSCD2TestStage2_TestAction.Conditions.Add(EmployeeSCD2Stage2StartDate);
            resources.ApplyResources(EmployeeSCD2TestStage2_TestAction, "EmployeeSCD2TestStage2_TestAction");
            // 
            // EmployeeSCD2Stage2CountRows
            // 
            EmployeeSCD2Stage2CountRows.Enabled = true;
            EmployeeSCD2Stage2CountRows.Name = "EmployeeSCD2Stage2CountRows";
            EmployeeSCD2Stage2CountRows.ResultSet = 1;
            EmployeeSCD2Stage2CountRows.RowCount = 3;
            // 
            // EmployeeSCD2Stage2EmployeeKey
            // 
            EmployeeSCD2Stage2EmployeeKey.ColumnNumber = 1;
            EmployeeSCD2Stage2EmployeeKey.Enabled = true;
            EmployeeSCD2Stage2EmployeeKey.ExpectedValue = "11";
            EmployeeSCD2Stage2EmployeeKey.Name = "EmployeeSCD2Stage2EmployeeKey";
            EmployeeSCD2Stage2EmployeeKey.NullExpected = false;
            EmployeeSCD2Stage2EmployeeKey.ResultSet = 1;
            EmployeeSCD2Stage2EmployeeKey.RowNumber = 3;
            // 
            // EmployeeSCD2Stage2CityName
            // 
            EmployeeSCD2Stage2CityName.ColumnNumber = 6;
            EmployeeSCD2Stage2CityName.Enabled = true;
            EmployeeSCD2Stage2CityName.ExpectedValue = "Tacoma";
            EmployeeSCD2Stage2CityName.Name = "EmployeeSCD2Stage2CityName";
            EmployeeSCD2Stage2CityName.NullExpected = false;
            EmployeeSCD2Stage2CityName.ResultSet = 1;
            EmployeeSCD2Stage2CityName.RowNumber = 3;
            // 
            // EmployeeSCD2Stage2CountryName
            // 
            EmployeeSCD2Stage2CountryName.ColumnNumber = 7;
            EmployeeSCD2Stage2CountryName.Enabled = true;
            EmployeeSCD2Stage2CountryName.ExpectedValue = "USA";
            EmployeeSCD2Stage2CountryName.Name = "EmployeeSCD2Stage2CountryName";
            EmployeeSCD2Stage2CountryName.NullExpected = false;
            EmployeeSCD2Stage2CountryName.ResultSet = 1;
            EmployeeSCD2Stage2CountryName.RowNumber = 3;
            // 
            // EmployeeSCD2Stage2CountRowsInDimension
            // 
            EmployeeSCD2Stage2CountRowsInDimension.Enabled = true;
            EmployeeSCD2Stage2CountRowsInDimension.Name = "EmployeeSCD2Stage2CountRowsInDimension";
            EmployeeSCD2Stage2CountRowsInDimension.ResultSet = 2;
            EmployeeSCD2Stage2CountRowsInDimension.RowCount = 12;
            // 
            // EmployeeSCD2Stage2StartDate
            // 
            EmployeeSCD2Stage2StartDate.ColumnNumber = 8;
            EmployeeSCD2Stage2StartDate.Enabled = true;
            EmployeeSCD2Stage2StartDate.ExpectedValue = "1998-1-2";
            EmployeeSCD2Stage2StartDate.Name = "EmployeeSCD2Stage2StartDate";
            EmployeeSCD2Stage2StartDate.NullExpected = false;
            EmployeeSCD2Stage2StartDate.ResultSet = 1;
            EmployeeSCD2Stage2StartDate.RowNumber = 3;
            // 
            // ProductSCD1TestStage2_TestAction
            // 
            ProductSCD1TestStage2_TestAction.Conditions.Add(ProductSCD1TestStage2CountRows);
            ProductSCD1TestStage2_TestAction.Conditions.Add(ProductSCD1TestStage2CountChangedRows);
            ProductSCD1TestStage2_TestAction.Conditions.Add(ProductSCD1TestStage2CountLineageValues);
            resources.ApplyResources(ProductSCD1TestStage2_TestAction, "ProductSCD1TestStage2_TestAction");
            // 
            // ProductSCD1TestStage2CountRows
            // 
            ProductSCD1TestStage2CountRows.Enabled = true;
            ProductSCD1TestStage2CountRows.Name = "ProductSCD1TestStage2CountRows";
            ProductSCD1TestStage2CountRows.ResultSet = 1;
            ProductSCD1TestStage2CountRows.RowCount = 1;
            // 
            // ProductSCD1TestStage2CountChangedRows
            // 
            ProductSCD1TestStage2CountChangedRows.ColumnNumber = 1;
            ProductSCD1TestStage2CountChangedRows.Enabled = true;
            ProductSCD1TestStage2CountChangedRows.ExpectedValue = "13";
            ProductSCD1TestStage2CountChangedRows.Name = "ProductSCD1TestStage2CountChangedRows";
            ProductSCD1TestStage2CountChangedRows.NullExpected = false;
            ProductSCD1TestStage2CountChangedRows.ResultSet = 1;
            ProductSCD1TestStage2CountChangedRows.RowNumber = 1;
            // 
            // ProductSCD1TestStage2CountLineageValues
            // 
            ProductSCD1TestStage2CountLineageValues.ColumnNumber = 2;
            ProductSCD1TestStage2CountLineageValues.Enabled = true;
            ProductSCD1TestStage2CountLineageValues.ExpectedValue = "1";
            ProductSCD1TestStage2CountLineageValues.Name = "ProductSCD1TestStage2CountLineageValues";
            ProductSCD1TestStage2CountLineageValues.NullExpected = false;
            ProductSCD1TestStage2CountLineageValues.ResultSet = 1;
            ProductSCD1TestStage2CountLineageValues.RowNumber = 1;
            // 
            // ProductSCD1TestStage1_TestAction
            // 
            ProductSCD1TestStage1_TestAction.Conditions.Add(ProductSCD1TestStage1CountRows);
            ProductSCD1TestStage1_TestAction.Conditions.Add(ProductSCD1TestStage1ProductName);
            ProductSCD1TestStage1_TestAction.Conditions.Add(ProductSCD1TestStage1CategoryName);
            resources.ApplyResources(ProductSCD1TestStage1_TestAction, "ProductSCD1TestStage1_TestAction");
            // 
            // ProductSCD1TestStage1CountRows
            // 
            ProductSCD1TestStage1CountRows.Enabled = true;
            ProductSCD1TestStage1CountRows.Name = "ProductSCD1TestStage1CountRows";
            ProductSCD1TestStage1CountRows.ResultSet = 1;
            ProductSCD1TestStage1CountRows.RowCount = 1;
            // 
            // ProductSCD1TestStage1ProductName
            // 
            ProductSCD1TestStage1ProductName.ColumnNumber = 3;
            ProductSCD1TestStage1ProductName.Enabled = true;
            ProductSCD1TestStage1ProductName.ExpectedValue = "Gnahc";
            ProductSCD1TestStage1ProductName.Name = "ProductSCD1TestStage1ProductName";
            ProductSCD1TestStage1ProductName.NullExpected = false;
            ProductSCD1TestStage1ProductName.ResultSet = 1;
            ProductSCD1TestStage1ProductName.RowNumber = 1;
            // 
            // ProductSCD1TestStage1CategoryName
            // 
            ProductSCD1TestStage1CategoryName.ColumnNumber = 4;
            ProductSCD1TestStage1CategoryName.Enabled = true;
            ProductSCD1TestStage1CategoryName.ExpectedValue = "Condiments";
            ProductSCD1TestStage1CategoryName.Name = "ProductSCD1TestStage1CategoryName";
            ProductSCD1TestStage1CategoryName.NullExpected = false;
            ProductSCD1TestStage1CategoryName.ResultSet = 1;
            ProductSCD1TestStage1CategoryName.RowNumber = 1;
            // 
            // CustomerSCD2TestStage1Data
            // 
            this.CustomerSCD2TestStage1Data.PosttestAction = null;
            this.CustomerSCD2TestStage1Data.PretestAction = null;
            this.CustomerSCD2TestStage1Data.TestAction = CustomerSCD2TestStage1_TestAction;
            // 
            // EmployeeSCD2TestStage1Data
            // 
            this.EmployeeSCD2TestStage1Data.PosttestAction = null;
            this.EmployeeSCD2TestStage1Data.PretestAction = null;
            this.EmployeeSCD2TestStage1Data.TestAction = EmployeeSCD2TestStage1_TestAction;
            // 
            // EmployeeSCD2TestStage2Data
            // 
            this.EmployeeSCD2TestStage2Data.PosttestAction = null;
            this.EmployeeSCD2TestStage2Data.PretestAction = null;
            this.EmployeeSCD2TestStage2Data.TestAction = EmployeeSCD2TestStage2_TestAction;
            // 
            // ProductSCD1TestStage2Data
            // 
            this.ProductSCD1TestStage2Data.PosttestAction = null;
            this.ProductSCD1TestStage2Data.PretestAction = null;
            this.ProductSCD1TestStage2Data.TestAction = ProductSCD1TestStage2_TestAction;
            // 
            // ProductSCD1TestStage1Data
            // 
            this.ProductSCD1TestStage1Data.PosttestAction = null;
            this.ProductSCD1TestStage1Data.PretestAction = null;
            this.ProductSCD1TestStage1Data.TestAction = ProductSCD1TestStage1_TestAction;
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
        public void CustomerSCD2TestStage1()
        {
            SqlDatabaseTestActions testActions = this.CustomerSCD2TestStage1Data;
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
        public void EmployeeSCD2TestStage1()
        {
            SqlDatabaseTestActions testActions = this.EmployeeSCD2TestStage1Data;
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
        public void EmployeeSCD2TestStage2()
        {
            SqlDatabaseTestActions testActions = this.EmployeeSCD2TestStage2Data;
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
        public void ProductSCD1TestStage2()
        {
            SqlDatabaseTestActions testActions = this.ProductSCD1TestStage2Data;
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
        public void ProductSCD1TestStage1()
        {
            SqlDatabaseTestActions testActions = this.ProductSCD1TestStage1Data;
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




        private SqlDatabaseTestActions CustomerSCD2TestStage1Data;
        private SqlDatabaseTestActions EmployeeSCD2TestStage1Data;
        private SqlDatabaseTestActions EmployeeSCD2TestStage2Data;
        private SqlDatabaseTestActions ProductSCD1TestStage2Data;
        private SqlDatabaseTestActions ProductSCD1TestStage1Data;
    }
}
