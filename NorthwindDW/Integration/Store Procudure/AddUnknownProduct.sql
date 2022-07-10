CREATE PROCEDURE [Integration].[AddUnknownProduct] AS
BEGIN
    IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Product] WHERE [ProductKey] = -1 )
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