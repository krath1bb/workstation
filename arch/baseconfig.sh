### Enable multilib repository
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

### Enable AUR repository
cd ~
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xvzf yay.tar.gz
cd yay
makepkg -csi
cd ..
sudo rm -R yay
yay -Y --gendb
yay -Syu --devel

### Install Pamac
yay -S --noconfirm pamac-all
yes | pamac upgrade -a

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
com.obsproject.Studio

### GoXLR App
# https://github.com/GoXLR-on-Linux/goxlr-utility