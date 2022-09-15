CREATE PROCEDURE [Reports].[SSISlog]
	@period AS INT = 1
AS
	BEGIN
		DECLARE @starttime AS DATETIME = DATEADD ( DAY, -1 * @period, GETDATE () )

		SELECT		  [event]
					, [source]
					, [executionid]
					, [starttime]
					, [endtime]
					, [datacode]
					, [message]
	
		FROM		[dbo].[sysssislog]

		WHERE		[starttime] >= @starttime
					AND [event] <> N'DiagnosticEx'
	END