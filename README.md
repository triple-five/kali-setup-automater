# Kali Setup Automator

Automates post-install configuration of Kali Linux:
- Create non-root sudo user
- Install metapackages and tools
- Clone common security repositories
- Basic firewall setup (ufw)

## How to use
1. Download this repo as a ZIP or clone it.
2. Copy the template:
   ```bash
   cp templates/config.example.sh config.sh

## What This Project Does

This Bash-based **Kali Linux Setup Automator** performs full post-install automation on a fresh Kali system.  
It creates a proper non-root user, installs selected pentesting toolkits, clones important red-team repositories, and locks basic security settings.

### It will do:
- Update and upgrade your system.
- Create a non-root user with sudo privileges.
- Install Kali’s essential toolkits (configurable metapackages).
- Install and enable UFW firewall (SSH allowed, others denied).
- Clone common security repositories into `/opt` (e.g., SecLists, PayloadsAllTheThings).
- Decompress common wordlists (like `rockyou.txt`).
- Apply basic system-hardening via `/etc/sysctl.d`.
- Enable Docker if it’s installed and add the user to the docker group.

### It will install (examples):
- **Core tools:** `git`, `curl`, `wget`, `nano`, `zsh`, `tmux`, `htop`, `python3-pip`, `net-tools`, `ufw`
- **Kali metapackages:** `kali-linux-top10` (adjustable in `config.sh`)
- **Pentesting utilities (from metas):** `nmap`, `hydra`, `john`, `sqlmap`, `gobuster`, `dirsearch`, `wireshark`, etc.
- **Wordlists:** `/usr/share/wordlists/rockyou.txt`, `seclists`
- **Git repos (example):**
  - `https://github.com/danielmiessler/SecLists`
  - `https://github.com/swisskyrepo/PayloadsAllTheThings`

Result: after running the script with a configured `config.sh`, you get a preconfigured Kali environment tailored for pentesting and red-team work.
