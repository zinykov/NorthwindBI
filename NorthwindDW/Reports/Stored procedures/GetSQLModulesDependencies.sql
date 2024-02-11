﻿CREATE PROCEDURE [Reports].[GetSQLModulesDependencies]
AS BEGIN
    SELECT        OBJECT_NAME ( [referencing_id] ) AS [referencing_entity_name]
                ,  o.[type_desc] AS [referencing_desciption]
                ,  COALESCE ( COL_NAME ( [referencing_id], [referencing_minor_id] ), '(n/a)' ) AS [referencing_minor_id]
                , [referencing_class_desc]
                , [referenced_class_desc]
                , [referenced_server_name]
                , [referenced_database_name]
                , [referenced_schema_name]
                , [referenced_entity_name]
                , COALESCE ( COL_NAME ( [referenced_id], [referenced_minor_id] ), '(n/a)' ) AS [referenced_column_name]
                , [is_caller_dependent]
                , [is_ambiguous]
    FROM        sys.sql_expression_dependencies AS SED
    INNER JOIN  sys.objects AS O ON SED.[referencing_id] = O.[object_id]
END