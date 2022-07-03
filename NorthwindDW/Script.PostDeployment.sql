/*
Шаблон скрипта после развертывания							
--------------------------------------------------------------------------------------
 В данном файле содержатся инструкции SQL, которые будут добавлены в скрипт построения.		
 Используйте синтаксис SQLCMD для включения файла в скрипт после развертывания.			
 Пример:      :r .\myfile.sql								
 Используйте синтаксис SQLCMD для создания ссылки на переменную в скрипте после развертывания.		
 Пример:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
ALTER DATABASE [$(DatabaseName)]
    MODIFY FILEGROUP [Default_FG] DEFAULT;
GO

GRANT SELECT ON SCHEMA::[PowerBI] TO [dwh_user];  
GO

GRANT SELECT ON SCHEMA::[SSRS] TO [dwh_user];
GO

ALTER ROLE [dwh_user] ADD MEMBER [SWIFT3\UserBI];
GO

INSERT INTO [Integration].[Lineage] (
          [DataLoadStarted]
        , [TableName]
        , [DataLoadCompleted]
        , [WasSuccessful]
        , [CutoffTime]
    )
    VALUES (
          DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , N'Customer'
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , 1
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
    )
    , (
          DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , N'Employee'
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , 1
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
    )
    , (
          DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , N'Product'
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , 1
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
    )
    , (
          DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , N'Order'
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
        , 1
        , DATETIME2FROMPARTS ( 1996, 01, 01, 0, 0, 0, 0, 0 )
    )