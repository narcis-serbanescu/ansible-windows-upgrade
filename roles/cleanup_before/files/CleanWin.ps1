Write-Host Simple Cleanup of windows\temp, appdata\local\temp, windows\Prefetch and system32\winevt\logs -ForegroundColor Green -BackgroundColor Blue
$spatiu = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq "3" } | Select-Object SystemName, 
@{ Name = "Drive" ; Expression = { ( $_.DeviceID ) } }, 
@{ Name = "Size (GB)" ; Expression = {"{0:N1}" -f( $_.Size / 1gb)}}, 
@{ Name = "FreeSpace (GB)" ; Expression = {"{0:N1}" -f( $_.Freespace / 1gb ) } }, 
@{ Name = "PercentFree" ; Expression = {"{0:P1}" -f( $_.FreeSpace / $_.Size ) } } | 
Format-Table -AutoSize | Out-String 

    Write-Host Before  -ForegroundColor Red  
      $spatiu
    $tempfolders = @("C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:R*\Local Settings\temp\*","C:\Windows\SoftwareDistribution", "C:\Users\*\Appdata\Local\Temp\*") 
    Get-Service -Name BITS |Stop-Service
    Get-Service -Name wuauserv |Stop-Service
    Remove-Item $tempfolders -force -recurse -ErrorAction SilentlyContinue
    $winlogs = "C:\Windows\System32\winevt\Logs"
    Get-ChildItem $winlogs -Filter Archive*.* -recurse |?{$_.PSIsContainer -eq $false -and $_.length -gt 1228}|?{Remove-Item $_.fullname } -ErrorAction SilentlyContinue


Write-Host Delete all Files in $cale older than 30 days -ForegroundColor Green -BackgroundColor Blue

$cale = "C:\Windows\LOGS"
$Daysback = "-30"

$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
Get-ChildItem $cale | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item -Recurse -ErrorAction SilentlyContinue
    Write-Host =========================================================
    Write-Host DONE! , checking the free space 

    $Space_after=$After =  Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq "3" } | Select-Object SystemName, 
@{ Name = "Drive" ; Expression = { ( $_.DeviceID ) } }, 
@{ Name = "Size (GB)" ; Expression = {"{0:N1}" -f( $_.Size / 1gb)}}, 
@{ Name = "FreeSpace (GB)" ; Expression = {"{0:N1}" -f( $_.Freespace / 1gb ) } }, 
@{ Name = "PercentFree" ; Expression = {"{0:P1}" -f( $_.FreeSpace / $_.Size ) } } | 
Format-Table -AutoSize | Out-String 
      $Space_after
      Get-Service -Name BITS |start-Service
    Get-Service -Name wuauserv |start-Service

