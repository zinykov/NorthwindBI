CREATE PROCEDURE [Integration].[InsertErrorLog]
	  @ErrorCode INT
	, @ErrorDescription NVARCHAR(2048)
	, @ParametersValues NVARCHAR(2048)
	, @MachineName NVARCHAR(128)
	, @PackageName NVARCHAR(1024)
	, @SourceName NVARCHAR(1024)
	, @StartTime DATETIME2
	, @UserName NVARCHAR(128)
	, @SourceID NVARCHAR(100)
	, @ExecutionID NVARCHAR(100)
	, @FailedConfigurations NVARCHAR(128)
	, @LineageKey INT
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
			INSERT INTO [Integration].[ErrorLog] (
				  [ErrorCode]
				, [ErrorDescription]
				, [ParametersValues]
				, [MachineName]
				, [PackageName]
				, [SourceName]
				, [StartTime]
				, [UserName]
				, [sourceid]
				, [executionid]
				, [FailedConfigurations]
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
				, CAST ( @SourceID AS UNIQUEIDENTIFIER )
				, CAST ( @ExecutionID AS UNIQUEIDENTIFIER )
				, @FailedConfigurations
				, @LineageKey
			);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END
