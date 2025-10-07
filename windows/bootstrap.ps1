### Install Chocolatey
Set-ExecutionPolicy Bypass -Scope CurrentUser -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))



### Install Base Chocolatey Packages
choco install -y adobereader autodesk-fusion360 bambustudio brave cpu-z cygwin everything googledrive hwinfo orcaslicer revo-uninstaller rpi-imager rufus tailscale vlc vscode winrar winscp wiztree
# git github-desktop retroarch

### Misc Chocolatey Packages
#choco install -y icue lghub msiafterburner displaycal

### Install Gaming Chocolatey Packages
# choco install -y discord epicgameslauncher steam

### Install Ryzen Chocolatey Packages
# choco install -y amd-ryzen-chipset



### Enable Hyper-V
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All



### Classic Context Menu
# Create the key and set empty default value
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# Restart File Explorer to apply
Stop-Process -Name explorer -Force



### Disable Password Expiration Windows 11
Get-LocalUser | Where-Object { -not $_.PasswordNeverExpires } |
  Set-LocalUser -PasswordNeverExpires $true



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


################
# Win11 Debloat
################

# Require elevation
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) { throw "Run elevated." }

# Target Appx (Store) apps – add/remove to taste
$Targets = @(
  'Clipchamp.Clipchamp','Microsoft.WindowsFeedbackHub','Microsoft.BingNews','Microsoft.Windows.Photos',
  'Microsoft.MicrosoftSolitaireCollection','Microsoft.MicrosoftStickyNotes','MicrosoftTeams','MSTeams',
  'Microsoft.Todos','Microsoft.BingWeather','Microsoft.OutlookForWindows','Microsoft.Paint',
  'MicrosoftCorporationII.QuickAssist','Microsoft.SnippingTool','Microsoft.ScreenSketch',
  'Microsoft.WindowsCalculator','Microsoft.WindowsCamera','Microsoft.ZuneMusic','Microsoft.ZuneVideo',
  'Microsoft.WindowsMediaPlayer','Microsoft.WindowsSoundRecorder','Microsoft.SoundRecorder',
  'Microsoft.WindowsTerminal','Microsoft.XboxApp','Microsoft.XboxGamingOverlay',
  'Microsoft.XboxIdentityProvider','Microsoft.XboxSpeechToTextOverlay','Microsoft.Xbox.TCUI',
  'Microsoft.GetHelp','Microsoft.Getstarted','Microsoft.YourPhone','Microsoft.LinkedIn','Microsoft.LinkedInBeta'
)

Write-Host "Removing selected Appx packages for existing users..." 

# Uninstall per-user instances (best effort)
Get-AppxPackage -AllUsers |
  Where-Object { $Targets -contains $_.Name } |
  ForEach-Object {
    try {
      Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop
    } catch { }
  }

Write-Host "De-provisioning selected Appx packages from the image..."

# Remove from provisioning so they do not install for future profiles
Get-AppxProvisionedPackage -Online |
  Where-Object {
    # Match by DisplayName or by prefix of PackageName to be resilient across builds
    $Targets -contains $_.DisplayName -or $Targets | ForEach-Object { $_ } | Where-Object { $_ -and $_ -ne '' -and $_ -like "$($_)*" } | Measure-Object -Sum | Select-Object -ExpandProperty Sum
  } |
  ForEach-Object {
    try {
      Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction Stop | Out-Null
    } catch { }
  }

#######################
# Remove OneDrive (Win32)
#######################

# Try winget (quiet)
try { winget uninstall --id Microsoft.OneDrive -e --silent 2>$null } catch { }

# Fallback: built-in uninstaller
$exe = if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
    "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
} elseif (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
    "$env:SystemRoot\System32\OneDriveSetup.exe"
} else { $null }

if ($exe) {
  try { Start-Process $exe '/uninstall' -Wait -WindowStyle Hidden } catch { }
}

# Clean common leftovers (best effort)
$paths = @(
  "$env:LOCALAPPDATA\Microsoft\OneDrive",
  "$env:ProgramData\Microsoft OneDrive",
  "$env:SystemDrive\OneDriveTemp"
)
foreach ($p in $paths) {
  try { if (Test-Path $p) { Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue } } catch { }
}

Write-Host "Debloat completed."

