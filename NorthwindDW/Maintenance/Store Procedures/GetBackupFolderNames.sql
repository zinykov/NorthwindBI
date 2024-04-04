CREATE PROCEDURE [Maintenance].[GetBackupFolderNames]
	  @CutoffTime AS DATE
	, @RetrainWeeks AS TINYINT
	, @BackupFolderName AS NVARCHAR(10) OUTPUT
	, @BackupOldFolderName AS NVARCHAR(10) OUTPUT
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
			DECLARE @date AS DATE;
	
			IF ( ( SELECT [DayOfWeekNumber] FROM [Dimension].[Date] WHERE [DateKey] = @CutoffTime ) < 6 )
				BEGIN
					SET @date = (
						SELECT		DATEADD ( DAY, -2, [StartOfWeek] )
						FROM		[Dimension].[Date]
						WHERE		[DateKey] = @CutoffTime
					)
				END
			ELSE
				BEGIN
				SET @date = (
						SELECT		DATEADD ( DAY, -1, [EndOfWeek] )
						FROM		[Dimension].[Date]
						WHERE		[DateKey] = @CutoffTime
					)
				END
	
			SET @BackupOldFolderName = FORMAT ( DATEADD ( DAY, @RetrainWeeks * -7, @date ), 'yyyy-MM-dd' )
			SET @BackupFolderName = FORMAT ( @date, 'yyyy-MM-dd' );
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END