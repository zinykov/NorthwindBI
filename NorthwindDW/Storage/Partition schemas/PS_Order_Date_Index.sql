CREATE PARTITION SCHEME [PS_Order_Date_Index]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Order_Unknown_member_Index]	--1
		, [Order_Unknown_member_Index]	--2
		, [Order_1996_Index]			--3
		, [Order_1997_Index]			--4
		, [Order_1998_Index]			--5
	)
GO