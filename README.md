This script collects system information, user details, drive details, running services, and installed application list and exports them to a password-protected zip file for easy sharing.

## Prerequisites

- PowerShell 7.3.5 or later version is recommended. You can download it from [here](https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-x64.msi).

## Usage

1. Download the script: [lalatendu.ps1](https://github.com/Lalatenduswain/CITPL/blob/master/lalatendu.ps1)

2. Open PowerShell and navigate to the directory where the script is saved.

3. Run the following command to set the execution policy:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
   ```

4. Run the script using the following command:
   ```powershell
   PowerShell -ExecutionPolicy Bypass -File "D:\lalatendu.ps1"
   ```

5. The script will collect the necessary information and export it to a password-protected zip file.

6. After completion, the script will display a success message, and the zip file will be saved on your desktop with the name "Email-This-File-To-Lalatendu.zip".

## Output Files

The script will generate the following output files:

- `SystemDetails.txt`: Contains system information and MAC addresses.
- `UserDetails.txt`: Contains user details on the current operating system.
- `DriveDetails.txt`: Contains folder and file details on the D drive (excluding the C system drive).
- `RunningServices.txt`: Contains a list of currently running services.
- `InstalledApplications.txt`: Contains a list of installed applications.

## Notes

- Make sure to run the script with appropriate permissions to access system information and services.
- Ensure that you have the necessary privileges to create folders and files in the specified locations.
- The script requires the `Microsoft.PowerShell.Management` module. If it's not installed, the script will install it automatically.

## License

This project is licensed under the [MIT License](LICENSE).
```

Make sure to replace the Git URL in the above template with the actual URL of your script.
