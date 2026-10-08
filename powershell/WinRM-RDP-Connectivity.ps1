param(
    [Parameter(Mandatory=$true)]
    [string]$ComputerName
)

$ErrorActionPreference = "SilentlyContinue"

Write-Host "===== WINRM / RDP CONNECTIVITY ====="
Write-Host "Target: $ComputerName"

Write-Host "`n===== DNS ====="
Resolve-DnsName $ComputerName |
    Select-Object Name, Type, IPAddress

Write-Host "`n===== ICMP ====="
Test-Connection -ComputerName $ComputerName -Count 2

Write-Host "`n===== WINRM HTTP 5985 ====="
Test-NetConnection -ComputerName $ComputerName -Port 5985 -InformationLevel Detailed

Write-Host "`n===== RDP 3389 ====="
Test-NetConnection -ComputerName $ComputerName -Port 3389 -InformationLevel Detailed

Write-Host "`n===== SSH 22 ====="
Test-NetConnection -ComputerName $ComputerName -Port 22 -InformationLevel Detailed
