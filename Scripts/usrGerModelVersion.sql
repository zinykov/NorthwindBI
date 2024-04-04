CREATE OR ALTER PROCEDURE [usr].[GetModelVersion] 
	  @ModelName NVARCHAR(50)
	, @Flag NVARCHAR(50)
	, @VersionName NVARCHAR(50) OUTPUT
AS BEGIN
	SET @VersionName = (
		SELECT		TOP(1) MV.[Name]

		FROM		[mdm].[tblModelVersion] AS MV
		INNER JOIN	[mdm].[tblModelVersionFlag] AS F ON F.[ID] = MV.[VersionFlag_ID]
		INNER JOIN	[mdm].[tblModel] AS M ON M.[ID] = MV.[Model_ID]

		WHERE		M.[Name] = @ModelName
					AND F.[Name] = @Flag
	)
END;
GO