$ErrorActionPreference = "SilentlyContinue"

Write-Host "===== WINDOWS SERVER HEALTH ====="
Get-Date

Write-Host "`n===== SYSTEM ====="
Get-CimInstance Win32_OperatingSystem |
    Select-Object Caption, Version, BuildNumber, LastBootUpTime

Write-Host "`n===== MEMORY ====="
$os = Get-CimInstance Win32_OperatingSystem
[PSCustomObject]@{
    TotalGB = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    FreeGB  = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
}

Write-Host "`n===== DISKS ====="
Get-Volume |
    Where-Object DriveLetter |
    Select-Object DriveLetter, FileSystemLabel, HealthStatus,
        @{N='SizeGB';E={[math]::Round($_.Size/1GB,2)}},
        @{N='FreeGB';E={[math]::Round($_.SizeRemaining/1GB,2)}}

Write-Host "`n===== KEY SERVICES ====="
$Services = 'NTDS','DNS','Kdc','Netlogon','DFSR','TermService','sshd','WinRM','W32Time'
Get-Service -Name $Services -ErrorAction SilentlyContinue |
    Select-Object Name, Status, StartType

Write-Host "`n===== RECENT SYSTEM ERRORS ====="
$Start = (Get-Date).AddHours(-24)
Get-WinEvent -FilterHashtable @{LogName='System';Level=1,2;StartTime=$Start} -MaxEvents 30 |
    Select-Object TimeCreated, Id, ProviderName, LevelDisplayName, Message
