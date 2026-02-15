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

SET NOCOUNT ON;
--PRINT 'Creatint customer error messages...';
--:r .\Scripts\ErrorMessages.sql

--PRINT 'Creating resource governor...';
--:r .\Scripts\ResourceGovernor.sql

PRINT 'Initializing the data warehouse files registry...';
:r .\Scripts\InitializingDatabaseFilesRegistry.sql

PRINT 'Initializing the PBIRS reports registry...';
:r .\Scripts\InitializingPBIRSReportsRegistry.sql