CREATE PROCEDURE [Integration].[GetStartDate]
	@TableName AS NVARCHAR(30)
AS BEGIN
	IF EXISTS ( SELECT 1 FROM [Integration].[Lineage] WHERE [TableName] = @TableName AND [WasSuccessful] = 1 )
		SELECT StartLoadDate = MAX ( [CutoffTime] ) FROM [Integration].[Lineage] WHERE [TableName] = @TableName AND [WasSuccessful] = 1
	ELSE SELECT StartLoadDate = DATEFROMPARTS ( 1996, 1, 1 );
END
