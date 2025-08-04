if (Test-Path "frontend_controller.pid") {
    $pid = Get-Content "frontend_controller.pid"
    Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue
    Remove-Item "frontend_controller.pid"
} else {
    Write-Host "PID file not found. Server may not be running."
}
