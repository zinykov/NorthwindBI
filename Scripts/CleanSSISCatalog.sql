--:setvar SSISProjectName NorthwindETL
--:setvar SSISFolderName NorthwindBI

EXECUTE [catalog].[delete_project] @project_name=N'$(SSISProjectName)', @folder_name=N'$(SSISFolderName)';
GO

EXECUTE [catalog].[delete_environment] @folder_name=N'$(SSISFolderName)', @environment_name=N'Release';
GO

EXECUTE [catalog].[delete_environment] @folder_name=N'$(SSISFolderName)', @environment_name=N'Debug';
GO

EXECUTE [catalog].[delete_folder] @folder_name=N'$(SSISFolderName)';
GO