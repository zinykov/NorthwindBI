--sqlcmd -S $(SSISServerName) -d $(SSISDatabaseName) -i "$(System.DefaultWorkingDirectory)\_Build solution\drop\Scripts\CleanSSISCatalog.sql" -v SSISFolderName="$(SSISFolderName)" SSISProjectName="$(SSISProjectName)"
--:r C:\Users\ZinukovD\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

EXECUTE [catalog].[delete_project] @project_name=N'$(SSISProjectName)', @folder_name=N'$(SSISFolderName)';
GO

EXECUTE [catalog].[delete_environment] @folder_name=N'$(SSISFolderName)', @environment_name=N'Release';
GO

EXECUTE [catalog].[delete_environment] @folder_name=N'$(SSISFolderName)', @environment_name=N'Test';
GO

EXECUTE [catalog].[delete_environment] @folder_name=N'$(SSISFolderName)', @environment_name=N'Debug';
GO

EXECUTE [catalog].[delete_folder] @folder_name=N'$(SSISFolderName)';
GO