# Boot to SteamOS Desktop
steamos-session-select plasma-x11-persistent

### Add Chaotic AUR repository
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo tee -a /etc/pacman.conf > /dev/null <<EOT

# Additional Repos
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOT

### Install package manager
git clone https://aur.archlinux.org/bauh.git
cd bauh
makepkg -si ./bauh
cd ~
rm -rf bauh

### Install general packages
sudo pacman -Syu --needed --noconfirm \
flatpak \
goxlr-utility \
bauh

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
org.winehq.Wine

