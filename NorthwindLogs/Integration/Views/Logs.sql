CREATE VIEW [Integration].[Logs] AS
	SELECT		  SL.[Id]
				, SL.[computer]
				, SL.[operator]
				, EL.[PackageName]
				, SL.[event]
				, SL.[source]
				, EL.[StartTime] AS [ErrorStartTime]
				, SL.[starttime]
				, SL.[endtime]
				, SL.[datacode]
				, SL.[databytes]
				, SL.[message]
				, EL.[LogKey]
				, EL.[ParametersValues]
				, EL.[FailedConfigurations]
				, LA.[LineageKey]
				, LA.[DataLoadStarted]
				, LA.[TableName]
				, LA.[DataLoadCompleted]
				, LA.[WasSuccessful]
				, LA.[CutoffTime]
	FROM		[dbo].[sysssislog] AS SL
	LEFT JOIN	[Integration].[Lineage] AS LA ON LA.[executionid] = CONCAT ( N'{', CAST ( SL.[executionid] AS NVARCHAR(50) ), N'}' )
	LEFT JOIN	[Integration].[ErrorLog] AS EL ON EL.[executionid] = CONCAT ( N'{', CAST ( SL.[executionid] AS NVARCHAR(50) ), N'}' )
				AND EL.[sourceid] = CONCAT ( N'{', CAST ( SL.[sourceid] AS NVARCHAR(50) ), N'}' );
GO