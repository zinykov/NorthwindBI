using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace NorthwindDWTest
{
    [TestClass()]
    public class NorthwindDWDataTest : SqlDatabaseTestClass
    {
        public NorthwindDWDataTest() => InitializeComponent();

        public NorthwindDWDataTest(string sqlConnectionString)
        {
            ClassInitialize(sqlConnectionString);
            InitializeComponent();
        }

        [ClassInitialize()]
        public static void ClassInitialize(string sqlConnectionString)
        {
            TestService = new OverwritedTestService(sqlConnectionString);
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NorthwindDWDataTest));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition CustomerSCD2Stage1CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1CustomerName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1StartDate;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CustomerSCD2Stage1JSON_value;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction EmployeeSCD2TestStage1_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage1CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage1EmployeeKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage1CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage1CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage1CountRowsInDimension;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmpoloyeeSCD2Stage1StartDate;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmpoloyeeSCD2JSON_value;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction EmployeeSCD2TestStage2_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage2CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2EmployeeKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2CityName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2CountryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition EmployeeSCD2Stage2CountRowsInDimension;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition EmployeeSCD2Stage2StartDate;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction OrderShippingDateTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition OrderShippingDateTest;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction ProductSCD1TestStage1_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition ProductSCD1TestStage1CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage1ProductName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage1CategoryName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage1JSON_value;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction ProductSCD1TestStage2_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition ProductSCD1TestStage2CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage2CountChangedRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition ProductSCD1TestStage2CountLineageValues;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CutoffTimeTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CutoffTimeTestMinValue;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CutoffTimeTestMaxValue;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction UpdatePartitionSchema_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition NumberPartitionBoundaries;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition CheckHashBeforeLoad;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction PartitionsManagingTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition DataCommpression;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition IsFileGroupReadOnly;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition FileGroupName;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition PartitionRange;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction UnknownMemberTest_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition UnknownMemberTestCountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition UnknownMemberTestEmployeeKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition UnknownMemberTestCustomerKey;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition UnknownMemberTestProductKey;
            this.CustomerSCD2TestStage1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.EmployeeSCD2TestStage1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.EmployeeSCD2TestStage2Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.OrderShippingDateTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.ProductSCD1TestStage1Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.ProductSCD1TestStage2Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CutoffTimeTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.UpdatePartitionSchemaData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.PartitionsManagingTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.UnknownMemberTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            CustomerSCD2TestStage1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CustomerSCD2Stage1CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            CustomerSCD2Stage1CustomerName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2Stage1CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2Stage1CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2Stage1StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CustomerSCD2Stage1JSON_value = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2TestStage1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            EmployeeSCD2Stage1CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmployeeSCD2Stage1EmployeeKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage1CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage1CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage1CountRowsInDimension = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmpoloyeeSCD2Stage1StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmpoloyeeSCD2JSON_value = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2TestStage2_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            EmployeeSCD2Stage2CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmployeeSCD2Stage2EmployeeKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage2CityName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage2CountryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            EmployeeSCD2Stage2CountRowsInDimension = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            EmployeeSCD2Stage2StartDate = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            OrderShippingDateTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            OrderShippingDateTest = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            ProductSCD1TestStage1_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ProductSCD1TestStage1CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            ProductSCD1TestStage1ProductName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage1CategoryName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage1JSON_value = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage2_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            ProductSCD1TestStage2CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            ProductSCD1TestStage2CountChangedRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            ProductSCD1TestStage2CountLineageValues = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CutoffTimeTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CutoffTimeTestMinValue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CutoffTimeTestMaxValue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            UpdatePartitionSchema_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            NumberPartitionBoundaries = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            CheckHashBeforeLoad = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            PartitionsManagingTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            DataCommpression = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            IsFileGroupReadOnly = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            FileGroupName = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            PartitionRange = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            UnknownMemberTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            UnknownMemberTestCountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.RowCountCondition();
            UnknownMemberTestEmployeeKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            UnknownMemberTestCustomerKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            UnknownMemberTestProductKey = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // CustomerSCD2TestStage1_TestAction
            // 
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CountRows);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CustomerName);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CityName);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1CountryName);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1StartDate);
            CustomerSCD2TestStage1_TestAction.Conditions.Add(CustomerSCD2Stage1JSON_value);
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
            CustomerSCD2Stage1StartDate.ColumnNumber = 11;
            CustomerSCD2Stage1StartDate.Enabled = true;
            CustomerSCD2Stage1StartDate.ExpectedValue = "1998-01-02 00:00:00";
            CustomerSCD2Stage1StartDate.Name = "CustomerSCD2Stage1StartDate";
            CustomerSCD2Stage1StartDate.NullExpected = false;
            CustomerSCD2Stage1StartDate.ResultSet = 1;
            CustomerSCD2Stage1StartDate.RowNumber = 2;
            // 
            // CustomerSCD2Stage1JSON_value
            // 
            CustomerSCD2Stage1JSON_value.ColumnNumber = 1;
            CustomerSCD2Stage1JSON_value.Enabled = true;
            CustomerSCD2Stage1JSON_value.ExpectedValue = "SSIS";
            CustomerSCD2Stage1JSON_value.Name = "CustomerSCD2Stage1JSON_value";
            CustomerSCD2Stage1JSON_value.NullExpected = false;
            CustomerSCD2Stage1JSON_value.ResultSet = 3;
            CustomerSCD2Stage1JSON_value.RowNumber = 2;
            // 
            // EmployeeSCD2TestStage1_TestAction
            // 
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CountRows);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1EmployeeKey);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CityName);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CountryName);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmployeeSCD2Stage1CountRowsInDimension);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmpoloyeeSCD2Stage1StartDate);
            EmployeeSCD2TestStage1_TestAction.Conditions.Add(EmpoloyeeSCD2JSON_value);
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
            EmpoloyeeSCD2Stage1StartDate.ColumnNumber = 9;
            EmpoloyeeSCD2Stage1StartDate.Enabled = true;
            EmpoloyeeSCD2Stage1StartDate.ExpectedValue = "1998-01-01 00:00:00";
            EmpoloyeeSCD2Stage1StartDate.Name = "EmpoloyeeSCD2Stage1StartDate";
            EmpoloyeeSCD2Stage1StartDate.NullExpected = false;
            EmpoloyeeSCD2Stage1StartDate.ResultSet = 1;
            EmpoloyeeSCD2Stage1StartDate.RowNumber = 2;
            // 
            // EmpoloyeeSCD2JSON_value
            // 
            EmpoloyeeSCD2JSON_value.ColumnNumber = 1;
            EmpoloyeeSCD2JSON_value.Enabled = true;
            EmpoloyeeSCD2JSON_value.ExpectedValue = "SSIS";
            EmpoloyeeSCD2JSON_value.Name = "EmpoloyeeSCD2JSON_value";
            EmpoloyeeSCD2JSON_value.NullExpected = false;
            EmpoloyeeSCD2JSON_value.ResultSet = 3;
            EmpoloyeeSCD2JSON_value.RowNumber = 2;
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
            EmployeeSCD2Stage2StartDate.ColumnNumber = 9;
            EmployeeSCD2Stage2StartDate.Enabled = true;
            EmployeeSCD2Stage2StartDate.ExpectedValue = "1998-01-02 00:00:00";
            EmployeeSCD2Stage2StartDate.Name = "EmployeeSCD2Stage2StartDate";
            EmployeeSCD2Stage2StartDate.NullExpected = false;
            EmployeeSCD2Stage2StartDate.ResultSet = 1;
            EmployeeSCD2Stage2StartDate.RowNumber = 3;
            // 
            // OrderShippingDateTest_TestAction
            // 
            OrderShippingDateTest_TestAction.Conditions.Add(OrderShippingDateTest);
            resources.ApplyResources(OrderShippingDateTest_TestAction, "OrderShippingDateTest_TestAction");
            // 
            // OrderShippingDateTest
            // 
            OrderShippingDateTest.Enabled = true;
            OrderShippingDateTest.Name = "OrderShippingDateTest";
            OrderShippingDateTest.ResultSet = 1;
            // 
            // ProductSCD1TestStage1_TestAction
            // 
            ProductSCD1TestStage1_TestAction.Conditions.Add(ProductSCD1TestStage1CountRows);
            ProductSCD1TestStage1_TestAction.Conditions.Add(ProductSCD1TestStage1ProductName);
            ProductSCD1TestStage1_TestAction.Conditions.Add(ProductSCD1TestStage1CategoryName);
            ProductSCD1TestStage1_TestAction.Conditions.Add(ProductSCD1TestStage1JSON_value);
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
            // ProductSCD1TestStage1JSON_value
            // 
            ProductSCD1TestStage1JSON_value.ColumnNumber = 1;
            ProductSCD1TestStage1JSON_value.Enabled = true;
            ProductSCD1TestStage1JSON_value.ExpectedValue = "SSIS";
            ProductSCD1TestStage1JSON_value.Name = "ProductSCD1TestStage1JSON_value";
            ProductSCD1TestStage1JSON_value.NullExpected = false;
            ProductSCD1TestStage1JSON_value.ResultSet = 2;
            ProductSCD1TestStage1JSON_value.RowNumber = 2;
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
            // CutoffTimeTest_TestAction
            // 
            CutoffTimeTest_TestAction.Conditions.Add(CutoffTimeTestMinValue);
            CutoffTimeTest_TestAction.Conditions.Add(CutoffTimeTestMaxValue);
            resources.ApplyResources(CutoffTimeTest_TestAction, "CutoffTimeTest_TestAction");
            // 
            // CutoffTimeTestMinValue
            // 
            CutoffTimeTestMinValue.ColumnNumber = 1;
            CutoffTimeTestMinValue.Enabled = true;
            CutoffTimeTestMinValue.ExpectedValue = "1997-12-31 00:00:00";
            CutoffTimeTestMinValue.Name = "CutoffTimeTestMinValue";
            CutoffTimeTestMinValue.NullExpected = false;
            CutoffTimeTestMinValue.ResultSet = 1;
            CutoffTimeTestMinValue.RowNumber = 1;
            // 
            // CutoffTimeTestMaxValue
            // 
            CutoffTimeTestMaxValue.ColumnNumber = 1;
            CutoffTimeTestMaxValue.Enabled = true;
            CutoffTimeTestMaxValue.ExpectedValue = "1997-12-31 00:00:00";
            CutoffTimeTestMaxValue.Name = "CutoffTimeTestMaxValue";
            CutoffTimeTestMaxValue.NullExpected = false;
            CutoffTimeTestMaxValue.ResultSet = 1;
            CutoffTimeTestMaxValue.RowNumber = 1;
            // 
            // UpdatePartitionSchema_TestAction
            // 
            UpdatePartitionSchema_TestAction.Conditions.Add(NumberPartitionBoundaries);
            UpdatePartitionSchema_TestAction.Conditions.Add(CheckHashBeforeLoad);
            resources.ApplyResources(UpdatePartitionSchema_TestAction, "UpdatePartitionSchema_TestAction");
            // 
            // NumberPartitionBoundaries
            // 
            NumberPartitionBoundaries.Enabled = true;
            NumberPartitionBoundaries.Name = "NumberPartitionBoundaries";
            NumberPartitionBoundaries.ResultSet = 1;
            NumberPartitionBoundaries.RowCount = 46;
            // 
            // CheckHashBeforeLoad
            // 
            CheckHashBeforeLoad.Checksum = "-551393516";
            CheckHashBeforeLoad.Enabled = true;
            CheckHashBeforeLoad.Name = "CheckHashBeforeLoad";
            // 
            // PartitionsManagingTest_TestAction
            // 
            PartitionsManagingTest_TestAction.Conditions.Add(DataCommpression);
            PartitionsManagingTest_TestAction.Conditions.Add(IsFileGroupReadOnly);
            PartitionsManagingTest_TestAction.Conditions.Add(FileGroupName);
            PartitionsManagingTest_TestAction.Conditions.Add(PartitionRange);
            resources.ApplyResources(PartitionsManagingTest_TestAction, "PartitionsManagingTest_TestAction");
            // 
            // DataCommpression
            // 
            DataCommpression.ColumnNumber = 7;
            DataCommpression.Enabled = true;
            DataCommpression.ExpectedValue = "COLUMNSTORE_ARCHIVE";
            DataCommpression.Name = "DataCommpression";
            DataCommpression.NullExpected = false;
            DataCommpression.ResultSet = 1;
            DataCommpression.RowNumber = 3;
            // 
            // IsFileGroupReadOnly
            // 
            IsFileGroupReadOnly.ColumnNumber = 9;
            IsFileGroupReadOnly.Enabled = true;
            IsFileGroupReadOnly.ExpectedValue = "true";
            IsFileGroupReadOnly.Name = "IsFileGroupReadOnly";
            IsFileGroupReadOnly.NullExpected = false;
            IsFileGroupReadOnly.ResultSet = 1;
            IsFileGroupReadOnly.RowNumber = 3;
            // 
            // FileGroupName
            // 
            FileGroupName.ColumnNumber = 8;
            FileGroupName.Enabled = true;
            FileGroupName.ExpectedValue = "Order_1996_Data";
            FileGroupName.Name = "FileGroupName";
            FileGroupName.NullExpected = false;
            FileGroupName.ResultSet = 1;
            FileGroupName.RowNumber = 3;
            // 
            // PartitionRange
            // 
            PartitionRange.ColumnNumber = 4;
            PartitionRange.Enabled = true;
            PartitionRange.ExpectedValue = "1998-01-01 00:00:00.000";
            PartitionRange.Name = "PartitionRange";
            PartitionRange.NullExpected = false;
            PartitionRange.ResultSet = 1;
            PartitionRange.RowNumber = 5;
            // 
            // UnknownMemberTest_TestAction
            // 
            UnknownMemberTest_TestAction.Conditions.Add(UnknownMemberTestCountRows);
            UnknownMemberTest_TestAction.Conditions.Add(UnknownMemberTestEmployeeKey);
            UnknownMemberTest_TestAction.Conditions.Add(UnknownMemberTestCustomerKey);
            UnknownMemberTest_TestAction.Conditions.Add(UnknownMemberTestProductKey);
            resources.ApplyResources(UnknownMemberTest_TestAction, "UnknownMemberTest_TestAction");
            // 
            // UnknownMemberTestCountRows
            // 
            UnknownMemberTestCountRows.Enabled = true;
            UnknownMemberTestCountRows.Name = "UnknownMemberTestCountRows";
            UnknownMemberTestCountRows.ResultSet = 1;
            UnknownMemberTestCountRows.RowCount = 3;
            // 
            // UnknownMemberTestEmployeeKey
            // 
            UnknownMemberTestEmployeeKey.ColumnNumber = 1;
            UnknownMemberTestEmployeeKey.Enabled = true;
            UnknownMemberTestEmployeeKey.ExpectedValue = "-1";
            UnknownMemberTestEmployeeKey.Name = "UnknownMemberTestEmployeeKey";
            UnknownMemberTestEmployeeKey.NullExpected = false;
            UnknownMemberTestEmployeeKey.ResultSet = 1;
            UnknownMemberTestEmployeeKey.RowNumber = 1;
            // 
            // UnknownMemberTestCustomerKey
            // 
            UnknownMemberTestCustomerKey.ColumnNumber = 2;
            UnknownMemberTestCustomerKey.Enabled = true;
            UnknownMemberTestCustomerKey.ExpectedValue = "-1";
            UnknownMemberTestCustomerKey.Name = "UnknownMemberTestCustomerKey";
            UnknownMemberTestCustomerKey.NullExpected = false;
            UnknownMemberTestCustomerKey.ResultSet = 1;
            UnknownMemberTestCustomerKey.RowNumber = 1;
            // 
            // UnknownMemberTestProductKey
            // 
            UnknownMemberTestProductKey.ColumnNumber = 3;
            UnknownMemberTestProductKey.Enabled = true;
            UnknownMemberTestProductKey.ExpectedValue = "-1";
            UnknownMemberTestProductKey.Name = "UnknownMemberTestProductKey";
            UnknownMemberTestProductKey.NullExpected = false;
            UnknownMemberTestProductKey.ResultSet = 1;
            UnknownMemberTestProductKey.RowNumber = 1;
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
            // OrderShippingDateTestData
            // 
            this.OrderShippingDateTestData.PosttestAction = null;
            this.OrderShippingDateTestData.PretestAction = null;
            this.OrderShippingDateTestData.TestAction = OrderShippingDateTest_TestAction;
            // 
            // ProductSCD1TestStage1Data
            // 
            this.ProductSCD1TestStage1Data.PosttestAction = null;
            this.ProductSCD1TestStage1Data.PretestAction = null;
            this.ProductSCD1TestStage1Data.TestAction = ProductSCD1TestStage1_TestAction;
            // 
            // ProductSCD1TestStage2Data
            // 
            this.ProductSCD1TestStage2Data.PosttestAction = null;
            this.ProductSCD1TestStage2Data.PretestAction = null;
            this.ProductSCD1TestStage2Data.TestAction = ProductSCD1TestStage2_TestAction;
            // 
            // CutoffTimeTestData
            // 
            this.CutoffTimeTestData.PosttestAction = null;
            this.CutoffTimeTestData.PretestAction = null;
            this.CutoffTimeTestData.TestAction = CutoffTimeTest_TestAction;
            // 
            // UpdatePartitionSchemaData
            // 
            this.UpdatePartitionSchemaData.PosttestAction = null;
            this.UpdatePartitionSchemaData.PretestAction = null;
            this.UpdatePartitionSchemaData.TestAction = UpdatePartitionSchema_TestAction;
            // 
            // PartitionsManagingTestData
            // 
            this.PartitionsManagingTestData.PosttestAction = null;
            this.PartitionsManagingTestData.PretestAction = null;
            this.PartitionsManagingTestData.TestAction = PartitionsManagingTest_TestAction;
            // 
            // UnknownMemberTestData
            // 
            this.UnknownMemberTestData.PosttestAction = null;
            this.UnknownMemberTestData.PretestAction = null;
            this.UnknownMemberTestData.TestAction = UnknownMemberTest_TestAction;
        }

        #endregion

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class

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
        public void OrderShippingDateTest()
        {
            SqlDatabaseTestActions testActions = this.OrderShippingDateTestData;
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
        public void CutoffTimeTest()
        {
            SqlDatabaseTestActions testActions = this.CutoffTimeTestData;
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
        [TestMethod()]
        public void UpdatePartitionSchema()
        {
            SqlDatabaseTestActions testActions = this.UpdatePartitionSchemaData;
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
        [TestMethod()]
        public void PartitionsManagingTest()
        {
            SqlDatabaseTestActions testActions = this.PartitionsManagingTestData;
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
        public void UnknownMemberTest()
        {
            SqlDatabaseTestActions testActions = this.UnknownMemberTestData;
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
        private SqlDatabaseTestActions OrderShippingDateTestData;
        private SqlDatabaseTestActions ProductSCD1TestStage1Data;
        private SqlDatabaseTestActions ProductSCD1TestStage2Data;
        private SqlDatabaseTestActions CutoffTimeTestData;
        private SqlDatabaseTestActions UpdatePartitionSchemaData;
        private SqlDatabaseTestActions PartitionsManagingTestData;
        private SqlDatabaseTestActions UnknownMemberTestData;
    }
}
