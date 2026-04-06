#!/bin/bash 

#----------------------------------------------
#Server provisioning script
#Author:Angus Egbekobar

set -e  # Exit immediately if any command fails

# --- Colours for output ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Colour

log() { echo -e "${GREEN}[INFO]${NC} $1";}
warn() { echo -e "${YELLOW}[WARN]${NC}  $1" ;}
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; } 


# --- Check if  script is run as root ---
if [[ $EUID -ne 0 ]]; then
   error "This script must be run as a root .  Use: sudo ./provision_server.sh"
fi

log " Starting server provisioning "

# --- 1. Update the system ---
log "Updating system packages ..."
apt-get update -y &&  apt-get upgrade -y


#-- 2. install essential packages ---
log "installing  essential packages ..."
apt-get  install -y \
   curl \
   wget \
   git \
    ufw \
    htop \
    unzip \
  fail2ban

# --- 3. Create a deploy user ---
USERNAME="devops"
log "Creating user: $USERNAME"

if id "$USERNAME" &>/dev/null;

then
    warn "user $USERNAME already exists. Skipping "
else
    useradd -m -s /bin/bash "$USERNAME"
    usermod -aG sudo "$USERNAME"
    log "user $USERNAME created and added to sudo group "
fi

# --- 4. Set up firewall ---
log "Configuring firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
log "Firewall enabled."



# --- 5. Harden SSH ---
log "Hardening SSH..."
SSHD="/etc/ssh/sshd_config"

if [[ -f "$SSHD" ]]; then
  sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' "$SSHD"
  sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' "$SSHD"
  sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD"
  sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD"
  log "SSH hardened."
else
  warn "sshd_config not found. Skipping SSH hardening (not applicable on WSL)."
fi

# -- Enable fail2ban ---
log "Enabling fail2ban (protects against brute force) ..."
systemctl enable fail2ban
systemctl start fail2ban


# --- 7. Fix home directory permissions ---
log "Fixing home directory permissions..."
chmod 750 /home/"$USERNAME"

log "================================================"
log " Provisioning complete!"
log " User created:  $USERNAME"
log " Firewall:      active (ports 22, 80, 443)"
log " SSH:           hardened"
log " fail2ban:      running"
log "================================================"
