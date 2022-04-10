SELECT		  S.[name]
			, T.[name]
			, P.[rows]

FROM		[sys].[tables] AS T
INNER JOIN	[sys].[schemas] AS S ON S.[schema_id] = T.[schema_id]
INNER JOIN	[sys].[partitions] AS P ON T.[object_id] = P.[object_id]

WHERE		T.[name] = 'Order'
			AND P.index_id = 1
---------------------------------------------------------------------------
	DECLARE @Partition_number int

	SET @Partition_number = (
		SELECT		TOP (1) partition_number
		FROM		sys.partitions
		WHERE		object_id = OBJECT_ID ( N'Зинуков Денис Витальевич.Fact.Order' )
		ORDER BY	partition_number DESC
	)

	ALTER TABLE [Staging].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
---------------------------------------------------------------------------------------------
SELECT		  S.[name]
			, T.[name]
			, P.[rows]

FROM		[sys].[tables] AS T
INNER JOIN	[sys].[schemas] AS S ON S.[schema_id] = T.[schema_id]
INNER JOIN	[sys].[partitions] AS P ON T.[object_id] = P.[object_id]

WHERE		T.[name] = 'Order'
			AND P.index_id = 1