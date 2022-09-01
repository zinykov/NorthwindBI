CREATE PROCEDURE [Reports].[CountRowsInDWH] AS
BEGIN
	SELECT		  S.[name]
				, T.[name]
				, I.[type_desc]
				, P.[rows]
	FROM		sys.tables AS T
	INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
	LEFT JOIN	sys.partitions AS P ON T.[object_id] = P.[object_id]
				AND P.[index_id] IN ( 1, 0 )
	LEFT JOIN	sys.indexes AS I ON T.[object_id] = I.[object_id]
				AND P.[index_id] = I.[index_id]
	ORDER BY	  S.[schema_id]
				, T.[name]
				, P.[partition_id]
END
