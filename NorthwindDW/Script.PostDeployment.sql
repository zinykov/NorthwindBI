﻿/*
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