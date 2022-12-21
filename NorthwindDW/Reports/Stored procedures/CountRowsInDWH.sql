CREATE PROCEDURE [Reports].[CountRowsInDWH]
	WITH EXECUTE AS OWNER
AS BEGIN
	SELECT		  [Schema]			= S.[name]
				, [Table]			= T.[name]
				, [PartitionNumber]	= P.[partition_number]
				, [PartitionRange]	= PRV.[value]
				, [IndexID]			= I.[index_id]
				, [IndexType]		= I.[type_desc]
				, [DataCompression]	= P.[data_compression_desc]
				, [NumRows]			= P.[rows]
	
	FROM		sys.tables AS T
	INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
	LEFT JOIN	sys.partitions AS P ON T.[object_id] = P.[object_id]
	LEFT JOIN	sys.indexes AS I ON T.[object_id] = I.[object_id]
				AND P.[index_id] = I.[index_id]
	LEFT JOIN	sys.partition_range_values AS PRV ON P.[partition_number] = $PARTITION.[PF_Order_Date] ( CAST ( PRV.[value] AS INT ) )
	
	ORDER BY	  S.[schema_id]
				, T.[name]
				, P.[partition_number]
				, I.[index_id]
END
