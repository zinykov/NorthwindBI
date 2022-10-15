CREATE PROCEDURE [Integration].[LoadDateDimension]
	  @StartDate INT
	, @EndDate INT
AS
BEGIN
	SET NOCOUNT ON;
    SET XACT_ABORT ON;
	
	DECLARE @DateCounter DATE	=	DATEFROMPARTS (  @StartDate, 1, 1 )

	BEGIN TRY
		BEGIN TRAN
			WHILE @DateCounter <= DATEFROMPARTS ( @EndDate, 12, 31 )
			BEGIN
				IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Date] WHERE [AlterDateKey] = @DateCounter )
				BEGIN
					INSERT [Dimension].[Date] (
						  [DateKey]
						, [AlterDateKey]
						, [Year]
						, [YearQuarterNumber]
						, [YearQuarter]
						, [Quarter]
						, [YearMonth]
						, [YearMonthNumber]
						, [Month]
						, [MonthNumber]
						, [DayOfMonth]
						, [DayOfWeekNumber]
						, [DayOfWeek]
						, [WeekNumber]
					) SELECT	  [DateKey]
								, [AlterDateKey]
								, [Year]
								, [YearQuarterNumber]
								, [YearQuarter]
								, [Quarter]
								, [YearMonth]
								, [YearMonthNumber]
								, [Month]
								, [MonthNumber]
								, [DayOfMonth]
								, [DayOfWeekNumber]
								, [DayOfWeek]
								, [WeekNumber]
					  FROM		[Integration].[GenerateDateDimensionColumns] ( @DateCounter )
				END
				SET @DateCounter = DATEADD ( DAY, 1, @DateCounter )
			END
		COMMIT
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0 ROLLBACK;
        PRINT N'Unable to populate dates for the year';
        THROW;
        RETURN -1;
	END CATCH;
END;