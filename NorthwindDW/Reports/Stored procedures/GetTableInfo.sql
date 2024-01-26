CREATE PROCEDURE [dbo].[GetTableInfo]
AS BEGIN
	IF OBJECT_ID ( N'tempdb..#tblspaceused' ) IS NULL
		BEGIN
			CREATE TABLE #tblspaceused (
				  [name]		NVARCHAR(128)
				, [rows]		char(20)
				, [reserved]	varchar(18)
				, [data]		varchar(18)
				, [index_size]	varchar(18)
				, [unused]		varchar(18)
			)
		END

	IF OBJECT_ID ( N'tempdb..#tblresult' ) IS NULL
		BEGIN
			CREATE TABLE #tblresult (
				  [object_id]	INT
				, [schema]		NVARCHAR(128)
				, [name]		NVARCHAR(128)
				, [rows]		BIGINT
				, [reserved]	BIGINT
				, [data]		BIGINT
				, [index_size]	BIGINT
				, [unused]		BIGINT
			)
		END

	DECLARE @SchemaName AS NVARCHAR(128)
	DECLARE @TableName AS NVARCHAR(128)
	DECLARE @objname AS NVARCHAR(776)
	DECLARE @object_id AS INT
	DECLARE [GetTableSizeAndRows] CURSOR FOR
		SELECT		  [SchemaName]	= S.[name]
					, [TableName]	= T.[name]
					, [object_id]	= T.[object_id]
		FROM		sys.tables AS T
		INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]

	OPEN [GetTableSizeAndRows]
		FETCH NEXT FROM [GetTableSizeAndRows] INTO @SchemaName, @TableName, @object_id
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @objname = CONCAT ( @SchemaName, '.', @TableName )

				INSERT INTO #tblspaceused (
					  [name]
					, [rows]
					, [reserved]
					, [data]
					, [index_size]
					, [unused]
				)
				EXECUTE sp_spaceused @objname = @objname

				INSERT INTO #tblresult (
					  [object_id]
					, [schema]
					, [name]
					, [rows]
					, [reserved]
					, [data]
					, [index_size]
					, [unused]
				)
				SELECT	  @object_id
						, @SchemaName
						, [name]
						, [rows]			= CAST ( [rows] AS BIGINT )
						, [reserved]		= CAST ( LEFT ( [reserved], LEN ( [reserved] ) - 3 ) AS BIGINT )
						, [data]			= CAST ( LEFT ( [data], LEN ( [data] ) - 3 ) AS BIGINT )
						, [index_size]		= CAST ( LEFT ( [index_size], LEN ( [index_size] ) - 3 ) AS BIGINT )
						, [unused]			= CAST ( LEFT ( [unused], LEN ( [unused] ) - 3 ) AS BIGINT )
				FROM	#tblspaceused

				TRUNCATE TABLE #tblspaceused
				FETCH NEXT FROM [GetTableSizeAndRows] INTO @SchemaName, @TableName, @object_id
			END
	CLOSE [GetTableSizeAndRows]
	DEALLOCATE [GetTableSizeAndRows]

	SELECT		  T.[schema]
				, T.[name]
				, SEP.[value] AS [Description]
				, T.[rows]
				, T.[reserved]
				, T.[data]
				, T.[index_size]
				, T.[unused]
	FROM		#tblresult AS T
	LEFT JOIN  sys.extended_properties AS SEP ON T.[object_id] = SEP.[major_id]
				AND SEP.[minor_id] = 0
				AND SEP.[name] = N'MS_Description'

	SELECT * FROM #tblresult

	--SELECT		  [schema]
	--			--, [name]
	--			, [rows]		= FORMAT ( SUM ( [rows] ), N'#,##0', N'RU-RU' )
	--			, [reserved]	= FORMAT ( SUM ( [reserved] ), N'#,##0', N'RU-RU' )
	--			, [data]		= FORMAT ( SUM ( [data] ), N'#,##0', N'RU-RU' )
	--			, [index_size]	= FORMAT ( SUM ( [index_size] ), N'#,##0', N'RU-RU' )
	--			, [unused]		= FORMAT ( SUM ( [unused] ), N'#,##0', N'RU-RU' )
	--FROM		#tblresult
	--WHERE		[schema] IN ( N'Fact', N'Dimension' )
	--GROUP BY	[schema] WITH ROLLUP

	IF OBJECT_ID ( N'tempdb..#tblspaceused' ) IS NOT NULL DROP TABLE #tblspaceused
	IF OBJECT_ID ( N'tempdb..#tblresult' ) IS NOT NULL DROP TABLE #tblresult
END