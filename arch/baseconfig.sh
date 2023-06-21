### Enable multilib repository
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

### Enable AUR repository --- ARCH ONLY
cd ~
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xvzf yay.tar.gz
cd yay
makepkg -csi
cd ..
sudo rm -R yay
yay -Y --gendb
yay -Syu --devel

### Install Pamac --- ARCH ONLY
yay -S --noconfirm pamac-all
yes | pamac upgrade -a

### Install yay --- MANJARO ONLY
sudo pacman -Syu --noconfirm yay


### Enable SSH
systemctl enable sshd
systemctl start sshd

### Install general packages
sudo pacman -Syu --needed --noconfirm \
bash-completion \
curl \
discord \
firefox \
flatpak \
kio-gdrive \
man \
nano \
net-tools \
sudo \
vim \
vlc \
wget

### Install general flatpaks
sudo flatpak install -y \
com.usebottles.bottles \
com.google.Chrome \
com.visualstudio.code \
com.obsproject.Studio \
io.github.shiftey.Desktop

### Install gnome-keyring for GitHub Desktop
sudo pacman -Syu --noconfirm gnome-keyring

# Install 
### GoXLR App
# https://github.com/GoXLR-on-Linux/goxlr-utility
yay -S --noconfirm goxlr-utility