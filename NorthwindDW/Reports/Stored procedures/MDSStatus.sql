CREATE PROCEDURE [Reports].[MDSStatus]
AS BEGIN
	SELECT		  [Table]			= 'Customer'
				, [ValidationStatus]
				, [RowCount]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterCustomer]

	GROUP BY	[ValidationStatus]

	UNION ALL
	
	SELECT		  [Table]			= 'Employee'
				, [ValidationStatus]
				, [RowCount]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterEmployee]

	GROUP BY	[ValidationStatus]

	UNION ALL
	
	SELECT		  [Table]			= 'Holidays'
				, [ValidationStatus]
				, [RowCount]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterHolidays]

	GROUP BY	[ValidationStatus]

	UNION ALL
	
	SELECT		  [Table]			= 'Product'
				, [ValidationStatus]
				, [RowCount]		= COUNT ( * )

	FROM		[$(MDSServerName)].[$(MDSDatabaseName)].[mdm].[MasterProduct]

	GROUP BY	[ValidationStatus]
END