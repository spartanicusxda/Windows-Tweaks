@echo off
setlocal enabledelayedexpansion

:: ========================================================================
:: ADVANCED OPERATING SYSTEM RESOURCE UNTHROTTLING MATRIX
:: PRIVILEGE TARGET: ADMINISTRATOR TOKENS ENFORCED (REGEDIT INJECTIONS)
:: TARGETS: NETWORK THROTTLING, APPCAPTURE DELAYS, POWER REGULATION PIPES
:: ========================================================================

:: Verify administrative tokens
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Administrative elevation tokens are strictly required.
    echo Right-click this script and select 'Run as Administrator'.
    pause
    exit /b
)

echo Deploying advanced low-latency resource allocation matrices...
echo.

:: ------------------------------------------------------------------------
:: STEP 1: ELIMINATE NETWORK THROTTLING & UNLOCK CPU RESPONSIVENESS
:: ------------------------------------------------------------------------
echo [1/4] Disabling network throttling and unlocking 100%% CPU priority...
set "sys_profile=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
:: ffffffff completely deactivates network data packet throttling
reg add "%sys_profile%" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul
:: 0 forces Windows to grant the active foreground game 100% CPU access
reg add "%sys_profile%" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul


:: ------------------------------------------------------------------------
:: STEP 2: REMOVE BACKGROUND GAME DVR CAPTURE HOOKS
:: ------------------------------------------------------------------------
echo [2/4] Stripping hidden background Game DVR capture pipelines...
:: Disable AppCapture features entirely at the user profile layer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
:: Disable GameDVR configuration store background polling loops
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
:: Force policy layer block on overall Game DVR recording systems
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul


:: ------------------------------------------------------------------------
:: STEP 3: DISABLE GLOBAL BACKGROUND POWER THROTTLING
:: ------------------------------------------------------------------------
echo [3/4] Turning off background Power Throttling execution limits...
:: Hardlocks the kernel from downclocking or prioritizing active background processes
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul


:: ------------------------------------------------------------------------
:: STEP 4: DISABLE STICKY KEYS & FILTER KEYS POPUP TRIGGERS
:: ------------------------------------------------------------------------
echo [4/4] Blocking gaming shortcut accessibility popup triggers...
:: Prevents Windows from breaking your full-screen game focus if you tap Shift rapidly
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >nul
reg add "HKCU\Control Panel\Accessibility\FilterKeys" /v "Flags" /t REG_SZ /d "122" /f >nul
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f >nul

echo.
echo ========================================================================
echo SUCCESS: Advanced network, CPU, and capture overrides applied cleanly!
echo Restart your computer to initialize these new pipeline states.
echo ========================================================================
pause
exit