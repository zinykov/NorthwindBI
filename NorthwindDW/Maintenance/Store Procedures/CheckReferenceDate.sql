CREATE PROCEDURE [Maintenance].[CheckReferenceDate]
        @CutoffTime AS DATE
      , @IsMonthlyOptimization AS BIT
      , @IsStartOptimization AS BIT OUTPUT
      , @IsSetFilegroupReadonly AS BIT OUTPUT
AS BEGIN
	DECLARE @ReferenceDate AS DATE;
    DECLARE @MonthNumber AS TINYINT;

    IF ( @IsMonthlyOptimization = 1 )
        BEGIN
            SET @MonthNumber = CAST ( MONTH ( @CutoffTime ) AS TINYINT )
        END
    ELSE
        BEGIN
            SET @MonthNumber = CAST ( 1 AS TINYINT )
        END
	
    SET @ReferenceDate = (
        SELECT	[DateKey]
        FROM	[Dimension].[Date]
        WHERE	[DayOfWeekNumber] = 5
			    AND [DayOfMonth] BETWEEN 2 AND 8
			    AND [MonthNumber] = @MonthNumber
                AND [Year] = YEAR ( @CutoffTime )
    )
    
    IF @CutoffTime = @ReferenceDate AND @CutoffTime <> DATEFROMPARTS ( 1997, 1, 3 ) --<> DATEFROMPARTS ( 1998, 1, 2 )
        BEGIN
            SET @IsStartOptimization = 1
        END
    ELSE
        BEGIN
            SET @IsStartOptimization = 0
        END
	
    SET @ReferenceDate = (
        SELECT	[DateKey]
        FROM	[Dimension].[Date]
        WHERE	[DayOfWeekNumber] = 6
			    AND [DayOfMonth] BETWEEN 2 AND 8
			    AND [MonthNumber] = CAST ( 1 AS TINYINT )
                AND [Year] = YEAR ( @CutoffTime )
    )
    
    IF @CutoffTime = @ReferenceDate AND @CutoffTime <> DATEFROMPARTS ( 1997, 1, 4 )
        BEGIN
            SET @IsSetFilegroupReadonly = 1
        END
    ELSE
        BEGIN
            SET @IsSetFilegroupReadonly = 0
        END
    RETURN 0;
END
