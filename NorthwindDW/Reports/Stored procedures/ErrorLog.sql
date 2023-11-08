CREATE PROCEDURE [Reports].[ErrorLog]
AS BEGIN
	SELECT		  [LogKey]
				, [ErrorCode]
				, [ErrorDescription]
				, [ParametersValues]
				, [MachineName]
				, [PackageName]
				, [SourceName]
				, [StartTime]
				, [UserName]
				, [LineageKey]

	FROM		[Integration].[ErrorLog]
END