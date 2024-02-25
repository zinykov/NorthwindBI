CREATE PROCEDURE [Reports].[GetReferenceInfo]
WITH EXECUTE AS OWNER
AS BEGIN
	SELECT		  F.[name] AS [ForeignKeyName]
				, OBJECT_NAME ( F.[parent_object_id] ) AS [TableName]
				, COL_NAME ( FC.[parent_object_id], FC.[parent_column_id] ) AS [ConstraintColumnName]
				, OBJECT_NAME ( F.[referenced_object_id] ) AS [ReferencedObject]
				, COL_NAME ( FC.[referenced_object_id], FC.[referenced_column_id] ) AS [ReferencedColumnName]
				, F.[is_disabled] AS [IsDisabled]
				, F.[is_not_trusted] AS [IsNotTrusted]
				, F.[delete_referential_action_desc] AS [DeleteReferentialActionDesc]
				, F.[update_referential_action_desc] AS [UpdateReferentialActionDesc]
	FROM		sys.foreign_keys AS F
	INNER JOIN	sys.foreign_key_columns AS FC ON F.[object_id] = FC.[constraint_object_id];
END