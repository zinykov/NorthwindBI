UPDATE	[Landing].[Customers]
SET		  [ContactTitle] = N'CEO'
		, [City] = N'MIT'

DELETE FROM [Landing].[Customers]
WHERE [CustomerID] <> N'ANTON'

EXECUTE [Integration].[ExtractCustomerFromLanding]

select * from [Integration].[Lineage]

--UPDATE [Landing].[Customers]
--SET		[City] = N'Moscow'