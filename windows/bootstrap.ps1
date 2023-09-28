### Install Chocolatey
#Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

### Install Chocolatey Packages
choco install -y adobereader amd-ryzen-chipset autodesk-fusion360 cpu-z cygwin discord displaycal epicgameslauncher everything firefox git github-desktop googlechrome googledrive hwinfo icue lghub msiafterburner orcaslicer retroarch revo-uninstaller rpi-imager rufus steam superslicer tailscale vlc vscode winrar winscp wiztree

### Enable Hyper-V
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All


### Manual Downloads
# Go XLR
# Battle.NET

### CONFIG CHANGES
# goxlr app
# goxlr profile
# icue profile
# displaycal profiles
# logitech ghub settings
# turn off chat, widgets, task view, search on dock

### MINING
# Lock pages in memory
# gpedit.msc > Computer > Windows Settings > Security Settings > User Rights Assignment > Lock pages in memory
