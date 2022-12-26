CREATE PROCEDURE [Reports].[LoadDuration]
	WITH EXECUTE AS OWNER
AS BEGIN
	SELECT		  TOP ( 7 ) [Date]		= CONVERT ( date, DataLoadStarted, 102 )
				, [ExecutionId]
				, [DataLoadStarted]
				, [TableName]
				, [Duration]	= DATEDIFF ( MILLISECOND, [DataLoadStarted], [DataLoadCompleted] )

	FROM		[Integration].[Lineage]

	ORDER BY	[LineageKey] DESC
END