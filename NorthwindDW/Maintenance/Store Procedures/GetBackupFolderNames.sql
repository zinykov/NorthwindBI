CREATE PROCEDURE [Maintenance].[GetBackupFolderNames]
	  @CutoffTime AS DATE
	, @RetrainWeeks AS TINYINT
	, @BackupFolderName AS NVARCHAR(10) OUTPUT
	, @BackupOldFolderName AS NVARCHAR(10) OUTPUT
AS BEGIN
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
END