﻿CREATE PROCEDURE [Reports].[ErrorLog]
	WITH EXECUTE AS OWNER
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