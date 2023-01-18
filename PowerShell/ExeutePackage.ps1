#Params
param (
	$SSISServerName,
	$SSISFolderName,
	$SSISProjectName,
	$SSISPackageName,
	$SSISEnvironmentName
)

# Variables
$SSISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"

# Load the IntegrationServices assembly
$loadStatus = [System.Reflection.Assembly]::Load("Microsoft.SQLServer.Management.IntegrationServices, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL")

# Create a connection to the server
$sqlConnectionString = "Data Source=" + $SSISServerName + ";Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

# Create the Integration Services object
$integrationServices = New-Object $SSISNamespace".IntegrationServices" $sqlConnection

# Get the Integration Services catalog
$catalog = $integrationServices.Catalogs["SSISDB"]

# Get the folder
$folder = $catalog.Folders[$SSISFolderName]

# Get the project
$project = $folder.Projects[$SSISProjectName]

# Get the package
$package = $project.Packages[$SSISPackageName]

# Get the environment
$environment = $folder.Environments[$SSISEnvironmentName]
 
# Get the environment reference
$environmentReference = $project.References.Item($SSISEnvironmentName, $SSISFolderName)            
$environmentReference.Refresh()
 
Write-Host "Running " $SSISPackageName " with environment " $SSISEnvironmentName
 
$result = $package.Execute("false", $environmentReference) #overloaded Execute
 
Write-Host "Done. " $result