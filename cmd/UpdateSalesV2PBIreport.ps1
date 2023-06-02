Start-Process "C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe" -Credential "SWIFT3\AzPipelineAgent"

$password = ConvertTo-SecureString "P@55w.rd" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("PBIRSrelease", $password)
$WebSession = New-RsRestSession -ReportPortalUri "http://swift3/reports" -RestApiVersion v2.0 -Credential $Cred

Write-RsRestFolderContent `
	-Path:"C:\Users\zinyk\source\repos\Northwind_BI_Solution\NorthwindPBIRS\Sales" `
	-RsFolder:"/" `
	-Overwrite:$true `
	-WebSession:$WebSession

$RsItem = "/SalesV2"

$dataSources = Get-RsRestItemDataSource -RsItem:$RsItem -WebSession:$WebSession
$dataSources[0].DataModelDataSource.AuthType = "Windows"
$dataSources[0].DataModelDataSource.Username = "SWIFT3\RDLexec"
$dataSources[0].DataModelDataSource.Secret = "P@55w.rd"

Set-RsRestItemDataSource -RsItem:$RsItem -RsItemType:PowerBIReport -DataSources:$datasources -WebSession:$WebSession

New-RsRestCacheRefreshPlan -RsItem:$RsItem -StartDateTime:"2023-05-31T11:00:00+03:00" -WebSession:$WebSession

$ID = Get-RsRestCacheRefreshPlan -RsReport:$RsItem -WebSession:$WebSession | Select-Object -ExpandProperty:"ID"

Start-RsRestCacheRefreshPlan -Id:$ID -WebSession:$WebSession