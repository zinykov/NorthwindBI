CREATE PROCEDURE [Integration].[LoadDateDimension]
	  @StartDate INT
	, @EndDate INT
AS
BEGIN
	SET NOCOUNT ON;
    SET XACT_ABORT ON;
    SET DATEFIRST 1;
    	
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
                        , [DayOfMonth]
                        , [DayOfWeek]
                        , [DayOfWeekNumber]
                        , [DayOfQuarterNumber]
                        , [DayOfYearNumber]
                        , [Year]
                        , [StartOfYear]
                        , [EndOfYear]
                        , [Quarter]
                        , [YearQuarter]
                        , [YearQuarterNumber]
                        , [StartOfQuarter]
                        , [EndOfQuarter]
                        , [Month]
                        , [Mon]
                        , [MonthNumber]
                        , [YearMonth]
                        , [StartOfMonth]
                        , [EndOfMonth]
                        , [Week]
                        , [IOSWeekNumber]
                        , [StartOfWeek]
                        , [EndOfWeek]
                        , [Holiday]
                        , [WorkDayType]
                        , [WorkDayHours]
					) SELECT	  [DateKey]
                                , [AlterDateKey]
                                , [DayOfMonth]
                                , [DayOfWeek]
                                , [DayOfWeekNumber]
                                , [DayOfQuarterNumber]
                                , [DayOfYearNumber]
                                , [Year]
                                , [StartOfYear]
                                , [EndOfYear]
                                , [Quarter]
                                , [YearQuarter]
                                , [YearQuarterNumber]
                                , [StartOfQuarter]
                                , [EndOfQuarter]
                                , [Month]
                                , [Mon]
                                , [MonthNumber]
                                , [YearMonth]
                                , [StartOfMonth]
                                , [EndOfMonth]
                                , [Week]
                                , [IOSWeekNumber]
                                , [StartOfWeek]
                                , [EndOfWeek]
                                , [Holiday]
                                , [WorkDayType]
                                , [WorkDayHours]
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