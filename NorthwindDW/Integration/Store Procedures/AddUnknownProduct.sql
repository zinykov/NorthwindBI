CREATE PROCEDURE [Integration].[AddUnknownProduct]
      @ProductAlterKey AS INT
    , @Product AS NVARCHAR(50)
    , @Category AS NVARCHAR(50)
    , @AllAttributes AS NVARCHAR(MAX)
    , @LineageKey AS BIGINT
AS BEGIN
    INSERT INTO [Dimension].[Product] (
          [ProductKey]
        , [ProductAlterKey]
        , [Product]
        , [Category]
        , [AllAttributes]
        , [LineageKey]
    ) VALUES (
          -1
        , @ProductAlterKey
        , @Product
        , @Category
        , @AllAttributes
        , @LineageKey
    )
END