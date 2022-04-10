CREATE PROCEDURE [Integration].[IncrementalOrdersLoad] AS
BEGIN
	DECLARE @Partition_number int

	SET @Partition_number = (
		SELECT		TOP (1) partition_number
		FROM		sys.partitions
		WHERE		object_id = OBJECT_ID ( N'Зинуков Денис Витальевич.Fact.Order' )
		ORDER BY	partition_number DESC
	)

	ALTER TABLE [Staging].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
END
