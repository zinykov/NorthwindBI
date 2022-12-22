CREATE PARTITION SCHEME [PS_Order_Date_Index]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Order_1996_Index]		--1
		, [Order_1996_Index]		--2
	)
GO