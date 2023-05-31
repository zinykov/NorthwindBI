param(
[Parameter(Mandatory = $True, ValueFromPipeline = $true)]
[string[]]
$Path
)
if (!(Test-Path -Path $Path -PathType Container))
{
    throw "No folder found at $Path!"
}
Write-RsRestFolderContent -Path $Path -RsFolder "/" -Overwrite

$dataSources = Get-RsRestItemDataSource -RsItem '/SalesV2'

$dataSources[0].DataModelDataSource.AuthType = 'Windows'
$dataSources[0].DataModelDataSource.Username = 'SWIFT3\RDLexec'
$dataSources[0].DataModelDataSource.Secret = 'P@55w.rd'

Set-RsRestItemDataSource -RsItem '/SalesV2' -RsItemType PowerBIReport -DataSources $datasources

New-RsRestCacheRefreshPlan -RsItem '/SalesV2' -StartDateTime "2023-05-31T11:00:00+03:00"

$ID = Get-RsRestCacheRefreshPlan -RsReport "/SalesV2" | Select-Object -ExpandProperty "ID"
        
Start-RsRestCacheRefreshPlan -Id $ID