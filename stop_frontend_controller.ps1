if (Test-Path "frontend_controller.pid") {
    $process_pid = Get-Content "frontend_controller.pid"
    Stop-Process -Id $process_pid -Force -ErrorAction SilentlyContinue
    Remove-Item "frontend_controller.pid"
} else {
    Write-Host "PID file not found. Server may not be running."
}
