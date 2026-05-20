@echo off
setlocal enabledelayedexpansion

:: ========================================================================
:: WINDOWS PASIVE PREFETCHER OPTIMIZATION MODULE
:: TARGET CONFIGURATION: APPLICATION-ONLY PERFORMANCE MAPPING (VALUE 1)
:: PRIVILEGE REQUIREMENT: ADMINISTRATOR ELEVATION ENFORCED (HKLM MODS)
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

echo Initializing passive application memory mapping adjustments...
echo.

:: Target registry path for memory management parameters
set "prefetch_key=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters"

:: Inject EnablePrefetcher = 1 (Application-only tracing, bypasses boot file logging)
reg add "%prefetch_key%" /v "EnablePrefetcher" /t REG_DWORD /d 1 /f >nul

if %errorlevel% equ 0 (
    echo ========================================================================
    echo SUCCESS: Prefetcher configured to Application-Only mode!
    echo.
    echo Note: Windows will no longer waste overhead tracing boot sequences,
    echo but your game launch files will remain perfectly cached and sequential.
    echo ========================================================================
) else (
    echo ========================================================================
    echo ERROR: Failed to write to the local machine registry hive.
    echo Verify your administrative execution parameters.
    echo ========================================================================
)

pause
exit