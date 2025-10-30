using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting;

[assembly: DoNotParallelize]

namespace DQS_STAGING_DATA_test
{
    [TestClass()]
    public class DQS_STAGING_DATA_DataTest : SqlDatabaseTestClass
    {
        public DQS_STAGING_DATA_DataTest() => InitializeComponent();

        public DQS_STAGING_DATA_DataTest(TestContext testContext)
        {
            ClassInitialize(testContext);
            InitializeComponent();
        }

        [ClassInitialize()]
        public static void ClassInitialize(TestContext testContext)
        {
            TestService = new OverwritedTestService(testContext);
            if ((string)testContext.Properties["BuildConfiguration"] == "Debug")
                TestService.DeployDatabaseProject();
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
    }
}
