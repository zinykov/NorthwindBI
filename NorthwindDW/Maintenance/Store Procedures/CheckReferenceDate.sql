CREATE PROCEDURE [Maintenance].[CheckReferenceDate]
      @CutoffTime AS DATE
    , @IsMonthlyOptimization AS BIT
    , @IsStartOptimization AS BIT OUTPUT
    , @IsSetFilegroupReadonly AS BIT OUTPUT
    , @LoadDateInitialEnd AS DATE
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
	        DECLARE @ReferenceDate AS DATE;
            DECLARE @MonthNumber AS TINYINT;
            DECLARE @IsMissingStartOptimization AS BIT = 0;

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

            IF (
                    YEAR ( @LoadDateInitialEnd ) = 1996 AND @CutoffTime = DATEFROMPARTS ( 1997, 1, 3 )
                    OR YEAR ( @LoadDateInitialEnd ) = 1997 AND @CutoffTime = DATEFROMPARTS ( 1998, 1, 2 )
               )
                BEGIN
                    SET @IsMissingStartOptimization = 1
                END
    
            IF @CutoffTime = @ReferenceDate AND @IsMissingStartOptimization = 0
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
                END;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END
