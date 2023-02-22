CREATE PROCEDURE [Integration].[DropLoadTableOrder]
AS BEGIN
	DROP TABLE [Integration].[Order];
	DROP PARTITION SCHEME [PS_Load_Order_Data];
	DROP PARTITION SCHEME [PS_Load_Order_Index];
	DROP PARTITION FUNCTION [PF_Load_Order];

	RETURN 0;
END