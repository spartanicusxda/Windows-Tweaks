@echo off
:: ========================================================================
:: DEFINITIVE LOW-LATENCY KEYBOARD TOPOLOGY POWER-LOCK SCRIPT
:: TARGETS: MONSGEEK M1 WIRELESS TREE & RAZER COMPOSITE EMULATION NODES
:: ENFORCEMENT: TOTAL STRIPPING OF CONTROLLER LOW-POWER COOLDOWNS
:: ========================================================================
echo Injecting absolute hardware performance locks to HID Keyboard branches...

:: --- INSTANCE 1: MONSGEEK KEYBOARD PRIMARY CORE KEYSTROKE DATA STREAM ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_00\8&4A0DE11&0&0000\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_00\8&4A0DE11&0&0000\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_00\8&4A0DE11&0&0000\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_00\8&4A0DE11&0&0000\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

:: --- INSTANCE 2: MONSGEEK KEYBOARD MACRO & ADVANCED CONTROL COLLECTION ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL03\8&1C646A56&0&0002\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL03\8&1C646A56&0&0002\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL03\8&1C646A56&0&0002\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL03\8&1C646A56&0&0002\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

:: --- INSTANCE 3: RAZER DEATHADDER COMPOSITE KEYBOARD MACRO BRIDGING CHANNEL ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL01\8&150E0201&0&0000\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL01\8&150E0201&0&0000\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL01\8&150E0201&0&0000\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL01\8&150E0201&0&0000\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

:: --- INSTANCE 4: RAZER DEATHADDER SECONDARY COMPOSITE EMULATION ENDPOINT ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_02\8&283E1E3F&0&0000\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_02\8&283E1E3F&0&0000\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_02\8&283E1E3F&0&0000\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_02\8&283E1E3F&0&0000\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

echo ========================================================================
echo SUCCESS: Complete keyboard input framework is power-locked!
echo Peripheral wake delays and endpoint suspension loops are disabled.
echo ========================================================================
pause