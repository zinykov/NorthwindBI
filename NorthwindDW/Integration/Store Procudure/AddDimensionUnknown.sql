CREATE PROC [Integration].[AddDimensionUnknown] AS
BEGIN
    INSERT INTO [Dimension].[Customer] (
          [CustomerKey]
        , [CustomerAlterKey]
        , [Customer]
        , [ContactName]
        , [ContactTitle]
        , [Country]
        , [City]
        , [Phone]
        , [Fax]
        , [StartDate]
        , [EndDate]
        , [Current]
    ) VALUES (
          -1
        , 'N/A'
        , 'N/A'
        , NULL
        , NULL
        , NULL
        , NULL
        , NULL
        , NULL
        , DATEFROMPARTS ( 1996, 01, 01 )
        , NULL
        , NULL
    )

    INSERT [Dimension].[Date] (
			  [DateKey]
		    , [AlterDateKey]
		    , [Year]
		    , [YearQuarterNumber]
		    , [YearQuarter]
		    , [Quarter]
		    , [YearMonth]
		    , [YearMonthNumber]
		    , [Month]
		    , [MonthNumber]
		    , [DayOfWeekNumber]
		    , [DayOfWeek]
	) SELECT	  [DateKey]
				, [AlterDateKey]
				, [Year]
				, [YearQuarterNumber]
				, [YearQuarter]
				, [Quarter]
				, [YearMonth]
				, [YearMonthNumber]
				, [Month]
				, [MonthNumber]
				, [DayOfWeekNumber]
				, [DayOfWeek]
	FROM		[Integration].[GenerateDateDimensionColumns] ( DATEFROMPARTS ( 3999, 12, 31 ) )

    INSERT INTO [Dimension].[Employee] (
          [EmployeeKey]
        , [EmployeeAlterKey]
        , [Name]
        , [Title]
        , [TitleOfCourtesy]
        , [City]
        , [Country]
        , [StartDate]
        , [EndDate]
        , [Current]
    ) VALUES (
          -1
        , -1
        , 'N/A'
        , NULL
        , NULL
        , NULL
        , NULL
        , DATEFROMPARTS ( 1996, 01, 01 )
        , NULL
        , NULL
    )

    INSERT INTO [Dimension].[Product] (
          [ProductKey]
        , [ProductAlterKey]
        , [Product]
        , [Category]
        , [StartDate]
        , [EndDate]
        , [Current]
    ) VALUES (
          -1
        , -1
        , 'N/A'
        , 'N/A'
        , DATEFROMPARTS ( 1996, 01, 01 )
        , NULL
        , NULL
    )
END