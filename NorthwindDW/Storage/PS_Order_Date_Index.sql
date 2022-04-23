CREATE PARTITION SCHEME [PS_Order_Date_Index]
	AS PARTITION [PF_Order_Date]
	TO (
		  [ArchiveFact]		--0
		, [ArchiveFact]		--1
		, [ArchiveFact]		--2
		, [FastFactIndex]	--3
		, [FastFactIndex]	--4
		, [FastFactIndex]	--5
		, [FastFactIndex]	--6
		, [FastFactIndex]	--7
		, [FastFactIndex]	--8
	)
GO