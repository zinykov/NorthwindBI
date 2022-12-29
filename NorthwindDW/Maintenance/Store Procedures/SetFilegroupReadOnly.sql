CREATE PROCEDURE [Maintenance].[SetFilegroupReadOnly]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
AS BEGIN
-- Пометка файловых групп для предпредыдущего года архивация и пометка только для чтения
    DECLARE @CutoffTimeYear AS INT;
    DECLARE @FileGroupDataName AS NVARCHAR(200);
	DECLARE @FileGroupIndexName AS NVARCHAR(200);
    DECLARE @SQL AS NVARCHAR(2000);

	SET @CutoffTimeYear = YEAR ( @CutoffTime ) - 2
    SET @SQL = CONCAT (
          N'ALTER INDEX [CCI_Fact_Order] ON [Fact].[Order] REBUILD PARTITION = $PARTITION.[PF_Order_Date] ( '
        , @CutoffTimeYear * 10000 + 101
        , N' ) WITH ( DATA_COMPRESSION = COLUMNSTORE_ARCHIVE );'
    )
	SET @FileGroupDataName = CONCAT ( @FactTableName, N'_', @CutoffTimeYear, '_Data' )
	SET @FileGroupIndexName = CONCAT ( @FactTableName, N'_', @CutoffTimeYear, '_Index' )

	EXECUTE sp_executesql @SQL
    
    IF EXISTS ( SELECT 1 FROM sys.filegroups WHERE [name] = @FileGroupDataName AND [is_read_only] = 0 )
		BEGIN
            --SELECT @SQL = CONCAT ( @SQL, N'KILL ', CONVERT(varchar(5), session_id), N'; ' )
			--FROM sys.dm_exec_sessions
			--WHERE database_id  = db_id('$(DatabaseName)')

			--EXECUTE sp_executesql @SQL

			SET @SQL = CONCAT ( N'ALTER DATABASE [NorthwindDW] MODIFY FILEGROUP [', @FileGroupDataName, N'] READ_ONLY;' )

			EXECUTE sp_executesql @SQL
		END
	IF EXISTS ( SELECT 1 FROM sys.filegroups WHERE [name] = @FileGroupDataName AND [is_read_only] = 0 )
		BEGIN
			--SELECT @SQL = CONCAT ( @SQL, N'KILL ', CONVERT(varchar(5), [session_id] ), N'; ' )
			--FROM sys.dm_exec_sessions
			--WHERE [database_id]  = DB_ID ( '$(DatabaseName)' )

			--EXECUTE sp_executesql @SQL

			SET @SQL = CONCAT ( N'ALTER DATABASE [NorthwindDW] MODIFY FILEGROUP [', @FileGroupIndexName, N'] READ_ONLY;' )

			EXECUTE sp_executesql @SQL
		END

	RETURN 0
END