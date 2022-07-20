CREATE PROCEDURE [Reports].[ssislog]
	@period AS INT = 1
AS
	BEGIN
		DECLARE @starttime AS DATETIME = DATEADD ( DAY, -1 * @period, GETDATE () )

		SELECT		  [event]
					, [operator]
					, [source]
					, [executionid]
					, [starttime]
					, [endtime]
					, [datacode]
					, [message]
	
		FROM		[dbo].[sysssislog]

		WHERE		[starttime] >= @starttime
	END