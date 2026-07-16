@echo off
title Rent My Tech Inventory

:: Request Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set "URL=https://rentmytech.in/scripts/inventory.ps1"
set "FILE=%TEMP%\inventory.ps1"

echo Downloading latest inventory script...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Invoke-WebRequest -Uri '%URL%' -OutFile '%FILE%'"

if not exist "%FILE%" (
    echo Failed to download script.
    pause
    exit /b
)

powershell -ExecutionPolicy Bypass -File "%FILE%"
pause
