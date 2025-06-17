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

# OCS Inventory NG Agent Installation Guide for Ubuntu

This guide will walk you through installing, configuring, and verifying the OCS Inventory NG Unix Agent on an Ubuntu system.

---

## Prerequisites

* Ubuntu system with internet access
* Access to an OCS Inventory NG Server
  *Example server URL:* `http://**.98.29.242/ocsinventory`
* Root or sudo privileges

---

## Step 1: Install Required Dependencies

```bash
sudo apt update
sudo apt install -y \
  perl \
  make \
  libxml-simple-perl \
  libcompress-zlib-perl \
  libnet-ip-perl \
  libdigest-md5-perl \
  libnet-ssleay-perl \
  libcrypt-ssleay-perl \
  libnet-snmp-perl \
  libmodule-install-perl \
  libuniversal-require-perl \
  libwww-perl \
  liblwp-protocol-https-perl \
  libdata-uuid-perl \
  dmidecode \
  pciutils \
  libsoap-lite-perl \
  curl \
  git
```

---

## Step 2: Download the Unix Agent Source Code

```bash
cd ~/Desktop
wget https://github.com/OCSInventory-NG/UnixAgent/archive/refs/tags/2.10.4.tar.gz
tar -xzf 2.10.4.tar.gz
cd Ocsinventory-Unix-Agent-2.10.4
```

---

## Step 3: Install the Agent

```bash
sudo perl Makefile.PL
sudo make
sudo make install
```

---

## Step 4: Run the Post-Install Configuration Script

```bash
sudo perl postinst.pl
```

When prompted, use the following values:

| Prompt                                 | Recommended Input                  |
| -------------------------------------- | ---------------------------------- |
| Do you want to configure the agent?    | `y`                                |
| Where to write the configuration file? | `0` (`/etc/ocsinventory`)          |
| Create directory `/etc/ocsinventory`?  | `y`                                |
| Import old unix\_agent settings?       | `n`                                |
| OCS Server URL                         | `http://**.98.29.242/ocsinventory` |
| Need credentials for server?           | `n`                                |
| Apply admin tag?                       | `y` → `CITPL-LALA-ASUS-NUC`        |
| Install cron task?                     | `y`                                |
| Agent storage path                     | Press `Enter` to accept default    |
| Create storage directory?              | `y`                                |
| Remove old unix\_agent?                | `n`                                |
| Enable debug mode?                     | `y`                                |
| Use unified log file?                  | `y`                                |
| Log file path                          | `/var/log/ocsinventory-agent.log`  |
| Disable SSL verification (no HTTPS)?   | `y`                                |
| Set CA cert file path?                 | `n`                                |
| Disable software inventory?            | `n`                                |
| Use software deployment feature?       | `y`                                |
| Use SNMP scan feature?                 | `y`                                |
| Send inventory now?                    | `y`                                |

---

## Step 5: Manually Test the Agent

```bash
sudo ocsinventory-agent --debug
```

### Expected Output:

* Inventory data collected
* Data sent to: `http://**.98.29.242/ocsinventory`
* Status: `Inventory successfully sent`

---

## Step 6: Verify Cron Job

```bash
cat /etc/cron.d/ocsinventory-agent
```

By default, the cron job runs once daily to send updated inventory.

---

## Step 7: Verify on OCS Server Dashboard

Log into your OCS Inventory Web UI.

Search for:

* Machine Tag: `CITPL-LALA-ASUS-NUC`
* Or your system's hostname

---

## Optional: Clean/Reconfigure Agent

If needed, remove existing config and re-run post-install:

```bash
sudo rm -rf /etc/ocsinventory /var/lib/ocsinventory-agent /var/log/ocsinventory-agent.log
sudo perl postinst.pl
```

---

## Files and Locations Summary

| Purpose        | Path                                       |
| -------------- | ------------------------------------------ |
| Agent binary   | `/usr/local/bin/ocsinventory-agent`        |
| Config file    | `/etc/ocsinventory/ocsinventory-agent.cfg` |
| Inventory data | `/var/lib/ocsinventory-agent/`             |
| Log file       | `/var/log/ocsinventory-agent.log`          |
| Cron job       | `/etc/cron.d/ocsinventory-agent`           |

---

## Notes on HTTPS (Optional)

If your server uses HTTPS in the future:

* Re-run `postinst.pl`
* Disable `no_ssl_check` in the config
* Make sure CA certificates are installed in `/etc/ssl/certs`

---

*This documentation is prepared by Lalatendu K. Swain for production deployment.*
