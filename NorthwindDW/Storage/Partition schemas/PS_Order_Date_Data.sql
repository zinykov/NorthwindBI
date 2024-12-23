CREATE PARTITION SCHEME [PS_Order_Date_Data]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Order_Unknown_member_Data]
		, [Order_Unknown_member_Data]
		, [Order_1996_Data]
		, [Order_1997_Data]
	)
GO