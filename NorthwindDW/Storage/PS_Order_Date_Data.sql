CREATE PARTITION SCHEME [PS_Order_Date_Data]
	AS PARTITION [PF_Order_Date]
	TO (
		  [Archive_Fact]		--1
		, [Archive_Fact]		--2
		, [Archive_Fact]		--3
		, [Fast_Fact_Data]		--4
		, [Fast_Fact_Data]		--5
		, [Fast_Fact_Data]		--6
	)
GO