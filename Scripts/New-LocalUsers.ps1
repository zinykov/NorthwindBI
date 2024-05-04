$Password = Read-Host -AsSecureString

# Realese pipeline
New-LocalUser -Name "AzPipelineAgent" -Password $Password -Description "Realese pipeline" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
New-LocalUser -Name "PBIRSrelease" -Password $Password -Description "Realese pipeline" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
# SQL Server serivices accounts
New-LocalUser -Name "SQLSERVER" -Password $Password -Description "SQL Server serivices accounts" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
New-LocalUser -Name "SQLINTEGRATION" -Password $Password -Description "SQL Server serivices accounts" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
New-LocalUser -Name "SQLAGENT" -Password $Password -Description "SQL Server serivices accounts" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
New-LocalUser -Name "MDS" -Password $Password -Description "SQL Server serivices accounts" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
New-LocalUser -Name "PBIRS" -Password $Password -Description "Power BI Report Server serivices accounts" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
# PBIRS execution account
New-LocalUser -Name "PBIRSexec" -Description "PBIRS execution account" -Password $Password -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword
# Abstract data analyst account
New-LocalUser -Name "DataAnalyst" -Password $Password -Description "Abstract data analyst account" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword

# Add AzPipelineAgent to local 
Add-LocalGroupMember -Group "Пользователи системного монитора" -Member "AzPipelineAgent"