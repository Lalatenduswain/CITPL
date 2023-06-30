# The script will gather the following information and export it into a ZIP file


```

SysAdmin-Lalatendu is a PowerShell script that collects system information, user details, drive details, running services, installed applications, and exports them into a password-protected ZIP file. This script is useful for system administrators or IT professionals who need to gather comprehensive information about a Windows system.


#Install-Module -Name Microsoft.PowerShell.Management
#PowerShell -ExecutionPolicy Bypass -File
#$scriptUrl = "https://raw.githubusercontent.com/Lalatenduswain/citpl/master/lalatendu-ps1"
#$scriptContent = (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
#Invoke-Expression -Command $scriptContent


## Prerequisites

- PowerShell version 5.1 or later
- Microsoft.PowerShell.Management module (automatically installed if not present)

## Usage

1. Clone or download this repository to your local machine.

2. Open a PowerShell session and navigate to the cloned/downloaded directory.

3. Modify the execution policy to allow running the script by following these steps:

   - Open a PowerShell session with administrative privileges.
   - Run the following command to check the current execution policy:

     ```powershell
     Get-ExecutionPolicy
     ```

   - If the current execution policy is set to "Restricted," you need to change it. Choose one of the following options:

     - **RemoteSigned**: Allows the execution of scripts that are downloaded from the internet and have a valid digital signature. Other scripts require no signature. This is a recommended option for most cases.

     - **Unrestricted**: Allows the execution of all scripts without any restrictions. This option can pose a security risk, so use it with caution.

   - To change the execution policy to "RemoteSigned," run the following command:

     ```powershell
     Set-ExecutionPolicy RemoteSigned
     ```

     If you prefer the "Unrestricted" option, run:

     ```powershell
     Set-ExecutionPolicy Unrestricted
     ```

   - When prompted, confirm the change by entering "Y" and pressing Enter.

4. Run the script by executing the following command:

	powershell
	.\lalatendu.ps1


5. The script will gather the following information and export it into a password-protected ZIP file:

   - System details (including MAC addresses)
   - User details on the current operating system
   - Drive details from the D drive (excluding the C system drive)
   - Running services
   - Installed applications
   - `msinfo32` output

6. The resulting ZIP file, named `SysAdmin-Lalatendu.zip`, will be created on your desktop.

7. Extract the contents of the ZIP file using the password you provided during script execution.

8. Once you have extracted the files, review the generated text files to access the collected information.

9. After reviewing the files, you can safely delete the ZIP file and the `SysAdmin-Lalatendu` folder.

## Customization

- If you want to change the output folder for the exported files, modify the `$folderPath` variable in the script.
- By default, the script exports details from the D drive. If you want to change the drive, modify the `$dDrivePath` variable in the script.
- You can adjust the compression level of the ZIP file by modifying the `-CompressionLevel` parameter in the `$zipCommand` variable.

## Security Considerations

- Running scripts obtained from external sources can be a security risk. Ensure that you trust the source of the script before executing it on your system.
- This script gathers system information, including details about running services and installed applications. Be mindful of any sensitive information that might be included in the generated files.
- Protect the generated ZIP file with a strong password to prevent unauthorized access to the collected information.

## License

This project is licensed under the [MIT License](LICENSE).
```

Make sure to replace "lalatendu.ps1" with the actual filename

 of your PowerShell script.
