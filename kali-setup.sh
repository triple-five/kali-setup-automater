#!/bin/bash

set -e

# Load config
if [ ! -f config.sh ]; then
  echo "[!] config.sh not found. Copy templates/config.example.sh to config.sh and edit it."
  exit 1
fi
source config.sh

echo "[+] Starting Kali Setup Automator..."

# Update system
apt update -y && apt full-upgrade -y

# Create user if not exists
if id "$NEW_USER" &>/dev/null; then
  echo "[*] User $NEW_USER already exists."
else
  echo "[+] Creating new user: $NEW_USER"
  adduser --gecos "" "$NEW_USER" --disabled-password
  echo "$NEW_USER ALL=(ALL:ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$NEW_USER"
fi

# Add SSH key if provided
if [ -n "$USER_SSH_PUBKEY" ]; then
  mkdir -p /home/$NEW_USER/.ssh
  echo "$USER_SSH_PUBKEY" > /home/$NEW_USER/.ssh/authorized_keys
  chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh
  chmod 700 /home/$NEW_USER/.ssh
  chmod 600 /home/$NEW_USER/.ssh/authorized_keys
  echo "[+] Added SSH key for $NEW_USER"
fi

# Install packages
echo "[+] Installing packages..."
apt install -y "${EXTRA_PKGS[@]}"

# Install metapackages
for pkg in "${METAPACKAGES[@]}"; do
  echo "[+] Installing metapackage: $pkg"
  apt install -y "$pkg"
done

# Clone repositories
if [ "$CLONE_REPOS" = true ]; then
  mkdir -p /opt/tools
  cd /opt/tools
  for repo in "${REPOS_TO_CLONE[@]}"; do
    repo_name=$(basename "$repo" .git)
    if [ -d "$repo_name" ]; then
      echo "[*] Repo $repo_name already cloned."
    else
      git clone --depth=1 "$repo"
      echo "[+] Cloned $repo_name"
    fi
  done
  cd -
fi

# Setup firewall
if command -v ufw &>/dev/null; then
  echo "[+] Enabling ufw..."
  ufw allow OpenSSH
  ufw --force enable
else
  echo "[!] ufw not found, skipping firewall setup."
fi

echo "[✓] Kali setup completed successfully."

