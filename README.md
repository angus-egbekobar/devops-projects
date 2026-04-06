# DevOps Projects

A collection of DevOps scripts and infrastructure projects built while 
transitioning into a DevOps engineering role.

## Projects

### 1. Server Provisioning Script
A Bash script that automates the setup and hardening of a fresh Ubuntu server.

**What it does:**
- Updates and upgrades all system packages
- Installs essential tools (git, curl, ufw, fail2ban, htop)
- Creates a dedicated devops user with sudo access
- Configures UFW firewall (ports 22, 80, 443)
- Hardens SSH configuration
- Enables fail2ban for brute force protection

**Usage:**
```bash
sudo ./provision_server.sh
```

## Skills Demonstrated
- Bash scripting
- Linux system administration
- Server hardening
- Security best practices

## Author
Angus Egbekobar | AWS Certified Solutions Architect
