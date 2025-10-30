# copy to config.sh and edit before running
NEW_USER="pentest"
USER_SSH_PUBKEY=""
METAPACKAGES=(kali-linux-top10)
EXTRA_PKGS=(git zsh tmux htop ufw docker.io jq)
AUTO_YES=false
CLONE_REPOS=true
REPOS_TO_CLONE=(
  "https://github.com/danielmiessler/SecLists.git"
  "https://github.com/swisskyrepo/PayloadsAllTheThings.git"
)
