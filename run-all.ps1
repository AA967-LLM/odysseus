$ErrorActionPreference = "SilentlyContinue"

Write-Host "Cleaning up any zombie processes on ports 7000 and 8100..." -ForegroundColor Yellow
Get-NetTCPConnection -LocalPort 7000, 8100 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }

Write-Host "Checking/Starting Ollama background service..." -ForegroundColor Cyan
# Start Ollama invisibly. If it's already running, this just gracefully fails/exits.
Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden
Write-Host "Starting ChromaDB vector store..." -ForegroundColor Cyan
Start-Process -FilePath "D:\Google antigravity\CREATIONS\odysseus\venv\Scripts\chroma.exe" -ArgumentList "run --path `"D:\Google antigravity\CREATIONS\odysseus\data\chroma`" --port 8100" -WindowStyle Hidden

Write-Host "Starting Odysseus Web Server..." -ForegroundColor Cyan
# Start Odysseus in a new visible window so you can see its logs and close it when done.
Start-Process -FilePath "powershell" -ArgumentList "-ExecutionPolicy Bypass -NoExit -File `"D:\Google antigravity\CREATIONS\odysseus\launch-windows.ps1`""

Write-Host "Waiting for server to spin up..." -ForegroundColor Yellow
Start-Sleep -Seconds 6

Write-Host "Opening Odysseus in your default browser..." -ForegroundColor Green
Start-Process "http://127.0.0.1:7000"
