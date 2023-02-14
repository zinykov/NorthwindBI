CREATE PROCEDURE [Reports].[MDS_status]
AS BEGIN
	SELECT		  [Table]			= 'Customer'
				, [ValidationStatus]
				, [Row Count]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterCustomer]

	GROUP BY	[ValidationStatus]

	UNION ALL
	
	SELECT		  [Table]			= 'Employee'
				, [ValidationStatus]
				, [Row Count]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterEmployee]

	GROUP BY	[ValidationStatus]

	UNION ALL
	
	SELECT		  [Table]			= 'Holidays'
				, [ValidationStatus]
				, [Row Count]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterHolidays]

	GROUP BY	[ValidationStatus]

	UNION ALL
	
	SELECT		  [Table]			= 'Product'
				, [ValidationStatus]
				, [Row Count]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterProduct]

	GROUP BY	[ValidationStatus]
END