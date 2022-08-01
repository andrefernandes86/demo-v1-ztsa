function DisplayMenu {
Clear-Host
Write-Host @"
+===============================================+
|  POWERSHELL CONSOLE - USER MENU               | 
+===============================================+
|                                               |
|    1) Disable Microsoft Security Controls     |
|    2) Install Google Chrome                   |
|    3) Download RDP/Bookmarks                  |
|    4) Connect to a Network Share              |
|    5) EXIT                                    |
+===============================================+

"@

$MENU = Read-Host "OPTION"
Switch ($MENU)
{
1 {
#OPTION1
Set-MpPreference -DisableRealtimeMonitoring $true -DisableScriptScanning $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableIntrusionPreventionSystem $true
Set-ExecutionPolicy Unrestricted -Force
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
DisplayMenu
}
2 {
#OPTION2
Invoke-WebRequest 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile c:\chrome.exe
Invoke-Expression "c:\chrome.exe /silent /install"
Start-Sleep -Seconds 2
DisplayMenu
}
3 {
#OPTION3
Invoke-WebRequest 'https://raw.githubusercontent.com/andrefernandes86/demo-v1-ztsa/main/10.0.3.20.rdp' -OutFile c:\users\administrator\desktop\10.0.3.20.rdp
Invoke-WebRequest 'https://raw.githubusercontent.com/andrefernandes86/demo-v1-ztsa/main/bookmarks.html' -OutFile c:\users\administrator\desktop\bookmarks.html
Break
}
4 {
#OPTION4
New-Item -Path c:\users\administrator\desktop -Name "networkshare.ps1" -ItemType "file" -Value "net use T: \\10.0.3.20\ztsa /u:trendmicro Trend@ztsa1!"
Start-Sleep -Seconds 2
DisplayMenu
}
5 {
#OPTION5
Write-Host "Bye"
Break
}
default {
#DEFAULT OPTION
Write-Host "Option not available"
Start-Sleep -Seconds 2
DisplayMenu
}
}
}
DisplayMenu
