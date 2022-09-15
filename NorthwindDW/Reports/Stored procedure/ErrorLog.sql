CREATE PROCEDURE [dbo].[ErrorLog] AS
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