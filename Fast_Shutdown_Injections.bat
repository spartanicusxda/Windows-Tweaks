@echo off
:: ========================================================================
:: WINDOWS KERNEL TERMINATION PIPELINE ACCELERATION MATRIX
:: PRIVILEGE TARGET: ADMINISTRATOR TOKENS ENFORCED (HKLM/HKCU MODS)
:: OPTIMIZATION PATTERN: AGGRESSIVE APPDATA & SERVICE SHUTDOWN COMPRESSION
:: ========================================================================

:: Verify administrative tokens
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Administrative tokens are required to overwrite kernel shutdown keys.
    echo Right-click this script and select 'Run as Administrator'.
    pause
    exit /b
)

echo Initializing kernel termination optimization models...
echo.

:: ------------------------------------------------------------------------
:: LAYER 1: APPS TERMINATION SPEED (CURRENT USER PROFILE)
:: ------------------------------------------------------------------------
echo [1/2] Injecting active application closure speed variables...

:: AutoEndTasks forces Windows to automatically kill hung apps without prompting you with an alert dialog
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul

:: HungAppTimeout determines how long Windows waits for an app to respond before considering it frozen (Reduced to 1 second)
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f >nul

:: WaitToKillAppTimeout sets the absolute time limit Windows grants an active app to close after it flags out (Reduced to 2 seconds)
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul


:: ------------------------------------------------------------------------
:: LAYER 2: SERVICE TERMINATION SPEED (SYSTEM-WIDE KERNEL)
:: ------------------------------------------------------------------------
echo [2/2] Aligning global background system service termination parameters...

:: WaitToKillServiceTimeout instructs the Service Control Manager how long background system services can linger before execution terminates (Reduced to 2 seconds)
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul

echo ========================================================================
echo SUCCESS: Rapid shutdown parameters successfully written to the registry!
echo Changes will be active on your very next restart or shutdown cycle.
echo ========================================================================
pause
exit