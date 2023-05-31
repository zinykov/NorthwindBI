$password = ConvertTo-SecureString "P@55w.rd" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("PBIRSrelease", $password)

Write-RsRestFolderContent -Path:"C:\Users\zinyk\source\repos\Northwind_BI_Solution\NorthwindPBIRS\Sales" -RsFolder:"/" -Overwrite:$true -ReportPortalUri:"http://swift3/reports" -Credential:$Cred

$password = ConvertTo-SecureString "P@55w.rd" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("PBIRSrelease", $password)

$dataSources = Get-RsRestItemDataSource -RsItem:'/SalesV2' -Credential:$Cred -ReportPortalUri:'http://swift3/reports'

$dataSources[0].DataModelDataSource.AuthType = 'Windows'
$dataSources[0].DataModelDataSource.Username = 'SWIFT3\RDLexec'
$dataSources[0].DataModelDataSource.Secret = 'P@55w.rd'

Set-RsRestItemDataSource -RsItem:'/SalesV2' -RsItemType:PowerBIReport -DataSources:$datasources -Credential:$Cred -ReportPortalUri:'http://swift3/reports'

New-RsRestCacheRefreshPlan -RsItem:'/SalesV2' -StartDateTime:"2023-05-31T11:00:00+03:00" -Credential:$Cred -ReportPortalUri:'http://swift3/reports'

$ID = Get-RsRestCacheRefreshPlan -RsReport:"/SalesV2"  -Credential:$Cred -ReportPortalUri:'http://swift3/reports' | Select-Object -ExpandProperty:"ID"
        
Start-RsRestCacheRefreshPlan -Id:$ID -Credential:$Cred -ReportPortalUri:'http://swift3/reports'