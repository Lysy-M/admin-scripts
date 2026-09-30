$ErrorActionPreference = "SilentlyContinue"
Write-Host "===== SYSTEM INVENTORY ====="
Get-Date

Write-Host "`n===== OPERATING SYSTEM ====="
Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber, LastBootUpTime

Write-Host "`n===== CPU ====="
Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors

Write-Host "`n===== MEMORY ====="
$os = Get-CimInstance Win32_OperatingSystem
[PSCustomObject]@{ TotalGB=[math]::Round($os.TotalVisibleMemorySize/1MB,2); FreeGB=[math]::Round($os.FreePhysicalMemory/1MB,2) }

Write-Host "`n===== DISKS ====="
Get-Volume | Where-Object DriveLetter | Select-Object DriveLetter, FileSystemLabel, FileSystem, @{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}}, @{N='FreeGB';E={[math]::Round($_.SizeRemaining/1GB,2)}}

Write-Host "`n===== NETWORK ADAPTERS ====="
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed, MacAddress
