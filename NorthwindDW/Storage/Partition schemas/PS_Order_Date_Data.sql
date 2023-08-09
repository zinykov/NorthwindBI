CREATE PARTITION SCHEME [PS_Order_Date_Data]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Order_Unknown_member_Data]	--1
		, [Order_Unknown_member_Data]	--2
		, [Order_1996_Data]				--3
		, [Order_1997_Data]				--4
		--, [Order_1998_Data]				--5
	)
GO