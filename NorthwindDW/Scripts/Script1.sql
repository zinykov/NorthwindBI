﻿SELECT		  [Shema]		=	S.[name]
			, [Table]		=	T.[name]
			, P.[partition_number]
			, P.[rows]

FROM		[sys].[tables] AS T
INNER JOIN	[sys].[schemas] AS S ON S.[schema_id] = T.[schema_id]
INNER JOIN	[sys].[partitions] AS P ON T.[object_id] = P.[object_id]

WHERE		T.[name] = 'Order'
			AND P.index_id = 1

ORDER BY	  S.[name] ASC
			, T.[name] ASC
			, P.[partition_number] ASC
---------------------------------------------------------------------------
	--DECLARE @Partition_number int

	--SET @Partition_number = (
	--	SELECT		TOP (1) partition_number
	--	FROM		sys.partitions
	--	WHERE		object_id = OBJECT_ID ( N'Зинуков Денис Витальевич.Fact.Order' )
	--	ORDER BY	partition_number DESC
	--)

	--ALTER TABLE [Staging].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
---------------------------------------------------------------------------------------------
SELECT		  [Shema]		=	S.[name]
			, [Table]		=	T.[name]
			, P.[partition_number]
			, P.[rows]

FROM		[sys].[tables] AS T
INNER JOIN	[sys].[schemas] AS S ON S.[schema_id] = T.[schema_id]
INNER JOIN	[sys].[partitions] AS P ON T.[object_id] = P.[object_id]

WHERE		T.[name] = 'Order'
			AND P.index_id = 1

ORDER BY	  S.[name] ASC
			, T.[name] ASC
			, P.[partition_number] ASC