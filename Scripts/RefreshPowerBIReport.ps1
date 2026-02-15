param (
    [string]$ServerName,
    [string]$ReportPath
)

try {
    Import-Module ReportingServicesTools -ErrorAction Stop;
    $uri = "http://$ServerName/Reports";
    $session = New-RsRestSession -ReportPortalUri $uri;

    Start-RsRestCacheRefreshPlan -RsReport $ReportPath -WebSession $session -ErrorAction Stop;

    do {
        Start-Sleep -Seconds 10;
        $plan = Get-RsRestCacheRefreshPlan -RsReport $ReportPath -WebSession $session | Select-Object -First 1;
        $status = $plan.Status;
    } while ($status -match 'Refreshing|New Scheduled');

    if ($status -ne 'Completed: Data Refresh') {
        throw "Status: $status";
    }
    exit 0;
}
catch {
    [Console]::Error.Write($_.Exception.Message);
    exit 1;
}