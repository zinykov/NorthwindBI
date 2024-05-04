--:setvar SSISProjectName NorthwindETL
--:setvar SSISFolderName NorthwindBI
--:setvar SSISEnvironmentName Release

EXECUTE [catalog].[delete_project] @project_name=N'$(SSISProjectName)', @folder_name=N'$(SSISFolderName)';
GO

EXECUTE [catalog].[delete_environment] @folder_name=N'$(SSISFolderName)', @environment_name=N'$(SSISEnvironmentName)';
GO

EXECUTE [catalog].[delete_folder] @folder_name=N'$(SSISFolderName)';
GO