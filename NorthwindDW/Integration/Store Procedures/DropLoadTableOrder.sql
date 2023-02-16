CREATE PROCEDURE [Integration].[DropLoadTableOrder]
AS BEGIN
	DROP TABLE [Integration].[Order];
	DROP PARTITION SCHEME [PS_Integration_Data];
	DROP PARTITION SCHEME [PS_Integration_Index];
	DROP PARTITION FUNCTION [PF_Integration];

	RETURN 0;
END