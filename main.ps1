# Before running the script, run Windows PowerShell as admin and enter: 
# Set-ExecutionPolicy Unrestricted

$currentUser = $env:USERNAME 
$downloadLinks = @(
    "https://ninite.com/chrome-discord-spotify-steam-vlc-vscode-winrar/ninite.exe",
    "https://files.modecom.com/files/klawiatury/Volcano_Gamer_96_BT/Software/volcano_gamer_96_BT_software_V1.0.5_20220919.zip",
    "https://uk.download.nvidia.com/GFE/GFEClient/3.27.0.112/GeForce_Experience_v3.27.0.112.exe",
    "https://dlcdnets.asus.com/pub/ASUS/mb/14Utilities/ArmouryCrateInstallTool.zip",
    "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi",
    "https://protonvpn.com/download/ProtonVPN_v3.2.10.exe"
)

function Download-Files {
    param (
        [string[]]$Links
    )
    
    Set-Variable ProgressPreference SilentlyContinue

    foreach ($link in $Links) {
        try {
            $filePath = "C:\Users\$currentUser\Downloads\$([System.IO.Path]::GetFileName($link))"
            Write-Output "Downloading file from: $link" 
            Write-Output "Saving to: $filePath"
            Invoke-WebRequest -UseBasicParsing -Uri $link -OutFile $filePath -ErrorAction Stop
            Start-Process $filePath
        }
        catch {
            Write-Warning "Error downloading $link: $_"
        }
    }

    Write-Output "Downloading https://christitus.com/win: $_"
    try {
        Invoke-WebRequest -UseBasicParsing "https://christitus.com/win" | Invoke-Expression -ErrorAction Stop
    }
    catch {
        Write-Warning "Error downloading https://christitus.com/win..."
    }
}

Write-Output "Removing Appx..."
$packagesToRemove = Get-AppxPackage | Where-Object {
    $_.Name -notlike "*Store*" -and 
    $_.Name -notlike "*Microsoft.ScreenSketch*" -and
    $_.Name -notlike "*WindowsCalculator*" -and
    $_.Name -notlike "*WindowsCamera*" -and
    $_.Name -notlike "*WindowsNotepad*" -and
    $_.Name -notlike "*Microsoft.Paint*" -and
    $_.Name -notlike "*Clipchamp.Clipchamp*" -and
    $_.Name -notlike "*Microsoft.Windows.Photos*" -and
    $_.Name -notlike "*Microsoft.WindowsAlarms*" -and
    $_.Name -notlike "*NVIDIA*" -and
    $_.Name -notlike "*.NET*" -and
    $_.Name -notlike "*Realtek*" -and
    $_.Name -notlike "*Xbox*" -and
    $_.Name -notlike "*BingWeather*" -and
    $_.Name -notlike "*MicrosoftStickyNotes*" -and
    $_.Name -notlike "*Microsoft.Todos*" -and
    $_.Name -notlike "*WindowsSoundRecorder*" -and
    $_.Name -notlike "*DTSInc.*"
    # Add more conditions if needed  
}

if ($packagesToRemove) {
    $packagesToRemove | Remove-AppxPackage
}
else {
    Write-Output "No packages found to remove."
}

Write-Output "Downloading software's .exe files..."
Download-Files -Links $downloadLinks

Set-ExecutionPolicy Restricted

Write-Output "Script finished."
