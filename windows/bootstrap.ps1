### Install Chocolatey
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))



### Install Base Chocolatey Packages
choco install -y adobereader bambustudio brave cpu-z cygwin displaycal everything googledrive hwinfo orcaslicer revo-uninstaller rpi-imager rufus tailscale vlc vscode winrar winscp wiztree
# git github-desktop retroarch

### Misc Chocolatey Packages
#choco install -y icue lghub msiafterburner

###  CAD Chocolatey Packages
#choco install -y autodesk-fusion360

### Install Gaming Chocolatey Packages
# choco install -y discord epicgameslauncher steam

### Install Ryzen Chocolatey Packages
# choco install -y amd-ryzen-chipset



### Debloat
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Get-ChildItem -Recurse *.ps1 | Unblock-File
powershell.exe -ExecutionPolicy ByPass -File .\sos-optimize-windows.ps1 -cleargpos:$false -installupdates:$false -removebloatware:$true -disabletelemetry:$true -privacy:$true -imagecleanup:$true -diskcompression:$false -updatemanagement:$true -sosbrowsers:$true   



### Enable Hyper-V
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

### Disable Password Expiration Windows 11
wmic UserAccount set PasswordExpires=False



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
