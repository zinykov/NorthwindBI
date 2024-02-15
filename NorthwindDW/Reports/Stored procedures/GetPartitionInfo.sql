CREATE PROCEDURE [Reports].[GetPartitionInfo]
AS BEGIN
	SELECT		  DISTINCT [Schema]			= S.[name]
				, [Table]					= T.[name]
				, [PartitionNumber]			= P.[partition_number]
				, [PartitionRange]			= PRV.[value]
				, [IndexID]					= I.[index_id]
				, [IndexType]				= I.[type_desc]
				, [DataCompression]			= P.[data_compression_desc]
				, [FileGroupName]			= COALESCE ( FG.[name], FGP.[name] )
				, [IsFileGroupReadOnly]		= COALESCE ( FG.[is_read_only], FGP.[is_read_only] )
				, [#Rows]					= P.[rows]
				, [AvgFragmentation]		= DMV.[avg_fragmentation_in_percent] / 100
				, [FragmentCount]			= DMV.[fragment_count]
				, [AvgFragmentSizeInPages]	= DMV.[avg_fragment_size_in_pages]
				, [PageCount]				= DMV.[page_count]
	FROM		sys.tables AS T
	INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
	LEFT JOIN	sys.indexes AS I ON T.[object_id] = I.[object_id]
	LEFT JOIN	sys.partitions AS P ON I.[object_id] = P.[object_id]
				AND I.[index_id] = P.[index_id]
	LEFT JOIN	sys.partition_schemes AS PS ON I.[data_space_id] = PS.[data_space_id]
	LEFT JOIN	sys.partition_functions AS F ON PS.[function_id] = F.[function_id]
	LEFT JOIN	sys.partition_range_values AS PRV ON F.[function_id] = PRV.[function_id]
				AND PRV.[boundary_id] + F.[boundary_value_on_right] = P.[partition_number]
	LEFT JOIN	sys.destination_data_spaces AS DDS ON DDS.[partition_scheme_id] = PS.[data_space_id]
				AND DDS.[destination_id] = P.[partition_number]
	LEFT JOIN	sys.filegroups AS FG ON FG.[data_space_id] = I.[data_space_id]
	LEFT JOIN	sys.filegroups AS FGP ON FGP.[data_space_id] = DDS.[data_space_id]
	INNER JOIN	sys.dm_db_index_physical_stats ( DB_ID(), NULL, NULL , NULL, N'LIMITED' ) DMV ON DMV.[object_id] = I.[object_id]
				AND DMV.[index_id] = I.[index_id]
				AND DMV.[partition_number]  = P.[partition_number]
	
	WHERE		OBJECTPROPERTY ( P.[object_id], 'ISMSShipped') = 0
	
	ORDER BY	  S.[name]
				, T.[name]
				, P.[partition_number]
				, I.[index_id];
END