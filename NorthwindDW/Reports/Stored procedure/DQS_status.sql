CREATE PROCEDURE [Reports].[DQS_status] AS
BEGIN
	SELECT		  [Table]			= 'Customer'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[DQS_STAGING_DATA].[dbo].[Customer]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Employee'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[DQS_STAGING_DATA].[dbo].[Employee]

	GROUP BY	[Record_Status]

	UNION ALL

	SELECT		  [Table]			= 'Product'
				, [Record_Status]
				, [Row Count]		= COUNT ( * )

	FROM		[DQS_STAGING_DATA].[dbo].[Product]

	GROUP BY	[Record_Status]
END