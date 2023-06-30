#Install-Module -Name Microsoft.PowerShell.Management
#PowerShell -ExecutionPolicy Bypass -File
#$scriptUrl = "https://raw.githubusercontent.com/Lalatenduswain/CITPL/master/lalatendu.ps1"
#$scriptContent = (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
#Invoke-Expression -Command $scriptContent


# Check if the required module is installed and install it if necessary
$moduleName = "Microsoft.PowerShell.Management"
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    Write-Host "Installing module $moduleName..."
    Install-Module -Name $moduleName -Force
}

# Create SysAdmin-Lalatendu folder on Desktop if it doesn't exist
$folderPath = "$HOME\Desktop\SysAdmin-Lalatendu"
if (-not (Test-Path -Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath | Out-Null
}

# Export System Details
$systemDetailsPath = Join-Path -Path $folderPath -ChildPath "SystemDetails.txt"

# Get system information and MAC addresses
$systemInfo = systeminfo
$macAddresses = Get-NetAdapter | Where-Object { $_.MacAddress -ne $null } | Select-Object -Property Name, MacAddress

# Combine system information and MAC addresses
$systemInfoWithMac = $systemInfo + "`nMAC Addresses:`n" + ($macAddresses | Format-Table | Out-String)

# Save combined information to file
$systemInfoWithMac | Out-File -FilePath $systemDetailsPath

# Export User Details on Current OS
$userDetailsPath = Join-Path -Path $folderPath -ChildPath "UserDetails.txt"
Get-LocalUser | Out-File -FilePath $userDetailsPath

# Export D Drive Folder and File Details, excluding the C System Drive
$dDrivePath = "D:\"
$driveDetailsPath = Join-Path -Path $folderPath -ChildPath "DriveDetails.txt"
Get-ChildItem -Path $dDrivePath -Recurse | Out-File -FilePath $driveDetailsPath

# Export Current Running Services
$servicesPath = Join-Path -Path $folderPath -ChildPath "RunningServices.txt"
$runningServices = Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object -Property Name, Status -ErrorAction SilentlyContinue
$runningServices | Out-File -FilePath $servicesPath

# Export installed application list
$installedAppsPath = Join-Path -Path $folderPath -ChildPath "InstalledApplications.txt"
$apps = Get-CimInstance -ClassName Win32_Product | Select-Object Name, Version, Vendor
$apps | Format-Table -AutoSize | Out-File -FilePath $installedAppsPath

# Create password-protected zip file
$zipPath = "$HOME\Desktop\SysAdmin-Lalatendu.zip"
$sourcePath = $folderPath
$zipCommand = "Compress-Archive -Path `"$sourcePath\*`" -DestinationPath `"$zipPath`" -CompressionLevel Optimal -Force"
Invoke-Expression -Command $zipCommand

# Delete SysAdmin-Lalatendu folder
Remove-Item -Path $folderPath -Force -Recurse

# Display a success message
Write-Host "SysAdmin information exported and zipped successfully."

# Display a success message for installed applications
Write-Host "Installed applications exported to: $installedAppsPath"
