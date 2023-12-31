This script collects system information, user details, drive details, running services, and installed application list and exports them to a password-protected zip file for easy sharing.

## Prerequisites

- PowerShell 7.3.5 or later version is recommended. You can download it from [here](https://github.com/PowerShell/PowerShell/releases/download/v7.3.9/PowerShell-7.3.9-win-x64.msi).
- #https://github.com/PowerShell/PowerShell/releases/download/v7.3.9/PowerShell-7.3.9-win-x64.msi
- #Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
- #PowerShell -ExecutionPolicy Bypass -File "D:\lalatendu.ps1"
- - #http://**.98.29.242/ocsinventory

## Usage

1. Download the script: [lalatendu.ps1](https://raw.githubusercontent.com/Lalatenduswain/CITPL/master/lalatendu.ps1)

2. Open PowerShell and navigate to the directory where the script is saved.

3. Run the following command to set the execution policy:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
   PowerShell -ExecutionPolicy Bypass -File "D:\lalatendu.ps1"
   ```
4. The script will collect the necessary information and export it to a password-protected zip file.

5. After completion, the script will display a success message, and the zip file will be saved on your desktop with the name "Email-This-File-To-Lalatendu.zip".

## Output Files

The script will generate the following output files:

- `SystemDetails.txt`: Contains system information and MAC addresses.
- `UserDetails.txt`: Contains user details on the current operating system.
- `DriveDetails.txt`: Contains folder and file details on the D drive (excluding the C system drive).
- `RunningServices.txt`: Contains a list of currently running services.
- `InstalledApplications.txt`: Contains a list of installed applications.

## Donations

If you want to show your appreciation, you can donate via [Buy Me a Coffee](https://www.buymeacoffee.com/lalatendu.swain)

## Disclaimer

This script is provided as-is and may require modifications or updates based on your specific environment and requirements. Use it at your own risk. The authors of the script are not liable for any damages or issues caused by its usage.

## License

This project is licensed under the [MIT License](LICENSE).
