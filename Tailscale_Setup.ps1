# ============================================
# Tailscale - Allow Non-Admin Users Setup
# Run this script as Administrator
# ============================================

# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: Please run this script as Administrator." -ForegroundColor Red
    exit 1
}

$registryPath = "HKLM:\SOFTWARE\Tailscale IPN"

# Step 1 - Create registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Registry key created." -ForegroundColor Yellow
} else {
    Write-Host "Registry key already exists." -ForegroundColor Cyan
}

# Step 2 - Set AllowNonAdminUsers
Set-ItemProperty -Path $registryPath -Name "AllowNonAdminUsers" -Value 1 -Type DWord
Write-Host "AllowNonAdminUsers set to 1 successfully." -ForegroundColor Green

# Step 3 - Set HideTrayIcon
Set-ItemProperty -Path $registryPath -Name "HideTrayIcon" -Value 1 -Type DWord
Write-Host "HideTrayIcon set to 1 successfully." -ForegroundColor Green

# Step 4 - Verify both values
Write-Host ""
Write-Host "--- Verifying Registry Values ---" -ForegroundColor Cyan
$verify = Get-ItemProperty -Path $registryPath
Write-Host "AllowNonAdminUsers : $($verify.AllowNonAdminUsers)" -ForegroundColor Green
Write-Host "HideTrayIcon       : $($verify.HideTrayIcon)" -ForegroundColor Green

# Step 5 - Add Tailscale to System PATH if not already added
$tailscalePath = "C:\Program Files\Tailscale"

if (Test-Path $tailscalePath) {
    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($currentPath -notlike "*Tailscale*") {
        [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$tailscalePath", "Machine")
        Write-Host "Tailscale added to System PATH successfully." -ForegroundColor Green
    } else {
        Write-Host "Tailscale is already in System PATH." -ForegroundColor Cyan
    }
} else {
    Write-Host "WARNING: Tailscale installation folder not found at $tailscalePath" -ForegroundColor Yellow
    Write-Host "Please verify your Tailscale installation path." -ForegroundColor Yellow
}

# Step 6 - Restart Tailscale Service
Write-Host ""
Write-Host "Restarting Tailscale service..." -ForegroundColor Yellow
Restart-Service -Name Tailscale -ErrorAction SilentlyContinue
Write-Host "Tailscale service restarted." -ForegroundColor Green

# Done
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Setup Complete! Please REBOOT your system " -ForegroundColor Cyan
Write-Host " for all changes to take full effect.      " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
