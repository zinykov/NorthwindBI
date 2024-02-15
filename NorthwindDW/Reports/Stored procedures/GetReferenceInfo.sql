CREATE PROCEDURE [Reports].[GetReferencesInfo]
AS BEGIN
	SELECT		  F.[name] AS [foreign_key_name]
				, OBJECT_NAME ( F.[parent_object_id] ) AS [table_name]
				, COL_NAME ( FC.[parent_object_id], FC.[parent_column_id] ) AS [constraint_column_name]
				, OBJECT_NAME ( F.[referenced_object_id] ) AS [referenced_object]
				, COL_NAME ( FC.[referenced_object_id], FC.[referenced_column_id] ) AS [referenced_column_name]
				, F.[is_disabled]
				, F.[is_not_trusted]
				, F.[delete_referential_action_desc]
				, F.[update_referential_action_desc]
	FROM		sys.foreign_keys AS F
	INNER JOIN	sys.foreign_key_columns AS FC ON F.[object_id] = FC.[constraint_object_id];
END