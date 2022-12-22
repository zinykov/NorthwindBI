CREATE PARTITION SCHEME [PS_Order_Date_Data]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Order_1996_Data]		--1
		, [Order_1996_Data]		--2
		, [Order_1997_Data]		--3
	)
GO