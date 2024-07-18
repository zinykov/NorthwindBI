CREATE PROCEDURE [Reports].[GetColumnDistribution]
AS BEGIN
    DECLARE @objectid AS INT;
    DECLARE @columnid AS INT;
    DECLARE @SchemaName AS SYSNAME;
    DECLARE @TableName AS SYSNAME;
    DECLARE @ColumnName AS SYSNAME;
    DECLARE @Parameters AS NVARCHAR(MAX) = N'@objectid INT, @columnid INT';
    DECLARE @GetDistribution AS NVARCHAR(MAX);

    IF OBJECT_ID ( N'tempdb..#GetColumsInfo' ) IS NULL
        CREATE TABLE #GetColumsInfo (
              [ObjectId]        INT
            , [ColumnId]        INT
            , [SchemaName]      SYSNAME
            , [TableName]       SYSNAME
            , [ColumnName]      SYSNAME
            , [DataType]        NVARCHAR(100)
        );

    IF OBJECT_ID ( N'tempdb..#GetColumsDistribution' ) IS NULL
        CREATE TABLE #GetColumsDistribution (
              [ObjectId]        INT
            , [ColumnId]        INT
            , [SchemaName]      SYSNAME
            , [TableName]       SYSNAME
            , [ColumnName]      SYSNAME
            , [ColumnValue]     NVARCHAR(MAX)
            , [CountDistinct]   BIGINT
        );

    INSERT INTO #GetColumsInfo (
          [ObjectId]
        , [ColumnId]
        , [SchemaName]
        , [TableName]
        , [ColumnName]
        , [DataType]
    )
        SELECT        ST.[object_id]
                    , SC.[column_id]
                    , S.[name]
                    , ST.[name]
                    , SC.[name]
                    , CONCAT( Q.[DATA_TYPE], ISNULL( 
                            CASE
                                WHEN Q.[DATA_TYPE] IN ( N'binary', N'varbinary'                    ) THEN ( CASE Q.[CHARACTER_OCTET_LENGTH]   WHEN -1 THEN N'(max)' ELSE CONCAT( N'(', Q.[CHARACTER_OCTET_LENGTH]  , N')' ) END )
                                WHEN Q.[DATA_TYPE] IN ( N'char', N'varchar', N'nchar', N'nvarchar' ) THEN ( CASE Q.[CHARACTER_MAXIMUM_LENGTH] WHEN -1 THEN N'(max)' ELSE CONCAT( N'(', Q.[CHARACTER_MAXIMUM_LENGTH], N')' ) END )
                                WHEN Q.[DATA_TYPE] IN ( N'datetime2', N'datetimeoffset'            ) THEN CONCAT( N'(', Q.[DATETIME_PRECISION], N')' )
                                WHEN Q.[DATA_TYPE] IN ( N'decimal', N'numeric'                     ) THEN CONCAT( N'(', Q.[NUMERIC_PRECISION] , N',', Q.[NUMERIC_SCALE], N')' )
                            END
                        , N'' ) )
    
        FROM        sys.tables AS ST
        INNER JOIN  sys.schemas AS S ON ST.[schema_id] = S.[schema_id]
        INNER JOIN  sys.columns AS SC ON ST.[object_id] = SC.[object_id]
        INNER JOIN  INFORMATION_SCHEMA.COLUMNS AS Q ON ST.[name] = Q.[TABLE_NAME]
                    AND S.[name] = Q.[TABLE_SCHEMA]
                    AND SC.[name] = Q.[COLUMN_NAME];

    DECLARE [GetColumnInfoCursor] CURSOR FOR
        SELECT        [ObjectId]
                    , [ColumnId]
                    , [SchemaName]
                    , [TableName]
                    , [ColumnName]
        FROM        #GetColumsInfo
        WHERE       [DataType] NOT IN ( N'bit', N'image', N'ntext', N'text' );

    OPEN [GetColumnInfoCursor]
        FETCH NEXT FROM [GetColumnInfoCursor] INTO @objectid, @columnid, @SchemaName, @TableName, @ColumnName
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @GetDistribution = CONCAT ( N'
                    INSERT INTO #GetColumsDistribution (
                          [ObjectId]
                        , [ColumnId]
                        , [SchemaName]
                        , [TableName]
                        , [ColumnName]
                        , [ColumnValue]
                        , [CountDistinct]
                    )
                    SELECT        ', @objectid, N'
                                , ', @columnid, N'
                                , N''', @SchemaName, N'''
                                , N''', @TableName, N'''
                                , N''', @ColumnName, N'''
                                , CAST ( ', QUOTENAME ( @ColumnName ),N' AS NVARCHAR(MAX) )
                                , COUNT_BIG ( * )
                    FROM        ', QUOTENAME ( @SchemaName ), N'.', QUOTENAME ( @TableName ), '
                    GROUP BY    ', QUOTENAME ( @ColumnName ) )
            
                EXECUTE sp_executesql @GetDistribution;

                FETCH NEXT FROM [GetColumnInfoCursor] INTO @objectid, @columnid, @SchemaName, @TableName, @ColumnName
            END;
    CLOSE [GetColumnInfoCursor];
    DEALLOCATE [GetColumnInfoCursor];

    SELECT * FROM #GetColumsDistribution;

    IF OBJECT_ID ( N'tempdb..#GetColumsInfo' ) IS NOT NULL DROP TABLE #GetColumsInfo;
    IF OBJECT_ID ( N'tempdb..#GetColumsDistribution' ) IS NOT NULL DROP TABLE #GetColumsDistribution;
END