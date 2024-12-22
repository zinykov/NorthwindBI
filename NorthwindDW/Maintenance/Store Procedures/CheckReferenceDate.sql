CREATE PROCEDURE [Maintenance].[CheckReferenceDate]
      @CutoffTime AS DATE
    , @IsMonthlyOptimization AS BIT
    , @IsStartOptimization AS BIT OUTPUT
    , @IsSetFilegroupReadonly AS BIT OUTPUT
    , @LoadDateInitialEnd AS DATE
AS BEGIN
	DECLARE @ReferenceDate AS DATE;
    DECLARE @MonthNumber AS TINYINT;

    IF ( @IsMonthlyOptimization = 1 ) SET @MonthNumber = CAST ( MONTH ( @CutoffTime ) AS TINYINT )
    ELSE SET @MonthNumber = CAST ( 1 AS TINYINT )
	
    SET @ReferenceDate = (
        SELECT	[DateKey]
        FROM	[Dimension].[Date]
        WHERE	[DayOfWeekNumber] = 5
			    AND [DayOfMonth] BETWEEN 2 AND 8
			    AND [MonthNumber] = @MonthNumber
                AND [Year] = YEAR ( @CutoffTime )
    )

    IF @CutoffTime = @ReferenceDate SET @IsStartOptimization = 1
    ELSE SET @IsStartOptimization = 0
	
    SET @ReferenceDate = (
        SELECT	[DateKey]
        FROM	[Dimension].[Date]
        WHERE	[DayOfWeekNumber] = 6
			    AND [DayOfMonth] BETWEEN 2 AND 8
			    AND [MonthNumber] = CAST ( 1 AS TINYINT )
                AND [Year] = YEAR ( @CutoffTime )
    )
    
    IF @CutoffTime = @ReferenceDate SET @IsSetFilegroupReadonly = 1
    ELSE SET @IsSetFilegroupReadonly = 0;
END
