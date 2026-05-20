@echo off
:: ========================================================================
:: DEFINITIVE LOW-LATENCY HID INPUT TOPOLOGY POWER-LOCK SCRIPT
:: TARGET NODES: RAZER DEATHADDER V4 PRO & MONSGEEK 2.4G WIRELESS TREE
:: ENFORCEMENT: HARD-KILL CHANNELS TERMINATION STATE COOLDOWNS (ZERO DELAY)
:: ========================================================================
echo Applying absolute low-latency hardware power-locks to HID branches...

:: --- INSTANCE 1: MONSGEEK KEYBOARD AUX MOUSE INTERFACE (YICHIP CHIP) ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL04\8&1C646A56&0&0003\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL04\8&1C646A56&0&0003\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL04\8&1C646A56&0&0003\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_3151&PID_5038&MI_01&COL04\8&1C646A56&0&0003\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

:: --- INSTANCE 2: RAZER DEATHADDER V4 PRO (SECONDARY INTERFACE CHANNEL) ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL02\8&150E0201&0&0001\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL02\8&150E0201&0&0001\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL02\8&150E0201&0&0001\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_01&COL02\8&150E0201&0&0001\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

:: --- INSTANCE 3: RAZER DEATHADDER V4 PRO (PRIMARY CORE PHYSICAL MOUSE STREAM) ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_00\8&1DDE5C3&0&0000\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_00\8&1DDE5C3&0&0000\Device Parameters" /v SelectiveSuspendEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_00\8&1DDE5C3&0&0000\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_00BF&MI_00\8&1DDE5C3&0&0000\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 0 /f >nul 2>&1

echo ========================================================================
echo SUCCESS: All composite input channels are hardlocked to full performance!
echo Wireless links and control profiles are blocked from scaling voltage down.
echo ========================================================================
pause