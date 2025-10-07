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


###############
### DEBLOAT ###
###############

# --- Win11 25H2: Built-in Debloat (official policy) --------------------------
# Requires elevation. Affects NEW user profiles created after this is applied.
# Policy key: HKLM\SOFTWARE\Policies\Microsoft\Windows\Appx\RemoveDefaultMicrosoftStorePackages

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) { throw "Run elevated." }

$PolicyRoot = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Appx\RemoveDefaultMicrosoftStorePackages'

# Curated inbox apps (adjust as needed)
$Targets = @(
  'Clipchamp.Clipchamp',
  'Microsoft.WindowsFeedbackHub',
  'Microsoft.BingNews',
  'Microsoft.Windows.Photos',
  'Microsoft.MicrosoftSolitaireCollection',
  'Microsoft.MicrosoftStickyNotes',
  'MicrosoftTeams','MSTeams',
  'Microsoft.Todos',
  'Microsoft.BingWeather',
  'Microsoft.OutlookForWindows',
  'Microsoft.Paint',
  'MicrosoftCorporationII.QuickAssist',
  'Microsoft.SnippingTool','Microsoft.ScreenSketch',
  'Microsoft.WindowsCalculator',
  'Microsoft.WindowsCamera',
  'Microsoft.ZuneMusic','Microsoft.ZuneVideo','Microsoft.WindowsMediaPlayer',
  'Microsoft.WindowsSoundRecorder','Microsoft.SoundRecorder',
  'Microsoft.WindowsTerminal',
  'Microsoft.XboxApp','Microsoft.XboxGamingOverlay',
  'Microsoft.XboxIdentityProvider','Microsoft.XboxSpeechToTextOverlay','Microsoft.Xbox.TCUI'
)

# Resolve PFNs from installed/provisioned packages
$installed = Get-AppxPackage -AllUsers 2>$null
$prov      = Get-AppxProvisionedPackage -Online 2>$null

# FIX: use a pipeline (ForEach-Object) instead of piping from a foreach statement
$pfns = $Targets | Select-Object -Unique | ForEach-Object {
  $name = $_
  ($installed | Where-Object { $_.Name -eq $name -or $_.Name -like "$name*" } |
    Select-Object -First 1).PackageFamilyName
} | Where-Object { $_ } | Sort-Object -Unique

# Fallback: try to infer PFNs from provisioned entries where not already resolved
if ($prov) {
  $need = $Targets | Where-Object { $pfns -notcontains $_ }
  foreach ($name in $need) {
    $hit = $prov | Where-Object { $_.DisplayName -eq $name -or $_.PackageName -like "$name*" } | Select-Object -First 1
    if ($hit) {
      $p = ($installed | Where-Object { $_.Name -like "$name*" } | Select-Object -First 1).PackageFamilyName
      if ($p) { $pfns += $p }
    }
  }
  $pfns = $pfns | Sort-Object -Unique
}

# Write policy: one empty subkey per PFN
if ($pfns -and $pfns.Count) {
  New-Item -Path $PolicyRoot -Force | Out-Null
  foreach ($pfn in $pfns) {
    New-Item -Path (Join-Path $PolicyRoot $pfn) -Force | Out-Null
  }
}
# Optional revert:
# Remove-Item -Path $PolicyRoot -Recurse -Force
# ---------------------------------------------------------------------------
