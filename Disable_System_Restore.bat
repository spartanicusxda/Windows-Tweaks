@echo off
:: ========================================================================
:: SYSTEM RESTORE GHOST LOCKOUT REMEDIATION MATRIX
:: PRIVILEGE TARGET: ADMINISTRATOR TOKENS ENFORCED
:: METHOD: POLICY UNLOCK -> POWERSHELL STATE FORCE-FLIP -> POLICY RE-LOCK
:: ========================================================================

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Right-click this script and select 'Run as Administrator'.
    pause
    exit /b
)

echo [1/3] Temporarily removing registry policy restrictions...
:: Deleting the structural policy blocks so the OS can accept configuration modifications
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "DisableSR" /f >nul 2>&1

echo [2/3] Calling PowerShell WMI Core to explicitly force drive protection OFF...
:: Disable-ComputerRestore directly unlinks the filter driver from the C: drive partition structure
powershell -Command "Disable-ComputerRestore -Drive 'C:\'" >nul 2>&1

echo [3/3] Re-applying administrative policy lockdown grids...
:: Now that the drive reads "Off", we lock the interface down permanently
set "sr_policy=HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore"
set "sr_config=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"

reg add "%sr_policy%" /v "DisableSR" /t REG_DWORD /d 1 /f >nul
reg add "%sr_config%" /v "DisableSR" /t REG_DWORD /d 1 /f >nul
reg add "%sr_config%\Cfg" /v "DiskPercent" /t REG_DWORD /d 0 /f >nul

echo ========================================================================
echo SUCCESS: Ghost state broken! Protection is explicitly turned OFF and locked.
echo ========================================================================
pause
exit