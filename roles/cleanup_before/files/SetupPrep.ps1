$ErrorActionPreference = "Stop"
Write-Host "== Enabling EMS access ===================================" `
     -ForegroundColor Black -BackgroundColor Yellow

$SvchostPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost'
$SvchostServices = (Get-ItemProperty -Path $SvchostPath).netsvcs
$SvchostServices += 'sacsvr'
Set-ItemProperty -Path $SvchostPath -name netsvcs `
    -value $SvchostServices -type MultiString

& bcdedit /emssettings EMSPORT:2 EMSBAUDRATE:115200 | Out-Default
& bcdedit /ems on  | Out-Default


Write-Host "== Synchronizing time ====================================" `
     -ForegroundColor Black -BackgroundColor Yellow

Start-Service W32time
& w32tm /resync | Out-Default

Write-Host "== Restoring TCP timeout and route to metadata server ====" `
     -ForegroundColor Black -BackgroundColor Yellow

$TcpParams = 'HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters'
New-ItemProperty -Force -Path $TcpParams -Name 'KeepAliveTime' `
   -Value 300000 -PropertyType DWord

& route add 169.254.169.254 mask 255.255.255.255 0.0.0.0 -p | Out-Default

Write-Host "== Completed =============================================" `
     -ForegroundColor Black -BackgroundColor Yellow
