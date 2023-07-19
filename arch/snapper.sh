### remove subvolid= from /etc/fstab
# this causes issues when mounting a snapshot
# ARCH ONLY
sudo sed -i 's/subvolid=.*,//' /etc/fstab

### Install Pamac from Chaotic AUR
# Add Chaotic AUR Repo
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo tee -a /etc/pacman.conf > /dev/null <<EOT

# Additional Repos
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOT
# Install Pamac
sudo pacman -Syu --noconfirm pamac-aur

### Install Snapper packages
sudo pacman -Syu --noconfirm snapper-support btrfs-assistant