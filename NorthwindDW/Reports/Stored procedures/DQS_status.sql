CREATE PROCEDURE [Reports].[DQS_status] AS
BEGIN
	SELECT		  [Table]			= 'Customer'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[$(DQS_Staging_ServerName)].[$(DQS_Staging_DatabaseName)].[dbo].[NW_Customer]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Employee'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[$(DQS_Staging_ServerName)].[$(DQS_Staging_DatabaseName)].[dbo].[NW_Employee]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Product'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[$(DQS_Staging_ServerName)].[$(DQS_Staging_DatabaseName)].[dbo].[NW_Product]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Category'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[$(DQS_Staging_ServerName)].[$(DQS_Staging_DatabaseName)].[dbo].[NW_Category]

	GROUP BY	[Record_Status]
	
	UNION ALL

	SELECT		  [Table]			= 'Holidays'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[$(DQS_Staging_ServerName)].[$(DQS_Staging_DatabaseName)].[dbo].[Holidays]

	GROUP BY	[Record_Status]
END