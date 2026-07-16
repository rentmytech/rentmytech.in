from pathlib import Path

ps1 = r'''# Rent My Tech Inventory Management v3.0 (Base)
# Requires: PowerShell 5.1+, Administrator (for computer rename)

$ErrorActionPreference = "SilentlyContinue"

function Get-InputChoice {
    param([string]$Title,[string[]]$Options)
    Write-Host ""
    Write-Host $Title -ForegroundColor Cyan
    for($i=0;$i -lt $Options.Count;$i++){
        Write-Host "$($i+1). $($Options[$i])"
    }
    do{
        $c = Read-Host "Select"
    } until(($c -as [int]) -and $c -ge 1 -and $c -le $Options.Count)
    return $Options[$c-1]
}

Clear-Host
Write-Host "==========================================" -ForegroundColor Green
Write-Host " Rent My Tech Inventory Management v3.0"
Write-Host "==========================================" -ForegroundColor Green

$asset = Read-Host "Enter Asset Number (Example: 001, A001, TEST01)"
$computerName = "RMT_$asset"

$deviceType = Get-InputChoice "Device Type" @("Laptop","Desktop")

$installer = Get-InputChoice "Installer" @("Shahbaz","Other")
if($installer -eq "Other"){
    $installer = Read-Host "Enter Installer Name"
}

$issuedName = Read-Host "Issued To - Name"
$mobile = Read-Host "Mobile Number"
$aadhar = Read-Host "Aadhaar Number"

$issueDate = Get-Date -Format "yyyy-MM-dd"
$issueTime = Get-Date -Format "HH:mm:ss"

$cs = Get-CimInstance Win32_ComputerSystem
$bios = Get-CimInstance Win32_BIOS
$board = Get-CimInstance Win32_BaseBoard
$cpu = Get-CimInstance Win32_Processor
$os = Get-CimInstance Win32_OperatingSystem

$ramGB = [math]::Round($cs.TotalPhysicalMemory/1GB,2)
$ramSpeed = ($cpu | Select-Object -First 1 | Out-Null)
$mem = Get-CimInstance Win32_PhysicalMemory | Select-Object -First 1
$ramSpeed = $mem.Speed

$disks = Get-PhysicalDisk | Sort-Object DeviceId
function DiskInfo($idx){
    if($idx -lt $disks.Count){
        $d = $disks[$idx]
        [PSCustomObject]@{
            Model=$d.FriendlyName
            Type=$d.MediaType
            Size=[math]::Round($d.Size/1GB,0)
        }
    } else {
        [PSCustomObject]@{Model="";Type="";Size=""}
    }
}
$d0 = DiskInfo 0
$d1 = DiskInfo 1

$BatteryHealth=""
$BatteryDesign=""
$BatteryFull=""
$BatteryWear=""

if($deviceType -eq "Laptop"){
    $report="$env:TEMP\battery-report.html"
    powercfg /batteryreport /output $report | Out-Null
    if(Test-Path $report){
        $html = Get-Content $report -Raw
        if($html -match "DESIGN CAPACITY.*?([\d,]+)\s*mWh"){ $BatteryDesign=$matches[1].Replace(",","") }
        if($html -match "FULL CHARGE CAPACITY.*?([\d,]+)\s*mWh"){ $BatteryFull=$matches[1].Replace(",","") }
        if($BatteryDesign -and $BatteryFull){
            $BatteryWear=[math]::Round((1-([double]$BatteryFull/[double]$BatteryDesign))*100,1)
            $BatteryHealth=100-$BatteryWear
        }
    }
}

$row = [PSCustomObject]@{
"Asset No"=$asset
"Computer Name"=$computerName
"Device Type"=$deviceType
Installer=$installer
"Issued To Name"=$issuedName
Mobile=$mobile
Aadhaar=$aadhar
"Issue Date"=$issueDate
"Issue Time"=$issueTime
Manufacturer=$cs.Manufacturer
Model=$cs.Model
"BIOS Serial Number"=$bios.SerialNumber
"Motherboard Serial Number"=$board.SerialNumber
CPU=$cpu.Name
"Installed RAM (GB)"=$ramGB
"RAM Speed (MHz)"=$ramSpeed
"Windows Edition"=$os.Caption
"Disk 0 Model"=$d0.Model
"Disk 0 Type"=$d0.Type
"Disk 0 Size (GB)"=$d0.Size
"Disk 1 Model"=$d1.Model
"Disk 1 Type"=$d1.Type
"Disk 1 Size (GB)"=$d1.Size
"Battery Health (%)"=$BatteryHealth
"Battery Design Capacity"=$BatteryDesign
"Battery Full Charge Capacity"=$BatteryFull
"Battery Wear (%)"=$BatteryWear
}

$csv = Join-Path $PSScriptRoot "Inventory.csv"
if(Test-Path $csv){
    $row | Export-Csv $csv -NoTypeInformation -Append
}else{
    $row | Export-Csv $csv -NoTypeInformation
}

try{
    Rename-Computer -NewName $computerName -Force
    Write-Host "`nComputer rename scheduled. It will apply after reboot." -ForegroundColor Yellow
}catch{}

Write-Host "`nInventory saved to Inventory.csv" -ForegroundColor Green
Write-Host "Press Enter to exit..."
Read-Host
'''

path = Path("/mnt/data/RMT_Inventory_v3_Base.ps1")
path.write_text(ps1, encoding="utf-8")
print(path)
