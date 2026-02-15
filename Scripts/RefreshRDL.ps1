<#
.SYNOPSIS
    Universal script for refreshing/warming up RDL reports on PBIRS.
    Automatically detects and executes Cache Refresh Plans or Snapshot Updates.
#>
param (
    [Parameter(Mandatory=$true)][string]$ServerName,
    [Parameter(Mandatory=$true)][string]$ReportPath
)

try {
    # Initialize module and session
    Import-Module ReportingServicesTools -ErrorAction Stop;
    $uri = "http://$ServerName/Reports";
    $session = New-RsRestSession -ReportPortalUri $uri;

    # Get report metadata to determine execution mode (Live vs Snapshot)
    $item = Get-RsRestItem -RsItem $ReportPath -WebSession $session;
    $isSnapshot = ($item.ExecutionSettings.ExecutionOptions -eq 'Snapshot');

    Write-Output "Processing RDL: [$ReportPath]. Mode: $(if ($isSnapshot) {'Snapshot'} else {'Live'})";

    # Look for Cache Refresh Plans (handles both Cache warming and Snapshot generation)
    $plans = Get-RsRestCacheRefreshPlan -RsReport $ReportPath -WebSession $session;

    if ($plans) {
        foreach ($plan in $plans) {
            Write-Output "Starting Plan: [$( $plan.Description )] (ID: $($plan.Id))...";
            Start-RsRestCacheRefreshPlan -RsReport $ReportPath -PlanId $plan.Id -WebSession $session;

            # Wait loop to synchronize with SSIS execution
            do {
                Start-Sleep -Seconds 10;
                $planDetails = Get-RsRestCacheRefreshPlan -RsReport $ReportPath -PlanId $plan.Id -WebSession $session;
                $status = $planDetails.Status;
                $lastRun = $planDetails.LastRunStatus;
            } while ($status -match 'Refreshing|New Scheduled');

            # Validate execution result
            if ($status -ne 'Completed: Data Refresh' -and $lastRun -ne 'Success') {
                throw "Plan execution failed for [$ReportPath]. Status: $status. LastRun: $lastRun";
            }
        }
    }
    else {
        # If no plans exist, perform "warm-up" by forcing a metadata/data model request
        Write-Output "No refresh plans found. Performing forced metadata request...";
        Get-RsRestItemDataModelParameters -RsItem $ReportPath -WebSession $session > $null;
    }

    Write-Output "Report [$ReportPath] processed successfully.";
    exit 0;
}
catch {
    # Forward error to StandardError for SSIS to capture
    [Console]::Error.Write("Error in RefreshRDL: " + $_.Exception.Message);
    exit 1;
}