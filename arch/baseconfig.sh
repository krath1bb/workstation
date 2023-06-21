### Enable multilib repository
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

### Enable AUR repository
sudo pacman -Syu --noconfirm --needed base-devel git
cd ~
git clone https://aur.archlinux.org/yay.git
cd ~/yay/
makepkg -si --noconfirm
cd ..
sudo rm -rf /yay/
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
com.visualstudio.code