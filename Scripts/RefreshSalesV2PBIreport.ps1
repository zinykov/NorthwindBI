# Start-Process -FilePath:"C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe" -Credential:"SWIFT3\AzPipelineAgent"

$password = "P@55w.rd"
$PBIRSServerName = "SWIFT3"

$passwordSS = ConvertTo-SecureString $password -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("PBIRSrelease", $passwordSS)
$ReportPortalUri = "http://" + $PBIRSServerName + "/reports"
$WebSession = New-RsRestSession -ReportPortalUri:$ReportPortalUri -RestApiVersion:v2.0 -Credential:$Cred

$RsItem = "/SalesV2"
$Username = $PBIRSServerName + "\RDLexec"

$dataSources = Get-RsRestItemDataSource -RsItem:$RsItem -WebSession:$WebSession
$dataSources[0].DataModelDataSource.AuthType = "Windows"
$dataSources[0].DataModelDataSource.Username = $Username
$dataSources[0].DataModelDataSource.Secret = $password

Set-RsRestItemDataSource -RsItem:$RsItem -RsItemType:PowerBIReport -DataSources:$datasources -WebSession:$WebSession

New-RsRestCacheRefreshPlan -RsItem:$RsItem -StartDateTime:"2023-05-31T11:00:00+03:00" -WebSession:$WebSession

$ID = Get-RsRestCacheRefreshPlan -RsReport:$RsItem -WebSession:$WebSession | Select-Object -ExpandProperty:"ID" -First:1 | Out-String

Start-RsRestCacheRefreshPlan -Id:$ID -WebSession:$WebSession