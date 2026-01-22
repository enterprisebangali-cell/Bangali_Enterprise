# Deployment Script for Bangali Enterprise
# Usage: Right-click and "Run with PowerShell" inside the folder.

$RemoteHost = "195.35.39.191"
$RemoteUser = "u562139744"
$RemotePort = "65002"
$RemotePath = "public_html/"

$LocalDistPath = ".\dist-production"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Bangali Enterprise Deployment Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Target: $RemoteUser@$RemoteHost"
Write-Host "Port: $RemotePort"
Write-Host "Uploading to: $RemotePath"
Write-Host ""

if (-not (Test-Path $LocalDistPath)) {
    Write-Error "Error: 'dist-production' folder not found in current directory."
    Write-Host "Please ensure you run this script from the project root." -ForegroundColor Yellow
    Pause
    Exit
}

Write-Host "Starting Upload... (You will be asked for your SSH Password)" -ForegroundColor Yellow

# Using scp to copy contents.
# Note: We change directory to dist-production and copy '.' content to ensure correct structure.
# Using Push-Location to safely change dir
Push-Location $LocalDistPath
scp -P $RemotePort -r . "${RemoteUser}@${RemoteHost}:${RemotePath}"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Deployment Successful!" -ForegroundColor Green
    Write-Host "Visit your site at: http://$RemoteHost (or your domain)"
} else {
    Write-Host ""
    Write-Host "❌ Deployment Failed. Please check the error messages above." -ForegroundColor Red
}

Pop-Location
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
