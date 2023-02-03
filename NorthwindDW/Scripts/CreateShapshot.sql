--:setvar DQSDatabaseName DQS_STAGING_DATA
--:setvar DQSServerName SWIFT3
--:setvar DWHDatabaseName NorthwindDW
--:setvar DWHServerName SWIFT3
--:setvar MDSDatabaseName MDS
--:setvar MDSServerName SWIFT3
--:setvar SSISDatabaseName SISSDB
--:setvar SSISEnvironmentName SWIFT3
--:setvar SSISFolderName NorthwindETL
--:setvar SSISProjectName NorthwindETL
--:setvar SSISServerName SWIFT3

USE [$(DWHDatabaseName)];
GO

CREATE DATABASE имя_снимка_базы_данных ON (
	NAME = логическое_имя_файла,
	FILENAME ='имя_файла_ОС'
) AS SNAPSHOT OF source_database_name;