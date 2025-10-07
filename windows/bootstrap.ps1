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



##################
### POWERSHELL ###
##################

# Classic Context Menu (per user)
# Create the key and set empty default value
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# Disable Password Expiration (local accounts)
# Requires elevation; safely skipped if not admin. Has no effect on AAD/Domain policy-managed accounts.
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($IsAdmin) {
    Get-LocalUser |
      Where-Object { $_.Enabled -and -not $_.PasswordNeverExpires } |
      ForEach-Object { Set-LocalUser -Name $_.Name -PasswordNeverExpires $true }
}

# Taskbar: left align + hide Widgets (per user)
$adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
New-Item -Path $adv -Force | Out-Null
New-ItemProperty -Path $adv -Name 'TaskbarAl' -PropertyType DWord -Value 0 -Force | Out-Null  # 0=left, 1=center
New-ItemProperty -Path $adv -Name 'TaskbarDa' -PropertyType DWord -Value 0 -Force | Out-Null  # 0=hidden

# Apply changes (restart Explorer once)
try { Stop-Process -Name explorer -Force } catch { }



#####################
### Win11 Debloat ###
#####################

# Require elevation
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) { exit 1 }

# Reduce noise, keep going on failures
$ProgressPreference = 'SilentlyContinue'

# Target Appx (Store) apps – adjust as needed
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

# --- Remove for existing users (no prompts)
try {
  Get-AppxPackage -AllUsers |
    Where-Object { $Targets -contains $_.Name } |
    ForEach-Object {
      try { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop } catch { }
    }
} catch { }

# --- De-provision so future profiles don't get them (no prompts)
try {
  $prov = Get-AppxProvisionedPackage -Online
  if ($prov) {
    # Match by DisplayName or by IdentityName prefix in PackageName
    $prov |
      Where-Object {
        $Targets -contains $_.DisplayName -or
        ($Targets | Where-Object { $_ -and $_ -ne '' -and $_ -like ($_.PackageName.Split('_')[0] + '*') }).Count -gt 0
      } |
      ForEach-Object {
        try { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction Stop | Out-Null } catch { }
      }
  }
} catch { }

# --- OneDrive (Win32) uninstall (unattended)
# 1) Try Winget silently with agreement flags
$winget = Get-Command winget -ErrorAction SilentlyContinue
if ($winget) {
  try { winget uninstall --id Microsoft.OneDrive -e --silent --accept-source-agreements 2>$null } catch { }
}

# 2) Fallback to built-in uninstaller (silent)
$exe = if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
    "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
} elseif (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
    "$env:SystemRoot\System32\OneDriveSetup.exe"
} else { $null }

if ($exe) {
  try { Start-Process $exe '/uninstall' -Wait -WindowStyle Hidden } catch { }
}

# 3) Clean common leftovers (best effort)
$paths = @(
  "$env:LOCALAPPDATA\Microsoft\OneDrive",
  "$env:ProgramData\Microsoft OneDrive",
  "$env:SystemDrive\OneDriveTemp"
)
foreach ($p in $paths) {
  try { if (Test-Path $p) { Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue } } catch { }
}

# Optional: return nonzero on catastrophic failure only
exit 0
