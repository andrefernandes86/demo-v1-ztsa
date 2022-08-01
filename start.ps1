Set-MpPreference -DisableRealtimeMonitoring $true -DisableScriptScanning $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableIntrusionPreventionSystem $true
Set-ExecutionPolicy Unrestricted -Force
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
Invoke-WebRequest 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile c:\chrome.exe
Invoke-Expression "c:\chrome.exe /silent /install"
New-Item -Path c:\users\administrator\desktop -Name "networkshare.ps1" -ItemType "file" -Value "net use T: \\10.0.3.20\ztsa /u:administrator"
Invoke-WebRequest 'https://raw.githubusercontent.com/andrefernandes86/demo-v1-ztsa/main/10.0.3.20.rdp' -OutFile c:\users\administrator\desktop\10.0.3.20.rdp
Invoke-WebRequest 'https://raw.githubusercontent.com/andrefernandes86/demo-v1-ztsa/main/bookmarks.html' -OutFile c:\users\administrator\desktop\bookmarks.html
