CREATE PROCEDURE [Reports].[GetSQLModulesDependencies]
    @EntityName AS NVARCHAR(128) = NULL
WITH EXECUTE AS OWNER
AS BEGIN
    IF ( @EntityName IS NOT NULL )
        BEGIN
            SELECT        OBJECT_SCHEMA_NAME ( [referencing_id] ) AS [ReferencingSchemaEntityName]
                        , OBJECT_NAME ( [referencing_id] ) AS [ReferencingEntityName]
                        ,  o.[type_desc] AS [ReferencingDesciption]
                        ,  COALESCE ( COL_NAME ( [referencing_id], [referencing_minor_id] ), '(n/a)' ) AS [ReferencingMinorId]
                        , [referencing_class_desc] AS [ReferencingClassDesc]
                        , [referenced_class_desc] AS [ReferencedClassDesc]
                        , [referenced_server_name] AS [ReferencedServerName]
                        , [referenced_database_name] AS [ReferencedDatabaseName]
                        , [referenced_schema_name] AS [ReferencedSchemaName]
                        , [referenced_entity_name] AS [ReferencedEntityName]
                        , COALESCE ( COL_NAME ( [referenced_id], [referenced_minor_id] ), '(n/a)' ) AS [ReferencedColumnName]
                        , [is_caller_dependent] AS [IsCallerDependent]
                        , [is_ambiguous] AS [IsAmbiguous]
            FROM        sys.sql_expression_dependencies AS SED
            INNER JOIN  sys.objects AS O ON SED.[referencing_id] = O.[object_id]
            WHERE       [referencing_id] = OBJECT_ID ( @EntityName )
                        OR [referenced_entity_name] = @EntityName
        END
    ELSE
        BEGIN
            SELECT        OBJECT_SCHEMA_NAME ( [referencing_id] ) AS [ReferencingSchemaEntityName]
                        , OBJECT_NAME ( [referencing_id] ) AS [ReferencingEntityName]
                        ,  o.[type_desc] AS [ReferencingDesciption]
                        ,  COALESCE ( COL_NAME ( [referencing_id], [referencing_minor_id] ), '(n/a)' ) AS [ReferencingMinorId]
                        , [referencing_class_desc] AS [ReferencingClassDesc]
                        , [referenced_class_desc] AS [ReferencedClassDesc]
                        , [referenced_server_name] AS [ReferencedServerName]
                        , [referenced_database_name] AS [ReferencedDatabaseName]
                        , [referenced_schema_name] AS [ReferencedSchemaName]
                        , [referenced_entity_name] AS [ReferencedEntityName]
                        , COALESCE ( COL_NAME ( [referenced_id], [referenced_minor_id] ), '(n/a)' ) AS [ReferencedColumnName]
                        , [is_caller_dependent] AS [IsCallerDependent]
                        , [is_ambiguous] AS [IsAmbiguous]
            FROM        sys.sql_expression_dependencies AS SED
            INNER JOIN  sys.objects AS O ON SED.[referencing_id] = O.[object_id]
        END
END