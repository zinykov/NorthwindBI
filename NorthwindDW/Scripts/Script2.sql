WITH		[FACTv] AS (
				SELECT		  [Shema]		=	S.[name]
							, [Table]		=	T.[name]
							, P.[partition_number]
							, P.[rows]
							--, RV.[value]
							, P.[data_compression_desc]

				FROM		[sys].[tables] AS T
				INNER JOIN	[sys].[schemas] AS S ON S.[schema_id] = T.[schema_id]
				INNER JOIN	[sys].[partitions] AS P ON T.[object_id] = P.[object_id]
				--INNER JOIN	[sys].[partition_range_values] AS RV ON S.[schema_id] = RV.[schema_id]

				WHERE		T.[name] = 'Order'
							AND S.[name] = 'Fact'
							AND P.index_id = 1
			)
			, [STAGINGv] AS (
				SELECT		  [Shema]		=	S.[name]
							, [Table]		=	T.[name]
							, P.[partition_number]
							, P.[rows]
							--, RV.[value]
							, P.[data_compression_desc]

				FROM		[sys].[tables] AS T
				INNER JOIN	[sys].[schemas] AS S ON S.[schema_id] = T.[schema_id]
				INNER JOIN	[sys].[partitions] AS P ON T.[object_id] = P.[object_id]
				--INNER JOIN	[sys].[partition_range_values] AS RV ON S.[schema_id] = RV.[schema_id]

				WHERE		T.[name] = 'Order'
							AND S.[name] = 'Staging'
							AND P.index_id = 1
			)

SELECT		  F.*
			, S.*

FROM		[FactV] AS F
INNER JOIN	[StagingV] AS S ON F.[partition_number] = S.[partition_number]

ORDER BY	  F.[Shema] ASC
			, F.[Table] ASC
			, F.[partition_number] ASC

SELECT		*
FROM		[sys].[partition_range_values]