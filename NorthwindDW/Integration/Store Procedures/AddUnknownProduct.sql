CREATE PROCEDURE [Integration].[AddUnknownProduct]
    @LineageKey AS INT
AS BEGIN
    IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Product] WHERE [ProductKey] = -1 )
    INSERT INTO [Dimension].[Product] (
          [ProductKey]
        , [ProductAlterKey]
        , [Product]
        , [Category]
        , [LineageKey]
    ) VALUES (
          -1
        , -1
        , 'N/A'
        , 'N/A'
        , @LineageKey
    )
END