CREATE PROCEDURE [Integration].[AddUnknownProduct]
      @StartDate AS DATE
    , @LineageKey AS BIGINT
AS BEGIN
    IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Product] WHERE [ProductKey] = -1 )
    INSERT INTO [Dimension].[Product] (
          [ProductKey]
        , [ProductAlterKey]
        , [Product]
        , [Category]
        , [AllAttributes]
        , [LineageKey]
    ) VALUES (
          -1
        , -1
        , N'N/A'
        , N'N/A'
        , N'{}'
        , @LineageKey
    )
END