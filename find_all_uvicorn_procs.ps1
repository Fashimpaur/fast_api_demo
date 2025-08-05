# Get all processes that have 'uvicorn' in their command line
$uvicornProcesses = Get-CimInstance Win32_Process | Where-Object {
    $_.CommandLine -match "uvicorn"
}

if ($uvicornProcesses.Count -eq 0) {
    Write-Host "No uvicorn processes found."
} else {
    Write-Host "Found uvicorn processes:`n"
    foreach ($proc in $uvicornProcesses) {
        Write-Host "PID: $($proc.ProcessId)"
        Write-Host "CommandLine: $($proc.CommandLine)"
        Write-Host "--------"
    }
}
