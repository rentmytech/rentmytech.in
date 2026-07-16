@echo off
title Rent My Tech Inventory Launcher

:: Request Administrator if not already running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls
echo ======================================
echo      Rent My Tech Inventory
echo ======================================
echo.

set "URL=https://raw.githubusercontent.com/rentmytech/rentmytech.in/main/scripts/inventory.ps1"
set "FILE=%TEMP%\inventory.ps1"

echo Downloading latest version...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Invoke-WebRequest -Uri '%URL%' -OutFile '%FILE%'"

if errorlevel 1 (
    echo.
    echo ERROR: Unable to download inventory.ps1
    pause
    exit /b
)

echo.
echo Launching Inventory Script...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%FILE%"

echo.
echo ======================================
echo Inventory Process Completed
echo ======================================
pause
