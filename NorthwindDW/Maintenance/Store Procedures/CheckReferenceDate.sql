CREATE PROCEDURE [Maintenance].[CheckReferenceDate]
        @CutoffTime AS DATE
      , @IsYearOptimisationWorked AS BIT = 0 OUTPUT
AS BEGIN
	DECLARE @ReferenceDate AS DATE;
	
    SET @ReferenceDate = (
        SELECT	[AlterDateKey]
        FROM	[Dimension].[Date]
        WHERE	[DayOfWeekNumber] = 6
			    AND [DayOfMonth] BETWEEN 2 AND 8
			    AND [MonthNumber] = 1
                AND [Year] = YEAR ( @CutoffTime )
    )
    
    IF @CutoffTime <> @ReferenceDate OR @CutoffTime = DATEFROMPARTS ( 1997, 1, 4 )
    BEGIN
        SET @IsYearOptimisationWorked = 1
    END
END
