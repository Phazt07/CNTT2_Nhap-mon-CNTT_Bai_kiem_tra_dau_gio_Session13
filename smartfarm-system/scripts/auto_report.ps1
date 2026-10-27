[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$logPath = Join-Path $PSScriptRoot '..\data\log-he-thong.log'
$reportPath = Join-Path $PSScriptRoot '..\backup\bao-cao-su-co.txt'
$reportPath = [System.IO.Path]::GetFullPath($reportPath)

$header = @(
    'BAO CAO SU CO SMARTFARM'
    ('Thoi gian tao: ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
    '----------------------------------------'
)
$header | Set-Content -LiteralPath $reportPath

$incidentLines = @(Get-Content -LiteralPath $logPath | Select-String -Pattern 'CRITICAL|ERROR')
$incidentLines | ForEach-Object { $_.Line } >> $reportPath
Write-Output "TONG SO SU CO: $($incidentLines.Count)" >> $reportPath

