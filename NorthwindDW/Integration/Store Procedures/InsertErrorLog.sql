CREATE PROCEDURE [Integration].[InsertErrorLog]
	  @ErrorCode INT
	, @ErrorDescription NVARCHAR(2048)
	, @ParametersValues NVARCHAR(2048)
	, @MachineName NVARCHAR(128)
	, @PackageName NVARCHAR(1024)
	, @SourceName NVARCHAR(1024)
	, @StartTime DATETIME2
	, @UserName NVARCHAR(128)
	, @LineageKey INT
AS BEGIN
	INSERT INTO [Integration].[ErrorLog] (
		  [ErrorCode]
		, [ErrorDescription]
		, [ParametersValues]
		, [MachineName]
		, [PackageName]
		, [SourceName]
		, [StartTime]
		, [UserName]
		, [LineageKey]
	) VALUES (
		  @ErrorCode
		, @ErrorDescription
		, @ParametersValues
		, @MachineName
		, @PackageName
		, @SourceName
		, @StartTime
		, @UserName
		, @LineageKey
	)
END
