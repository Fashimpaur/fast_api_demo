# Get the directory where this script is located
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition
$pidDirectory = $scriptDirectory  # Use the script's location as the PID directory

Write-Host "🔍 Looking for .pid files in: $pidDirectory"

# STEP 1: Stop all running uvicorn processes
Write-Host "🔍 Searching for all running uvicorn processes..."

$uvicornProcs = Get-CimInstance Win32_Process | Where-Object {
    $_.CommandLine -match "uvicorn"
}

if ($uvicornProcs.Count -eq 0) {
    Write-Host "✅ No running uvicorn processes found."
} else {
    foreach ($proc in $uvicornProcs) {
        try {
            Stop-Process -Id $proc.ProcessId -Force -ErrorAction Stop
            Write-Host "🛑 Stopped uvicorn process: PID $($proc.ProcessId)"
        } catch {
            Write-Host "⚠️ Failed to stop PID $($proc.ProcessId): $_"
        }
    }
}

# STEP 2: Delete all stale PID files
Write-Host "`n🧹 Removing stale .pid files..."

if (Test-Path $pidDirectory) {
    Get-ChildItem -Path $pidDirectory -Filter *.pid | ForEach-Object {
        try {
            Remove-Item $_.FullName -Force -ErrorAction Stop
            Write-Host "🗑️ Removed: $($_.FullName)"
        } catch {
            Write-Host "⚠️ Failed to delete PID file $($_.FullName): $_"
        }
    }
} else {
    Write-Host "⚠️ PID directory not found: $pidDirectory"
}
