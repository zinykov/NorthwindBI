CREATE PARTITION SCHEME [PS_Order_Date_Index]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Archive_Fact]		--1
		, [Archive_Fact]		--2
		, [Archive_Fact]		--3
		, [Fast_Fact_Index]		--4
		, [Fast_Fact_Index]		--5
		, [Fast_Fact_Index]		--6
	)
GO