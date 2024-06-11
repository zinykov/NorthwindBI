CREATE PROCEDURE [Landing].[ExtractOrders]
	  @StartLoad AS DATE
	, @EndLoad AS DATE
AS BEGIN
	IF DATEDIFF ( DAY, @StartLoad, @EndLoad ) = 1
		BEGIN
			SET @StartLoad = @EndLoad
		END

		SELECT	  *
		FROM	[Landing].[ChangedOrders]
		WHERE	[OrderDate] BETWEEN @StartLoad AND @EndLoad;
END