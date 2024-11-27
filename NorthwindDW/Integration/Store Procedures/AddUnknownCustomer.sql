CREATE PROCEDURE [Integration].[AddUnknownCustomer]
      @StartDate AS DATE
    , @LineageKey AS BIGINT
AS BEGIN
    IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Customer] WHERE [CustomerKey] = -1 )
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
        , 'N/A'
        , 'N/A'
        , 'N/A'
        , NULL
        , NULL
        , NULL
        , NULL
        , NULL
        , N'{}'
        , @StartDate
        , NULL
        , 1
        , @LineageKey
    );
END