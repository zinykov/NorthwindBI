CREATE PROCEDURE [Maintenance].[CheckReferenceDate]
        @CutoffTime AS DATE
      , @IsMonthlyOptimization AS BIT
      , @IsStartOptimization AS BIT OUTPUT
AS BEGIN
	DECLARE @ReferenceDate AS DATE;
    DECLARE @MonthNumber AS TINYINT;
    DECLARE @DayOfWeekNumber AS TINYINT;

    IF ( @IsMonthlyOptimization = 1 )
        BEGIN
            SET @MonthNumber = CAST ( MONTH ( @CutoffTime ) AS TINYINT )
            SET @DayOfWeekNumber = 6
        END
    ELSE
        BEGIN
            SET @MonthNumber = CAST ( 1 AS TINYINT )
            SET @DayOfWeekNumber = 7
        END
	
    SET @ReferenceDate = (
        SELECT	[AlterDateKey]
        FROM	[Dimension].[Date]
        WHERE	[DayOfWeekNumber] = @DayOfWeekNumber
			    AND [DayOfMonth] BETWEEN 2 AND 8
			    AND [MonthNumber] = @MonthNumber
                AND [Year] = YEAR ( @CutoffTime )
    )
    
    IF @CutoffTime = @ReferenceDate AND @CutoffTime <> DATEFROMPARTS ( 1997, 1, 4 )
        BEGIN
            SET @IsStartOptimization = 1
            RETURN 0;
        END
    ELSE
        BEGIN
            SET @IsStartOptimization = 0
            RETURN 0;
        END
END
