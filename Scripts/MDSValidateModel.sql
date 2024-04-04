DECLARE @Model_id INT
DECLARE @User_ID INT
DECLARE @Version_ID INT

SET @User_ID    = ( SELECT U.[ID] FROM [mdm].[tblUser] AS U WHERE U.[UserName] = ? )
SET @Model_ID   = ( SELECT TOP 1 [Model_ID] FROM [mdm].[viw_SYSTEM_SCHEMA_VERSION] WHERE [Model_Name] = ? )
SET @Version_ID = ( SELECT MAX ( [ID] ) FROM [mdm].[viw_SYSTEM_SCHEMA_VERSION] WHERE [Model_ID] = @Model_ID )
  
EXECUTE [mdm].[udpValidateModel] @User_ID, @Model_ID, @Version_ID, 1