#!/bin/bash

# Author: Lalatendu Swain
# Description: Install and configure OCS Inventory NG Unix Agent on Ubuntu

set -e

# Function to prompt with default
prompt() {
  local PROMPT="$1"
  local DEFAULT="$2"
  read -p "$PROMPT [$DEFAULT]: " REPLY
  echo "${REPLY:-$DEFAULT}"
}

# Step 1: Install dependencies
echo "[+] Installing required dependencies..."
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
  git \
  unzip

# Step 2: Download source
echo "[+] Downloading OCS Unix Agent..."
cd ~/Desktop || exit 1
wget -q https://github.com/Lalatenduswain/CITPL/raw/refs/heads/master/ocs-linux-citpl.tar.gz

tar -xzf ocs-linux-citpl.tar.gz
cd ocs-linux-citpl || exit 1

# Step 3: Build & install
echo "[+] Building and installing agent..."
sudo perl Makefile.PL
sudo make
sudo make install

# Step 4: Configuration
echo "[+] Running post-install configuration..."
CONFIG_PATH_CHOICE=$(prompt "Choose config directory (0=/etc/ocsinventory, 1=/usr/local/etc/ocsinventory, 2=/etc/ocsinventory-agent)" "0")
case "$CONFIG_PATH_CHOICE" in
  0) CONFIG_DIR="/etc/ocsinventory" ;;
  1) CONFIG_DIR="/usr/local/etc/ocsinventory" ;;
  2) CONFIG_DIR="/etc/ocsinventory-agent" ;;
  *) CONFIG_DIR="/etc/ocsinventory" ;;
esac

SERVER_URL=$(prompt "Enter OCS server URL" "http://14.98.29.242/ocsinventory")
ADMIN_TAG=$(prompt "Enter administrative tag for this machine" "CITPL-LALA-ASUS-NUC")
LOG_PATH=$(prompt "Enter log file path" "/var/log/ocsinventory-agent.log")

sudo perl postinst.pl <<EOF
y
$CONFIG_PATH_CHOICE
y
n
$SERVER_URL
n
y
$ADMIN_TAG
y

y
n
y
y
$LOG_PATH
y
n
n
y
y
y
EOF

# Step 5: Test run
echo "[+] Testing agent execution with debug mode..."
sudo ocsinventory-agent --debug

# Step 6: Display cron job
echo "[+] Cron job content:"
cat /etc/cron.d/ocsinventory-agent || echo "Cron job not found!"

# Final message
echo "[✓] OCS Inventory Agent installation and configuration complete."
echo "Verify inventory on your OCS server dashboard using tag: $ADMIN_TAG"