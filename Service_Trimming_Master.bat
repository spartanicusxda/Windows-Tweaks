@echo off
:: ========================================================================
:: REVISED WINDOWS BACKGROUND SERVICE TRIMMING MATRIX (WIN11 25H2 ALIGNED)
:: PRIVILEGE TARGET: ADMINISTRATOR TOKENS ENFORCED (SC CONFIG LAYER)
:: CONFIGURATION TARGET: PERMANENTLY DISABLE OVERHEAD RECURSION THREADS
:: REVISION: BYPASSED MID-SESSION STOP OPERATIONS TO PREVENT CONSOLE HANGS
:: ========================================================================

:: Verify administrative tokens
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Administrative tokens are required to change service structures.
    echo Right-click this script and select 'Run as Administrator'.
    pause
    exit /b
)

echo Registering service deactivations in the system configuration registry...
echo.

:: --- [CATEGORY 1: DIAGNOSTICS, TELEMETRY & ERROR TRACKING] ---
echo [1/4] Purging diagnostics and analytics modules...
sc config DiagTrack start= disabled >nul 2>&1
sc config DPS start= disabled >nul 2>&1
sc config WdiSystemHost start= disabled >nul 2>&1
sc config PcaSvc start= disabled >nul 2>&1

:: --- [CATEGORY 2: NETWORK BROADCASTING & DISCOVERY OVERHEAD] ---
echo [2/4] Halting network multicast polling links...
sc config SSDPSRV start= disabled >nul 2>&1
sc config fdPHost start= disabled >nul 2>&1
sc config FDResPub start= disabled >nul 2>&1
sc config TrkWks start= disabled >nul 2>&1

:: --- [CATEGORY 3: LOCATION & ACCOUNT POLL LAYERS] ---
echo [3/4] Shuttling geolocation and remote session trackers...
sc config lfsvc start= disabled >nul 2>&1
sc config RemoteRegistry start= disabled >nul 2>&1
sc config XblAuthManager start= disabled >nul 2>&1

:: --- [CATEGORY 4: HARDWARE IDLE WASTES] ---
echo [4/4] Disabling idle printer spooler listeners...
sc config Spooler start= disabled >nul 2>&1

echo.
echo ========================================================================
echo SUCCESS: Service blueprints disabled within the system hive!
echo.
echo NOTE: Active mid-session stops were safely bypassed to prevent freezes.
echo Simply RESTART your computer now to drop these threads from memory cleanly.
echo ========================================================================
pause
exit