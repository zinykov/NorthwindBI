CREATE PROCEDURE [Reports].[LoadDuration]
AS BEGIN
	SELECT		  [Date]		= CONVERT ( date, [CutoffTime], 102 )
				, [ExecutionId]
				, [DataLoadStarted]
				, [TableName]
				, [Duration]	= DATEDIFF ( MILLISECOND, [DataLoadStarted], [DataLoadCompleted] )

	FROM		[Integration].[Lineage]

	ORDER BY	[LineageKey] DESC
END