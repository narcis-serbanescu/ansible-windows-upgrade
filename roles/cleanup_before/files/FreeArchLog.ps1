$TimeStamp = get-date -f yyyyMMddhhmm 
# $Destination = "D:\Backup\2K8\"
$Destination = "$home\Downloads\"
If(!(test-path $Destination))
{
    New-Item -ItemType Directory -Force -Path $Destination
}                                                                                                 

Write-Host "Moving logs"  -ForegroundColor Cyan
Set-Location -Path "C:\Windows\System32\winevt\Logs" -PassThru
get-childitem Archive*zip | foreach-object {move-item $_ -destination $Destination}
#get-childitem Archive*zip | foreach-object {remove-item $_ -Force}

Write-Host "Backup network information" -ForegroundColor Cyan
netstat -R > "$Destination\netstatR_$TimeStamp.txt"
ipconfig -all > "$Destination\ipconfigAll_$TimeStamp.txt"
systeminfo > "$Destination\systemInfo_$TimeStamp.txt"
netsh interface dump > "$Destination\netsh.dat"


Write-Host "Get status of all services" -ForegroundColor Cyan
gsv | sort -Property status |ft -AutoSize > "$Destination\services_$TimeStamp.txt" 

Write-Host "Get installed programs" -ForegroundColor Cyan
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize > "$Destination\InstalledPrograms_$TimeStamp.txt" 

Write-Host "Get-WindowsFeature" -ForegroundColor Cyan
Get-WindowsFeature  > "$Destination\WinFeatures_$TimeStamp.txt"

Write-Host "Get PersistentRoutes Key" -ForegroundColor Cyan
Reg Export "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters\PersistentRoutes" $Destination\PersistentRoutes_$TimeStamp.reg

Write-Host "Get Interfaces Key" -ForegroundColor Cyan
Reg Export "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters\Interfaces" $Destination\Interfaces$TimeStamp.reg

Write-Host "Get CurrentVersion Key" -ForegroundColor Cyan
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' > "$Destination\CurrentVersion_$TimeStamp.txt"


Set-Location -Path "$home\Downloads"

