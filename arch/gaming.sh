### Install Steam
#sudo pacman -Syu --noconfirm steam

### Install Lutris
#sudo pacman -Syu --noconfirm lutris

### Install Gamemode
sudo pacman -Syu --noconfirm gamemode lib32-gamemode

# Recommended Wine libraries for Lutris
# https://github.com/lutris/docs/blob/master/WineDependencies.md            
sudo pacman -Syu --noconfirm --needed giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
### wine-staging wine-gecko wine-mono


yay -S --noconfirm winetricks

### Install ProtonGE
# USE PROTONUP-QT INSTEAD
#yay -S --noconfirm proton-ge-custom-bin

# Install flatpaks
# Protontricks, ProtonUp-QT, Lutris, Steam, Wine
sudo flatpak install -y \
com.github.Matoking.protontricks \
net.davidotek.pupgui2 \
net.lutris.Lutris \ 
com.valvesoftware.Steam \
org.winehq.Wine

# Install steam controller support package - reqd for steam flatpak
sudo pacman -Syu --noconfirm steam-devices

### Install Battle.net

### Wine ???
sudo pacman -Sy
sudo pacman -S wine-staging winetricks
sudo pacman -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox

