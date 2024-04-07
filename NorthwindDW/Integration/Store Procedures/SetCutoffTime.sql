CREATE PROCEDURE [Integration].[SetCutoffTime]
	  @TestCutoffTime AS DATE
AS BEGIN
	IF ( @TestCutoffTime = DATEFROMPARTS ( 1899, 12, 31 ) )
		SELECT GETDATE() AS [CutoffTime]
	ELSE
		SELECT @TestCutoffTime AS [CutoffTime];
END