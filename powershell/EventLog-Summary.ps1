param([int]$Hours = 24,[int]$MaxEvents = 40)
$Start=(Get-Date).AddHours(-$Hours)
Write-Host "===== SYSTEM: Critical + Error ====="
Get-WinEvent -FilterHashtable @{LogName='System';Level=1,2;StartTime=$Start} -MaxEvents $MaxEvents | Select-Object TimeCreated,Id,ProviderName,LevelDisplayName,Message
Write-Host "`n===== APPLICATION: Critical + Error ====="
Get-WinEvent -FilterHashtable @{LogName='Application';Level=1,2;StartTime=$Start} -MaxEvents $MaxEvents | Select-Object TimeCreated,Id,ProviderName,LevelDisplayName,Message
