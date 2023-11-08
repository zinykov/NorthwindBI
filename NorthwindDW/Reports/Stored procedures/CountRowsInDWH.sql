CREATE PROCEDURE [Reports].[CountRowsInDWH]
AS BEGIN
	SELECT		  DISTINCT [Schema]		= S.[name]
				, [Table]				= T.[name]
				, [PartitionNumber]		= P.[partition_number]
				, [PartitionRange]		= CONVERT ( DATE, PRV.[value], 23 )
				, [IndexID]				= I.[index_id]
				, [IndexType]			= I.[type_desc]
				, [DataCompression]		= P.[data_compression_desc]
				, [FileGroupName]		= COALESCE ( FG.[name], FGP.[name] )
				, [IsFileGroupReadOnly]	= COALESCE ( FG.[is_read_only], FGP.[is_read_only] )
				--, [avg_fragmentation]	= DMV.[avg_fragmentation_in_percent] / 100
				--, dmv.Fragment_Count
				--, dmv.Avg_Fragment_Size_In_Pages
				--, dmv.Page_Count 
				, [NumRows]				= P.[rows]
	
	FROM		sys.tables AS T
	INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
	LEFT JOIN	sys.partitions AS P ON T.[object_id] = P.[object_id]
	LEFT JOIN	sys.indexes AS I ON T.[object_id] = I.[object_id]
				AND P.[index_id] = I.[index_id]
	LEFT JOIN	sys.partition_range_values AS PRV ON P.[partition_number] = $PARTITION.[PF_Order_Date] ( CAST ( PRV.[value] AS DATE ) )
	LEFT JOIN	sys.data_spaces AS DS ON DS.[data_space_id] = I.[data_space_id]
	LEFT JOIN	sys.partition_schemes AS PS ON PS.[data_space_id] = DS.[data_space_id]
	LEFT JOIN	sys.partition_functions AS PF ON PF.[function_id] = PS.[function_id]
	LEFT JOIN	sys.destination_data_spaces AS DDS ON DDS.[partition_scheme_id] = PS.[data_space_id]
				AND DDS.[destination_id] = P.[partition_number]
	LEFT JOIN	sys.filegroups AS FG ON FG.[data_space_id] = I.[data_space_id]
	LEFT JOIN	sys.filegroups AS FGP ON FGP.[data_space_id] = DDS.[data_space_id]
	--INNER JOIN	sys.dm_db_index_physical_stats ( DB_ID(), NULL, NULL , NULL, N'LIMITED' ) DMV ON DMV.[object_id] = I.[object_id]
	--			AND DMV.[index_id] = I.[index_id]
	--			AND DMV.[partition_number]  = P.[partition_number]
	
	WHERE		OBJECTPROPERTY ( P.[object_id], 'ISMSShipped') = 0
	
	ORDER BY	  S.[name]
				, T.[name]
				, P.[partition_number]
				, I.[index_id]
END