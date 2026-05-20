@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please Run as Administrator.
    pause
    exit /b
)
:: Mutes DCOM Error logging to prevent event log filling latency
reg add "HKLM\SOFTWARE\Microsoft\Ole" /v "ActivationFailureLoggingLevel" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Ole" /v "CallFailureLoggingLevel" /t REG_DWORD /d 0 /f >nul
echo DCOM Logging silenced successfully.
pause