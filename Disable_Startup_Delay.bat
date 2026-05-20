@echo off
setlocal enabledelayedexpansion

:: ========================================================================
:: WINDOWS DESKTOP SHELL INITIALIZATION ACCELERATION ENGINE
:: TARGET CONFIGURATION: ZERO RUNTIME OVERHEAD FOR USER STARTUP APPS
:: PRIVILEGE REQUIREMENT: ADMINISTRATOR ELEVATION ENFORCED
:: ========================================================================

:: Verify administrative tokens
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ========================================================================
    echo ERROR: This script requires full Administrator privileges.
    echo Right-click the .bat file and select 'Run as Administrator'.
    echo ========================================================================
    pause
    exit /b
)

echo Initializing desktop initialization speed injection...
echo.

:: Define the target registry path variable
set "target_key=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"

:: Inject the WaitForIdleState override (Stops Windows from waiting for services to spin down)
reg add "%target_key%" /v "WaitForIdleState" /t REG_DWORD /d 0 /f >nul

:: Inject the StartupDelayInMSec override (Cuts the hardcoded app launch timer to 0ms)
reg add "%target_key%" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >nul

if %errorlevel% equ 0 (
    echo ========================================================================
    echo SUCCESS: Startup Delay variables injected cleanly into the User Hive!
    echo.
    echo ATTENTION: You must RESTART your computer for the Windows User Shell
    echo to reload its configuration cache and launch your apps instantly.
    echo ========================================================================
) else (
    echo ========================================================================
    echo ERROR: Failed to write to the user registry hive database.
    echo Verify your account privileges or security software profiles.
    echo ========================================================================
)

pause
exit