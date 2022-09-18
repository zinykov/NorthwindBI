CREATE PROCEDURE [Reports].[LoadDuration] AS
BEGIN
	SELECT	  [Date]		= CONVERT ( date, DataLoadStarted, 102 )
			, [ExecutionId]
			, [DataLoadStarted]
			, [TableName]
			, [Duration]	= DATEDIFF ( MILLISECOND, [DataLoadStarted], [DataLoadCompleted] )

	FROM	[Integration].[Lineage]
END