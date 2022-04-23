--SELECT		*
--FROM		[sys].[partitions]

--SELECT		*
--FROM		[sys].[partition_schemes]

--SELECT		*
--FROM		[sys].[partition_functions]

--SELECT		*
--FROM		[sys].[partition_parameters]

SELECT		*
FROM		[sys].[partition_range_values]

--SELECT		*
--FROM		[sys].[filegroups]

--SELECT		*
--FROM		[sys].[data_spaces]

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
			--AND S.[name] = 'Fact'
			AND P.index_id = 1

ORDER BY	  S.[name] ASC
			, T.[name] ASC
			, P.[partition_number] ASC