# Set theme?

# Remove bloat
# Apps
sudo pacman -R boxtron dosbox kde-games-meta mumble oversteer alsa-oss faudio lib32-alsa-oss lib32-colord lib32-faudio  lib32-fluidsynth lib32-glib-networking lib32-gst-plugins-base-libs lib32-gstreamer lib32-gtk3 lib32-lcms2 lib32-libepoxy lib32-libgudev  lib32-libinstpatch lib32-libproxy lib32-librsvg lib32-libsoup lib32-libvpx lib32-libxslt lib32-libxv lib32-lzo lib32-orc lib32-portaudio lib32-readline lib32-v4l-utils lib32-vkd3d python-vdf vkd3d wine-gecko wine-installer wine-mono wine-nine wineasio proton-ge-custom protontricks-git wine-meta winetricks obs-studio discord mumble poco mariadb-libs libspeechd keyboard-visualizer-git oversteer python-xdg python-scipy python-pooch python-appdirs python-pyudev python-matplotlib qhull python-pyparsing python-kiwisolver python-fonttools python-dateutil python-cycler python-contourpy appstream-glib bottles vkbasalt-cli python-steamgriddb python-pycurl python-pathvalidate python-markdown patool libportal-gtk4 libportal libhandy icoextract python-pefile python-future gtksourceview5 fvs python-orjson lutris python-yaml gnome-desktop gnome-desktop-common cabextract minigalaxy steam-native-runtime sdl2_ttf libvpx1.3 libtiff4 librtmp0 libpng12 libjpeg6-turbo libidn11 libibus libgcrypt15 libcurl-gnutls libcurl-compat lib32-sdl_ttf sdl_ttf lib32-sdl_mixer lib32-libmikmod sdl_mixer lib32-sdl_image sdl_image lib32-sdl2_ttf lib32-sdl2_mixer lib32-mpg123 lib32-libmodplug sdl2_mixer opusfile lib32-sdl2_image lib32-libwebp lib32-sdl12-compat lib32-sdl2 lib32-openssl-1.1 openssl-1.1 lib32-openal lib32-libvpx1.3 lib32-libvdpau lib32-libudev0-shim libudev0-shim lib32-libtiff4 lib32-libtheora lib32-librtmp0 lib32-libpng12 lib32-libnm lib32-libjpeg6-turbo lib32-libidn11 lib32-libgcrypt15 lib32-libcurl-gnutls lib32-libcurl-compat lib32-libcanberra lib32-tdb lib32-libltdl lib32-libpulse lib32-libsndfile lib32-flac lib32-libvorbis lib32-libogg lib32-libasyncns lib32-libcaca lib32-imlib2 lib32-giflib lib32-libappindicator-gtk2 lib32-libindicator-gtk2 libindicator-gtk2 lib32-libdbusmenu-gtk2 libdbusmenu-gtk2 lib32-libdbusmenu-glib lib32-gtk2 lib32-libxinerama lib32-libxcomposite lib32-libcups lib32-gnutls lib32-nettle lib32-gmp lib32-glew1.10 lib32-gdk-pixbuf2 lib32-libtiff lib32-libjpeg-turbo lib32-dbus-glib lib32-at-spi2-core lib32-libxtst gtk2 glew1.10 steam zenity lsof lib32-nss lib32-sqlite lib32-p11-kit lib32-libtasn1 lib32-nspr lib32-libxss lib32-alsa-plugins alsa-plugins heroic-games-launcher-bin

# Games
sudo pacman -R black-hole-solver bomber bovo chromium-bsu freecell-solver gnuchess granatier kajongg kapman katomic kblackbox kblocks kbounce kbreakout kdiamond kfourinline kgoldrunner kigo killbots kjumpingcube klickety klines kmines knetwalk knights kollision kolf konquest kpat kreversi kshisen ksirk ksnakeduel kspaceduel ksquares ksudoku kubrick lskat mari0 minetest palapeli picmi teeworlds

# Flatpak replacements
obs-studio
discord
wine
winetricks
proton-ge-custom
protontricks

### Install general packages
sudo pacman -Syu --needed --noconfirm \
flatpak \
goxlr-utility \
game-devices-udev \
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
com.valvesoftware.Steam \
org.winehq.Wine