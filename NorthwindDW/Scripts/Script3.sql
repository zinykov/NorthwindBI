DECLARE		@NewPartitionParameter AS INT

SET			@NewPartitionParameter = (
				SELECT		MAX ( OrderDateKey ) + 1
				FROM		[Fact].[Order]
			)
GO

ALTER PARTITION FUNCTION [PF_Order_Date] ()
	SPLIT RANGE ( @NewPartitionParameter );
GO

ALTER PARTITION SCHEME [PS_Order_Date_Data]  
NEXT USED [FastFactData];
GO

ALTER PARTITION SCHEME [PS_Order_Date_Index]  
NEXT USED [FastFactIndex];
GO

-- Execute code to fill staging fact tables