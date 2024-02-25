$currentUser = $env:USERNAME 

$downloadLinks = @(
    "https://ninite.com/chrome-discord-spotify-steam-vlc-vscode-winrar/ninite.exe",
    "https://files.modecom.com/files/klawiatury/Volcano_Gamer_96_BT/Software/volcano_gamer_96_BT_software_V1.0.5_20220919.zip",
    "https://uk.download.nvidia.com/GFE/GFEClient/3.27.0.112/GeForce_Experience_v3.27.0.112.exe",
    "https://dlcdnets.asus.com/pub/ASUS/mb/14Utilities/ArmouryCrateInstallTool.zip",
    "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi"
)

Write-Host "Downloading software's .exe files..."

for ($i = 0; $i -lt $downloadLinks.Count; $i++) {
    try {
        $filePath = "C:\Users\$currentUser\Downloads\$([System.IO.Path]::GetFileName($downloadLinks[$i]))"
        Write-Host "Downloading file from: $($downloadLinks[$i])" ; Write-Host "Saving to: $($filePath)"
        Set-Variable ProgressPreference SilentlyContinue 
        Invoke-WebRequest -UseBasicParsing -Uri $downloadLinks[$i] -OutFile $filePath
        Start-Process $filePath
    }
    catch {
        Write-Warning "Error downloading $($downloadLinks[$i])..."
    }
}

Write-Host "Downloading https://christitus.com/win..."

try {
    Invoke-WebRequest -UseBasicParsing "https://christitus.com/win" | Invoke-Expression
}
catch {
    Write-Warning "Error downloading christitus.com/win..."
}

Write-Host "Removing Appx..."

Get-AppxPackage | Where-Object {
    $_.Name -notlike "*store*" -and 
    $_.Name -notlike "*ScreenSketch*" -and
    $_.Name -notlike "*WindowsCalculator*" 
    # To add...
} | Remove-AppxPackage

Write-Host "Script finished."
