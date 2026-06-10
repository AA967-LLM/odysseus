$ErrorActionPreference = "SilentlyContinue"

Write-Host "Checking/Starting Ollama background service..." -ForegroundColor Cyan
# Start Ollama invisibly. If it's already running, this just gracefully fails/exits.
Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden

Write-Host "Starting Odysseus Web Server..." -ForegroundColor Cyan
# Start Odysseus in a new visible window so you can see its logs and close it when done.
Start-Process -FilePath "powershell" -ArgumentList "-ExecutionPolicy Bypass -NoExit -File `"D:\Google antigravity\CREATIONS\odysseus\launch-windows.ps1`""

Write-Host "Waiting for server to spin up..." -ForegroundColor Yellow
Start-Sleep -Seconds 6

Write-Host "Opening Odysseus in your default browser..." -ForegroundColor Green
Start-Process "http://127.0.0.1:7000"
