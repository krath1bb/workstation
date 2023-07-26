### Add Chaotic AUR repository
#sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
#sudo pacman-key --lsign-key 3056513887B78AEB
#sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
#sudo tee -a /etc/pacman.conf > /dev/null <<EOT

# Additional Repos
#[chaotic-aur]
#Include = /etc/pacman.d/chaotic-mirrorlist
#EOT

### Install Snapper
# snapper-support = snapper, grub-btrfs, snap-pac
# snapper-gui
sudo pacman -Syu --noconfirm snapper-support btrfs-assistant inotify-tools snapper-gui
sudo umount /.snapshots
sudo rm -r /.snapshots/
# Create Snapper config files
sudo snapper -c root create-config /
sudo snapper -c home create-config /home
sudo snapper -c var create-config /var
#sudo snapper -c data create-config /data
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots; sudo mount -a
# Validate root @ ID is 256
# btrfs subvol list /
sudo btrfs subvolume set-default 256 /

### Configure Snapper
sudo sed -i 's:ALLOW_GROUPS="":ALLOW_GROUPS="wheel":g' /etc/snapper/configs/*
sudo sed -i 's:TIMELINE_LIMIT_HOURLY="10":TIMELINE_LIMIT_HOURLY="5":g' /etc/snapper/configs/*
sudo sed -i 's:TIMELINE_LIMIT_DAILY="10":TIMELINE_LIMIT_DAUKT="7":g' /etc/snapper/configs/*
sudo sed -i 's:TIMELINE_LIMIT_MONTHLY="10":TIMELINE_LIMIT_MONTHLY="0":g' /etc/snapper/configs/*
sudo sed -i 's:TIMELINE_LIMIT_YEARLY="10":TIMELINE_LIMIT_YEARLY="0":g' /etc/snapper/configs/*
sudo chown -R :wheel /.snapshots/
sudo chown -R :wheel /home/.snapshots/
sudo chown -R :wheel /var/.snapshots/
sudo chown -R :wheel /data/.snapshots/

# Enable snapshot cleanups
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer

# Base OS snapshot
sudo snapper -c root create -d "***Base System Configuration***"
sudo snapper -c home create -d "***Base System Configuration***"
sudo snapper -c var create -d "***Base System Configuration***"

# Add snpshots to Grub
sudo systemctl enable --now grub-btrfsd.service
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Manual Snapshot 
# sudo snapper -c root create -d "***Base System Configuration***"
# 
# List Snapshots
# sudo snapper ls
# 
# Compare Snapshots
# sudo snapper status #..#      where # = snapshot ID 
#
# Undo change
# sudo snapper undochange #..#      where # = snapshot IDs
#
# Delete Snapshots
# sudo snapper delete #
#
# Set rollback snapshot
# sudo snapper --ambit classic rollback #       where # = snapshot ID
# Initial snapshot

### Enable SSH
sudo systemctl enable --now sshd

### Install general packages
sudo pacman -Syu --needed --noconfirm \
game-devices-udev \
flatpak \
goxlr-utility \
pamac-all \
vim
#kio-gdrive


### Install general flatpaks
# Chrome, Discord, GitHub Desktop, VS Code, Protontricks, Protonup-QT, Lutris, Wine
sudo flatpak install -y \
com.google.Chrome \
com.discordapp.Discord \
io.github.shiftey.Desktop \
com.visualstudio.code \
com.github.Matoking.protontricks \
net.davidotek.pupgui2 \
net.lutris.Lutris \
com.valvesoftware.Steam \
org.winehq.Wine

# Configure Steam data directory
flatpak override --user com.valvesoftware.Steam --filesystem=/data/Games

# Autostart Steam
mkdir ~/.config/autostart
cp -L "/var/lib/flatpak/exports/share/applications/com.valvesoftware.Steam.desktop" ~/.config/autostart/
sudo sed -i 's:@@u %U @@:-silent:g' ~/.config/autostart/com.valvesoftware.Steam.desktop

# Autostart GoXLR
tee -a ~/.config/autostart/goxlr-daemon.desktop > /dev/null <<EOT
[Desktop Entry]
Type=Application
Name=GoXLR Utility
Comment=A Tool for Configuring a GoXLR
Path=/usr/bin
Exec=/usr/bin/goxlr-daemon
Terminal=false
EOT

### Audio Setup
#sudo pacman -Syu --noconfirm manjaro-pipewire
#sudo flatpak install -y org.pipewire.Helvum
#sudo pacman -Syu --noconfirm qpwgraph
# GoXLR 
# https://github.com/GoXLR-on-Linux/goxlr-utility
# GoXLR Profile Directory
# ~/.local/share/goxlr-utility
#yay -S --noconfirm goxlr-utility

### Install gnome-keyring for GitHub Desktop
#sudo pacman -Syu --noconfirm gnome-keyring



#TODO:
#Install lutris-ge-proton from protonup-qt
#Install ge-proton for steam from protonup-qt
#Pamac - Enable AUR
#Enable flatpaks in pamac
#patchbay pipewire