CREATE PROCEDURE [Integration].[AddUnknownDate]
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Date] WHERE [DateKey] = DATEFROMPARTS ( 1995, 12, 31 ) )
            INSERT [Dimension].[Date] (
		          [DateKey]
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
		        FROM	[Integration].[GenerateDateDimensionColumns] ( DATEFROMPARTS ( 1995, 12, 31 ) );
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END