@echo off
chcp 936 >nul
echo ========================================
echo   Register GitHub Hosts Auto Update Task
echo   (Silent update every 6 hours)
echo ========================================
echo.

REM Get current exe path
set "EXE_PATH=%~dp0dist\GhHostsUpdater.exe"

if not exist "%EXE_PATH%" (
    echo [ERROR] %EXE_PATH% not found
    echo Please run build.bat first to build the executable.
    pause
    exit /b 1
)

echo Target: %EXE_PATH%
echo.

REM Create scheduled task (requires admin privileges)
schtasks /create /tn "GitHub Hosts Auto Updater" /tr "\"%EXE_PATH%\" --silent" /sc hourly /mo 6 /f /rl highest

if errorlevel 1 (
    echo.
    echo [ERROR] Failed to create task. Please run this script as administrator.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Task created successfully!
echo   Task name: GitHub Hosts Auto Updater
echo   Frequency: Every 6 hours
echo   Run level: Highest (Administrator)
echo ========================================
echo.
echo View: Task Scheduler -^> Task Scheduler Library -^> GitHub Hosts Auto Updater
echo Remove: schtasks /delete /tn "GitHub Hosts Auto Updater" /f
echo.
pause
