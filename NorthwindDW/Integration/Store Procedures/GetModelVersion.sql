CREATE PROCEDURE [Integration].[GetModelVersion] 
	  @ModelName NVARCHAR(50)
	, @Flag NVARCHAR(50)
AS BEGIN
	SELECT		TOP(1) MV.[Name]

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[tblModelVersion] AS MV
	INNER JOIN	[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[tblModelVersionFlag] AS F ON F.[ID] = MV.[VersionFlag_ID]
	INNER JOIN	[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[tblModel] AS M ON M.[ID] = MV.[Model_ID]

	WHERE		M.[Name] = @ModelName
				AND F.[Name] = @Flag
END