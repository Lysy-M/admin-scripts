param([string]$TestHost = "1.1.1.1")
Write-Host "===== ADAPTERS ====="
Get-NetAdapter | Select-Object Name,Status,LinkSpeed,MacAddress
Write-Host "`n===== IP CONFIGURATION ====="
Get-NetIPConfiguration | Select-Object InterfaceAlias,IPv4Address,IPv4DefaultGateway,DNSServer
Write-Host "`n===== DNS CLIENT ====="
Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object InterfaceAlias,ServerAddresses
Write-Host "`n===== DEFAULT ROUTE ====="
Get-NetRoute -AddressFamily IPv4 | Where-Object DestinationPrefix -eq "0.0.0.0/0" | Select-Object InterfaceAlias,NextHop,RouteMetric
Write-Host "`n===== CONNECTIVITY TEST ====="
Test-NetConnection -ComputerName $TestHost -InformationLevel Detailed
