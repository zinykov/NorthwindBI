CREATE PROCEDURE [Reports].[GetColumnDisributionInfo]
AS BEGIN
    DECLARE @objectid AS INT;
    DECLARE @columnid AS INT;
    DECLARE @SchemaName AS SYSNAME;
    DECLARE @TableName AS SYSNAME;
    DECLARE @ColumnName AS SYSNAME;
    DECLARE @Parameters AS NVARCHAR(MAX) = N'@objectid INT, @columnid INT';
    DECLARE @GetDistribution AS NVARCHAR(MAX);

    IF OBJECT_ID ( N'tempdb..#GetColumnInfo' ) IS NULL
        CREATE TABLE #GetColumnInfo (
              [ObjectId]        INT
            , [ColumnId]        INT
            , [SchemaName]      SYSNAME
            , [TableName]       SYSNAME
            , [ColumnName]      SYSNAME
        );

    IF OBJECT_ID ( N'tempdb..#GetColumnDistribution' ) IS NULL
        CREATE TABLE #GetColumnDistribution (
              [ObjectId]        INT
            , [ColumnId]        INT
            , [ColumnValue]     NVARCHAR(MAX)
            , [CountDistinct]   BIGINT
        );

    INSERT INTO #GetColumnInfo (
          [ObjectId]
        , [ColumnId]
        , [SchemaName]
        , [TableName]
        , [ColumnName]
    )
        SELECT        ST.[object_id]
                    , SC.[column_id]
                    , S.[name]
                    , ST.[name]
                    , SC.[name]
    
        FROM        sys.tables AS ST
        INNER JOIN  sys.schemas AS S ON ST.[schema_id] = S.[schema_id]
        INNER JOIN  sys.columns AS SC ON ST.[object_id] = SC.[object_id]
        LEFT JOIN   sys.extended_properties AS SEP ON ST.[object_id] = SEP.[major_id]
                    AND SC.[column_id] = SEP.[minor_id]
                    AND SEP.[name] = N'MS_Description'
        INNER JOIN  INFORMATION_SCHEMA.COLUMNS AS Q ON ST.[name] = Q.[TABLE_NAME]
                    AND S.[name] = Q.[TABLE_SCHEMA]
                    AND SC.[name] = Q.[COLUMN_NAME];

    DECLARE [GetColumnInfoCursor] CURSOR FOR
        SELECT        [ObjectId]
                    , [ColumnId]
                    , [SchemaName]
                    , [TableName]
                    , [ColumnName]
        FROM        #GetColumnInfo
        WHERE       [DataType] NOT IN ( N'bit', N'image', N'ntext', N'text' );

    OPEN [GetColumnInfoCursor]
        FETCH NEXT FROM [GetColumnInfoCursor] INTO @objectid, @columnid, @SchemaName, @TableName, @ColumnName
        WHILE @@FETCH_STATUS = 0
            BEGIN

                SET @GetDistribution = CONCAT ( N'
                    INSERT INTO #GetColumnDistribution (
                          [ObjectId]
                        , [ColumnId]
                        , [ColumnValue]
                        , [CountDistinct]
                    )
                    SELECT        ', @objectid, N'
                                , ', @columnid, N'
                                , CAST ( ', QUOTENAME ( @ColumnName ),N' AS NVARCHAR(MAX) )
                                , COUNT_BIG ( * )
                    FROM        ', QUOTENAME ( @SchemaName ), N'.', QUOTENAME ( @TableName ), '
                    GROUP BY    ', QUOTENAME ( @ColumnName ) )

                EXECUTE sp_executesql @GetDistribution;

                FETCH NEXT FROM [GetColumnInfoCursor] INTO @objectid, @columnid, @SchemaName, @TableName, @ColumnName
            END;
    CLOSE [GetColumnInfoCursor];
    DEALLOCATE [GetColumnInfoCursor];

    SELECT * FROM #GetColumnDistribution;

    IF OBJECT_ID ( N'tempdb..#GetColumInfo' ) IS NOT NULL DROP TABLE #GetColumnInfo;
    IF OBJECT_ID ( N'tempdb..#GetColumnDistribution' ) IS NOT NULL DROP TABLE #GetColumnDistribution;
END