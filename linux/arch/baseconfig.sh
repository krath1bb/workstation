### Enable multilib repository
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

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

# Install Yay
#sudo pacman -Syu --noconfirm yay

### Install Snapper
enable grub menu with
sudo nano /etc/default/grub

change in:
GRUB_TIMEOUT_STYLE=menu
save and close
sudo update grub

after that install following:
sudo pacman -Syu --noconfirm btrfs-assistant snapper-support snapper-tools 
#snapper
#grub-btrfs 
#snap-pac

create first snap with:
sudo snapper -c root create --description “initial snapshot”

sudo chmod a+rx /.snapshots
sudo chown :users /.snapshots

reboot and enjoy snapper
https://waylonwalker.com/setting-up-snapper-on-arch/


https://www.lorenzobettini.it/2023/03/snapper-and-grub-btrfs-in-arch-linux/
https://www.youtube.com/watch?v=_97JOyC1o2o

sudo pacman -Syu --noconfirm snappersnap-pacgrub-btrfs





### Enable SSH
systemctl enable sshd
systemctl start sshd

### Install general packages
sudo pacman -Syu --needed --noconfirm \
base-devel \
bash-completion \
curl \
flatpak \
man \
#nano \
net-tools \
#sudo \
#vim \
vlc \
#wget

#kio-gdrive \
#discord \
#firefox \

### Install general flatpaks
# Bottles, Chrome, Discord, VS Code, OBS, GitHub Desktop
sudo flatpak install -y \
com.usebottles.bottles \
com.google.Chrome \
com.discordapp.Discord \
com.visualstudio.code \
com.obsproject.Studio \
io.github.shiftey.Desktop

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

# Install 
### GoXLR App
