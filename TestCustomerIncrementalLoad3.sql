DELETE FROM [Landing].[Customers]
WHERE [CustomerID] <> 'ANTON';

UPDATE [Landing].[Customers] SET [country] = 'Russia'