param(
    [int]$Hours = 24,
    [int]$MaxEvents = 100
)

$ErrorActionPreference = "SilentlyContinue"
$Start = (Get-Date).AddHours(-$Hours)

Write-Host "===== INCIDENT LOG COLLECTION ====="
Write-Host "Window: last $Hours hours"

$Logs = @('System','Application','Security')

foreach ($Log in $Logs) {
    Write-Host "`n===== $Log : CRITICAL / ERROR / WARNING ====="
    Get-WinEvent -FilterHashtable @{
        LogName   = $Log
        Level     = 1,2,3
        StartTime = $Start
    } -MaxEvents $MaxEvents |
        Select-Object TimeCreated, Id, ProviderName, LevelDisplayName, Message
}

Write-Host "`n===== FAILED SERVICES ====="
Get-Service |
    Where-Object {$_.StartType -eq 'Automatic' -and $_.Status -ne 'Running'} |
    Select-Object Name, Status, StartType

Write-Host "`n===== LISTENING TCP PORTS ====="
Get-NetTCPConnection -State Listen |
    Sort-Object LocalPort |
    Select-Object LocalAddress, LocalPort, OwningProcess
