$username = 'AzPipelineAgent'
$password = 'P@55w.rd'

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential $username, $securePassword
Start-Process PowerShell.exe -Credential $credential 