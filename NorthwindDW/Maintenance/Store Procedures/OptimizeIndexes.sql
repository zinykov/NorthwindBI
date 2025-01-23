CREATE PROCEDURE [Maintenance].[OptimizeIndexes]
	  @Database AS NVARCHAR(50) = '$(DatabaseName)'
	, @ReorganazeCutoff AS TINYINT = 5
	, @RebuildCutoff AS TINYINT = 30
AS BEGIN
	DECLARE @DatabaseID			AS SMALLINT;  
	DECLARE @ObjectID			AS INT;
	DECLARE @ObjectName			AS NVARCHAR(50);
	DECLARE @PartitionNumber	AS SMALLINT;
	DECLARE @IndexID			AS SMALLINT;
	DECLARE @Index				AS NVARCHAR(200);
	DECLARE @DataCompression	AS NVARCHAR(100);
	DECLARE @AvgFragmentation	AS TINYINT;
	DECLARE @SQLstatment		AS NVARCHAR(2000);
	DECLARE @PartitionScheme	AS NVARCHAR(50);
	DECLARE @StartTime			AS DATETIME2		= GETDATE();
	DECLARE	@UserName			AS NVARCHAR(128)	= SYSTEM_USER;

	DECLARE OptimizeIndexes CURSOR FOR 
		SELECT		  [Database]		= DB_ID ( @Database )
					, [ObjectID]		= OBJECT_ID ( CONCAT ( '[', S.[name], '].[', T.[name], ']' ) )
					, [ObjectName]		= CONCAT ( '[', S.[name], '].[', T.[name], ']' )
					, [PartitionNumber]	= P.[partition_number]
					, [IndexID]			= I.[index_id]
					, [Index]			= I.[name]
					, [DataCompression]	= P.[data_compression_desc]
					, [PartitionScheme]	= PS.[name]

		FROM		sys.tables AS T
		INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
		INNER JOIN	sys.partitions AS P ON T.[object_id] = P.[object_id]
		INNER JOIN	sys.indexes AS I ON T.[object_id] = I.[object_id]
					AND P.[index_id] = I.[index_id]
		LEFT JOIN	sys.partition_schemes AS PS ON PS.[data_space_id] = I.[data_space_id]
		LEFT JOIN	sys.destination_data_spaces AS DDS ON DDS.[partition_scheme_id] = PS.[data_space_id]
					AND DDS.[destination_id] = P.[partition_number]
		LEFT JOIN	sys.filegroups AS FG WITH (NOLOCK) ON FG.[data_space_id] = I.[data_space_id]
		LEFT JOIN	sys.filegroups AS FGP WITH (NOLOCK) ON FGP.[data_space_id] = DDS.[data_space_id]
		
		WHERE		( FG.[is_read_only] = 0 OR FGP.[is_read_only] = 0 )
					AND I.[index_id] > 0

		ORDER BY	  S.[schema_id]
					, T.[name]
					, P.[partition_number]
					, I.[index_id]

	OPEN OptimizeIndexes
		
		FETCH NEXT FROM OptimizeIndexes INTO 
			  @DatabaseID
			, @ObjectID
			, @ObjectName
			, @PartitionNumber
			, @IndexID
			, @Index
			, @DataCompression
			, @PartitionScheme
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @AvgFragmentation = ( SELECT MAX ( CAST ( [avg_fragmentation_in_percent] AS TINYINT ) ) FROM sys.dm_db_index_physical_stats ( @DatabaseID, @ObjectID, @IndexID, @PartitionNumber , 'LIMITED' ) )

				IF @AvgFragmentation BETWEEN @ReorganazeCutoff AND @RebuildCutoff
					BEGIN
						IF @PartitionScheme IS NOT NULL
							SET @SQLstatment = CONCAT ( 'ALTER INDEX [', @Index, '] ON ', @ObjectName, ' REORGANIZE PARTITION = ', @PartitionNumber, ';' )
						ELSE SET @SQLstatment = CONCAT ( 'ALTER INDEX [', @Index, '] ON ', @ObjectName, ' REORGANIZE;' )
								
						EXECUTE sp_executesql @stmt = @SQLstatment
					END
				ELSE IF @AvgFragmentation > @RebuildCutoff
					BEGIN
						IF @PartitionScheme IS NOT NULL
							SET @SQLstatment = CONCAT ( 'ALTER INDEX [', @Index, '] ON ', @ObjectName, ' REBUILD PARTITION = ', @PartitionNumber, ' WITH ( DATA_COMPRESSION = ', @DataCompression, ' );' )
						ELSE SET @SQLstatment = CONCAT ( 'ALTER INDEX [', @Index, '] ON ', @ObjectName, ' REBUILD WITH ( DATA_COMPRESSION = ', @DataCompression, ' );' )
								
						EXECUTE sp_executesql @stmt = @SQLstatment
					END

				FETCH NEXT FROM OptimizeIndexes INTO 
					  @DatabaseID
					, @ObjectID
					, @ObjectName
					, @PartitionNumber
					, @IndexID
					, @Index
					, @DataCompression
					, @PartitionScheme
			END
	CLOSE OptimizeIndexes
	DEALLOCATE OptimizeIndexes;
END