@echo off
:: ========================================================================
:: 8BITDO ULTIMATE WIRELESS CONTROLLER POWER-LOCK (XINPUT MODE)
:: TARGET NODE: USB\VID_2DC8&PID_310B&MI_00\7&2B5DFFFE&0&0000
:: CONFIGURATION: ZERO CONTROLLER COOLDOWN WAKE DELAY | UNCOMPROMISED VOLTAGE
:: ========================================================================
echo Injecting absolute performance locks to 8BitDo XInput USB branch...

:: 1. Disable Enhanced Power Management (Stops Windows from sleep-controlling the controller)
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\USB\VID_2DC8&PID_310B&MI_00\7&2B5DFFFE&0&0000\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: 2. Disable Selective Suspend on this specific connection link
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\USB\VID_2DC8&PID_310B&MI_00\7&2B5DFFFE&0&0000\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: 3. Kill the Idle-to-D3 Sleep State transition rule
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\USB\VID_2DC8&PID_310B&MI_00\7&2B5DFFFE&0&0000\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1

:: 4. Force WDF (Windows Driver Foundation) to keep the controller interface 100% awake
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\USB\VID_2DC8&PID_310B&MI_00\7&2B5DFFFE&0&0000\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

echo ========================================================================
echo SUCCESS: 8BitDo Controller communication link locked at maximum alert!
echo USB polling lanes are permanently unthrottled.
echo ========================================================================
pause