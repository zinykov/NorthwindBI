# Variables
$SSISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"
$TargetServerName = "SWIFT3"
$TargetFolderName = "20767"
$ProjectName = "NorthwindETL"
$PackageName = "Test.dtsx"
$EnvironmentName = "Test"

# Load the IntegrationServices assembly
$loadStatus = [System.Reflection.Assembly]::Load("Microsoft.SQLServer.Management.IntegrationServices, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL")

# Create a connection to the server
$sqlConnectionString = "Data Source=" + $TargetServerName + ";Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

# Create the Integration Services object
$integrationServices = New-Object $SSISNamespace".IntegrationServices" $sqlConnection

# Get the Integration Services catalog
$catalog = $integrationServices.Catalogs["SSISDB"]

# Get the folder
$folder = $catalog.Folders[$TargetFolderName]

# Get the project
$project = $folder.Projects[$ProjectName]

# Get the package
$package = $project.Packages[$PackageName]

# Get the environment
$environment = $folder.Environments[$EnvironmentName]
 
# Get the environment reference
$environmentReference = $project.References.Item($EnvironmentName, $TargetFolderName)            
$environmentReference.Refresh()
 
Write-Host "Running " $PackageName " with environment " $EnvironmentName
 
$result = $package.Execute("false", $environmentReference) #overloaded Execute
 
Write-Host "Done. " $result