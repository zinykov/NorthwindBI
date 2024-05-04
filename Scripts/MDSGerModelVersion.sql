SELECT		TOP(1) MV.[Name]
FROM		[mdm].[tblModelVersion] AS MV
INNER JOIN	[mdm].[tblModelVersionFlag] AS F ON F.[ID] = MV.[VersionFlag_ID]
INNER JOIN	[mdm].[tblModel] AS M ON M.[ID] = MV.[Model_ID]
WHERE		M.[Name] = ?
			AND F.[Name] = N'SSIS'