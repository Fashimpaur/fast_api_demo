# Get the directory where this script is located (scripts\)
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Project root is one level up from scripts\
$projectRoot = Resolve-Path "$scriptDirectory\.."

Write-Host "Looking for .pid files in project root: $projectRoot"

# STEP 1: Stop all running uvicorn processes
Write-Host "Searching for all running uvicorn processes..."

$uvicornProcs = Get-CimInstance Win32_Process | Where-Object {
    $_.CommandLine -match "uvicorn"
}

if ($uvicornProcs.Count -eq 0) {
    Write-Host "No running uvicorn processes found."
} else {
    foreach ($proc in $uvicornProcs) {
        if (Get-Process -Id $proc.ProcessId -ErrorAction SilentlyContinue) {
            try {
                Stop-Process -Id $proc.ProcessId -Force -ErrorAction Stop
                Write-Host "Stopped uvicorn process: PID $($proc.ProcessId)"
            } catch {
                Write-Host "Failed to stop PID $($proc.ProcessId): $_"
            }
        } else {
            Write-Host "PID $($proc.ProcessId) is no longer running."
        }
    }
}

# STEP 2: Delete all stale PID files in project root
Write-Host "Removing stale .pid files..."

if (Test-Path $projectRoot) {
    $pidFiles = Get-ChildItem -Path $projectRoot -Filter *.pid
    if ($pidFiles.Count -eq 0) {
        Write-Host "No stale .pid files found."
    } else {
        $pidFiles | ForEach-Object {
            try {
                Remove-Item $_.FullName -Force -ErrorAction Stop
                Write-Host "Removed: $($_.FullName)"
            } catch {
                Write-Host "Failed to delete PID file $($_.FullName): $_"
            }
        }
    }
} else {
    Write-Host "Project root directory not found: $projectRoot"
}
