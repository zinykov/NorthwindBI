DELETE FROM [Landing].[Customers]
WHERE [CustomerID] <> 'ANTON';

UPDATE [Landing].[Customers] SET [fax] = '+1 555 12-34-56', [City] = 'Moscow'