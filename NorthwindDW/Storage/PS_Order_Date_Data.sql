CREATE PARTITION SCHEME [PS_Order_Date_Data]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Archive_Fact]		--0
		, [Archive_Fact]		--1
		, [Archive_Fact]		--2
		, [Fast_Fact_Index]		--3
		, [Fast_Fact_Index]		--4
		, [Fast_Fact_Index]		--5
		, [Fast_Fact_Index]		--6
		, [Fast_Fact_Index]		--7
		, [Fast_Fact_Index]		--8
	)
GO