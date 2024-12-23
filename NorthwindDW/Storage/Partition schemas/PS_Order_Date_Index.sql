CREATE PARTITION SCHEME [PS_Order_Date_Index]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Order_Unknown_member_Index]
		, [Order_Unknown_member_Index]
		, [Order_1996_Index]
		, [Order_1997_Index]
	)
GO