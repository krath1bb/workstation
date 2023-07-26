### Modify BTRFS disk layout
# rename /var/cache to /.snapshots
# rename /@cache to /@snapshots
# rename /var/log to /var
# rename /@log to /@var
sudo sed -i 's:/var/cache:/.snapshots:g' /etc/calamares/modules/mount.conf
sudo sed -i 's:/@cache:/@snapshots:g' /etc/calamares/modules/mount.conf
sudo sed -i 's:/var/log:/var:g' /etc/calamares/modules/mount.conf
sudo sed -i 's:/@log:/@var:g' /etc/calamares/modules/mount.conf

ADD DATA DIR


