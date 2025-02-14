CREATE PROCEDURE [Integration].[AddUnknownCustomer]
      @CustomerAlterKey AS NVARCHAR(5)
    , @Customer AS NVARCHAR(50)
    , @AllAttributes AS NVARCHAR(MAX)
    , @StartDate AS DATE
    , @LineageKey AS BIGINT
AS BEGIN
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
        , [AllAttributes]
        , [StartDate]
        , [EndDate]
        , [Current]
        , [LineageKey]
    ) VALUES (
          -1
        , @CustomerAlterKey
        , @Customer
        , NULL
        , NULL
        , NULL
        , NULL
        , NULL
        , NULL
        , @AllAttributes
        , @StartDate
        , NULL
        , 1
        , @LineageKey
    );
END