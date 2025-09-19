CREATE PROCEDURE [Reports].[GetLoadDuration]
AS BEGIN
    SELECT		  [Date]		= CONVERT ( date, L.[CutoffTime], 102 )
				, [ExecutionId]
				, [DataLoadStarted]
				, [TableName]
				, [Duration]	= DATEDIFF ( MILLISECOND, L.[DataLoadStarted], L.[DataLoadCompleted] )
				, [MAvgDuration] = AVG ( DATEDIFF ( MILLISECOND, L.[DataLoadStarted], L.[DataLoadCompleted] ) ) OVER ( PARTITION BY [TableName] ORDER BY L.[CutoffTime] DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING )
	FROM		[Integration].[Lineage] AS L
    ORDER BY	L.[LineageKey] DESC
END