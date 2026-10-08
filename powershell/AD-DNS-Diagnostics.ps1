$ErrorActionPreference = "SilentlyContinue"

Write-Host "===== AD / DNS DIAGNOSTICS ====="

if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Write-Host "ActiveDirectory module not available. Install AD DS/RSAT tools to enable AD checks."
} else {
    Import-Module ActiveDirectory

    Write-Host "`n===== DOMAIN ====="
    Get-ADDomain | Select-Object DNSRoot, NetBIOSName, DomainMode, PDCEmulator, RIDMaster, InfrastructureMaster

    Write-Host "`n===== DOMAIN CONTROLLERS ====="
    Get-ADDomainController -Filter * |
        Select-Object HostName, IPv4Address, Site, IsGlobalCatalog

    Write-Host "`n===== AD REPLICATION ====="
    if (Get-Command repadmin.exe -ErrorAction SilentlyContinue) {
        repadmin.exe /replsummary
    }
}

Write-Host "`n===== DNS CLIENT ====="
Get-DnsClientServerAddress -AddressFamily IPv4 |
    Select-Object InterfaceAlias, ServerAddresses

Write-Host "`n===== DNS SERVICE ====="
Get-Service DNS -ErrorAction SilentlyContinue |
    Select-Object Name, Status, StartType

Write-Host "`n===== DNS RESOLUTION ====="
Resolve-DnsName $env:USERDNSDOMAIN -ErrorAction SilentlyContinue |
    Select-Object Name, Type, IPAddress
