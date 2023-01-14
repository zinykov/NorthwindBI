CREATE PROCEDURE [Maintenance].[SetFilegroupReadOnly]
	  @CutoffTime AS DATE
	, @FactTableName AS NVARCHAR(100)
AS BEGIN
-- Пометка файловых групп для предпредыдущего года архивация и пометка только для чтения
    DECLARE @CutoffTimeYear AS INT;
    DECLARE @FileGroupDataName AS NVARCHAR(200);
	DECLARE @FileGroupIndexName AS NVARCHAR(200);
    DECLARE @SQL AS NVARCHAR(2000);

	SET @FileGroupDataName = CONCAT ( @FactTableName, N'_', @CutoffTimeYear, '_Data' )
	SET @FileGroupIndexName = CONCAT ( @FactTableName, N'_', @CutoffTimeYear, '_Index' )

    
    IF EXISTS ( SELECT 1 FROM sys.filegroups WHERE [name] = @FileGroupDataName AND [is_read_only] = 0 )
		BEGIN
            SET @SQL = CONCAT ( N'ALTER DATABASE [NorthwindDW] MODIFY FILEGROUP [', @FileGroupDataName, N'] READ_ONLY;' )

			EXECUTE sp_executesql @SQL
		END
	IF EXISTS ( SELECT 1 FROM sys.filegroups WHERE [name] = @FileGroupIndexName AND [is_read_only] = 0 )
		BEGIN
			SET @SQL = CONCAT ( N'ALTER DATABASE [NorthwindDW] MODIFY FILEGROUP [', @FileGroupIndexName, N'] READ_ONLY;' )

			EXECUTE sp_executesql @SQL
		END

	RETURN 0
END