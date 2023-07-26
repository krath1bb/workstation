### Pacman
# Enable AUR
# Enable Flatpak
# Refresh Databases

### Install general packages
sudo pacman -Syu --needed --noconfirm 
goxlr-utility \
game-devices-udev \
gnome-keyring

### Install general flatpaks
# Chrome, Discord, GitHub Desktop, VS Code, Protontricks, Protonup-QT, Lutris, Wine
sudo flatpak install -y \
com.google.Chrome \
com.discordapp.Discord \
com.visualstudio.code \
com.github.Matoking.protontricks \
net.davidotek.pupgui2 \
net.lutris.Lutris \
com.valvesoftware.Steam \
org.winehq.Wine

# Configure Flatpak data directory
flatpak override --user com.valvesoftware.Steam --filesystem=/data
flatpak override --user com.lutris.Lutris --filesystem=/data

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

goverlay-git
github-desktop-bin
