CREATE PROCEDURE [Reports].[DQSStatus]
AS BEGIN
	SELECT		  [Table]			= 'Customer'
				, [Record_Status]
				, [RowCount]		= COUNT ( * )

	FROM		[$(DQSServerName)].[$(DQSDatabaseName)].[dbo].[NW_Customer]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Employee'
				, [Record_Status]
				, [RowCount]		= COUNT ( * )

	FROM		[$(DQSServerName)].[$(DQSDatabaseName)].[dbo].[NW_Employee]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Product'
				, [Record_Status]
				, [RowCount]		= COUNT ( * )

	FROM		[$(DQSServerName)].[$(DQSDatabaseName)].[dbo].[NW_Product]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Category'
				, [Record_Status]
				, [RowCount]		= COUNT ( * )

	FROM		[$(DQSServerName)].[$(DQSDatabaseName)].[dbo].[NW_Category]

	GROUP BY	[Record_Status]
	
	UNION ALL

	SELECT		  [Table]			= 'Holidays'
				, [Record_Status]
				, [RowCount]		= COUNT ( * )

	FROM		[$(DQSServerName)].[$(DQSDatabaseName)].[dbo].[Holidays]

	GROUP BY	[Record_Status]
END