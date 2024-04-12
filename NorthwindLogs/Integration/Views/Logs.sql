CREATE VIEW [Integration].[Logs] AS
	SELECT		  EL.[ErrorCode]
				, EL.[ErrorDescription]
				, EL.[FailedConfigurations]
				, EL.[ParametersValues]
				, SL.[event]
				, SL.[source]
				, SL.[starttime]
				, SL.[endtime]
				, SL.[datacode]
				, SL.[message]
				, LA.[LineageKey]
				, LA.[TableName]
				, LA.[DataLoadStarted]
				, LA.[DataLoadCompleted]
				, LA.[WasSuccessful]
				, LA.[CutoffTime]
	FROM		[Integration].[Lineage] AS LA
	LEFT JOIN	[Integration].[ErrorLog] AS EL ON LA.[executionid] = EL.[executionid]
	LEFT JOIN	[dbo].[sysssislog] AS SL ON LA.[executionid] = CAST ( SL.[executionid] AS NVARCHAR(50) )
				AND EL.[sourceid] = CAST ( SL.[sourceid] AS NVARCHAR(50) );