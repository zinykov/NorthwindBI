CREATE PROCEDURE [Maintenance].[MDS_CleanUpTransactions] AS
BEGIN
	DECLARE @Model_id				AS INT;
	DECLARE @CleanupOlderThanDate	AS DATE;

	SET @CleanupOlderThanDate = DATEADD ( DAY, -7, GETDATE () );

	DECLARE MDS_maintenance CURSOR FOR 
		SELECT Model_ID FROM [$(MDS_ServerName)].[$(MDS_DatabaseName)].[mdm].[viw_SYSTEM_SCHEMA_VERSION] WHERE [Flag] = N'SSIS';

	OPEN MDS_maintenance

	FETCH NEXT FROM MDS_maintenance INTO @Model_id

		WHILE @@FETCH_STATUS = 0
			BEGIN
				EXECUTE [$(MDS_ServerName)].[$(MDS_DatabaseName)].[mdm].[udpTransactionsCleanup]
					  @Model_ID = @Model_ID
					, @CleanupOlderThanDate = @CleanupOlderThanDate

				FETCH NEXT FROM MDS_maintenance INTO @Model_id
			END

	CLOSE MDS_maintenance
	DEALLOCATE MDS_maintenance
END;