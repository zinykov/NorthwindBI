CREATE PROCEDURE [Integration].[ValidateModel]
      @ModelName NVARCHAR(50)
    , @UserName NVARCHAR(50)
AS BEGIN
    DECLARE @Model_id INT
    DECLARE @User_ID INT
    DECLARE @Version_ID INT

    SET @User_ID    = ( SELECT U.[ID] FROM [$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[tblUser] AS U WHERE U.[UserName] = @UserName )
    SET @Model_ID   = ( SELECT TOP 1 [Model_ID] FROM [$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[viw_SYSTEM_SCHEMA_VERSION] WHERE [Model_Name] = @ModelName )
    SET @Version_ID = ( SELECT MAX ( [ID] ) FROM [$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[viw_SYSTEM_SCHEMA_VERSION] WHERE [Model_ID] = @Model_ID )
  
    EXECUTE [$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[udpValidateModel]
          @User_ID
        , @Model_ID
        , @Version_ID
        , 1
END