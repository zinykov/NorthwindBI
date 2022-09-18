CREATE PROCEDURE [Reports].[ErrorLog] AS
BEGIN
	SELECT		  [LogKey]
				, [ErrorCode]
				, [ErrorDescription]
				, [MachineName]
				, [PackageName]
				, [SourceName]
				, [StartTime]
				, [UserName]
				, [LineageKey]

	FROM		[Integration].[ErrorLog]
END