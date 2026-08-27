@echo off
chcp 936 >nul
echo ========================================
echo   GitHub Hosts Updater - Build Script
echo ========================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found. Please install Python 3.8+
    pause
    exit /b 1
)

REM Install dependencies
echo [1/3] Installing dependencies...
python -m pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
if errorlevel 1 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

REM Clean old build
echo.
echo [2/3] Cleaning old build files...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist GhHostsUpdater.spec del /q GhHostsUpdater.spec

REM Build
echo.
echo [3/3] Building executable...
python -m PyInstaller --onefile --windowed --name "GhHostsUpdater" --icon NONE --uac-admin main.py

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Build completed!
echo   Output: dist\GhHostsUpdater.exe
echo ========================================
echo.
echo Note: --uac-admin will trigger UAC prompt when running the exe.
echo.
pause
