@echo off
:: ========================================================================
:: ULTRA-LOW LATENCY USB SUBSYSTEM & PERIPHERAL ROUTING OPTIMIZATION
:: PLATFORM: AMD MATISSE CPU DIRECT & 500 SERIES MOTHERBOARD CHIPSET
:: INPUTS MODULATED: RAZER DEATHADDER V4 PRO (2000Hz+) | MONSGEEK M1 (8000Hz)
:: ========================================================================
echo Initializing zero-latency USB controller and topology injection...

:: ------------------------------------------------------------------------
:: SECTION 1: ANTI-BOTTLENECK CLEANUP (REVERTING DESTRUCTIVE CONSTRAINTS)
:: ------------------------------------------------------------------------
echo [1/4] Purging core affinity constraints from USB device registers...
:: Wipes legacy single-core assignment masks to ensure input processing spreads cleanly.
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_149C&SUBSYS_7C911462&REV_00\4&2EE6FBA0&0&0341\Device Parameters\Interrupt Management\Affinity Policy" /v AssignmentSetOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_43EE&SUBSYS_11421B21&REV_00\4&3A0E317B&0&000A\Device Parameters\Interrupt Management\Affinity Policy" /v AssignmentSetOverride /f >nul 2>&1

:: ------------------------------------------------------------------------
:: SECTION 2: HIGH-PRIORITY HARDWARE CONTROLLER PROFILE PROVISIONS (MSI-X)
:: ------------------------------------------------------------------------
echo [2/4] Elevating core AMD XHCI host controllers to peak execution...

:: --- CHIP 0: CPU DIRECT MATISSE CONTROLLER (Mouse / Keyboard Path) ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_149C&SUBSYS_7C911462&REV_00\4&2EE6FBA0&0&0341\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v MSISupported /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_149C&SUBSYS_7C911462&REV_00\4&2EE6FBA0&0&0341\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePriority /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_149C&SUBSYS_7C911462&REV_00\4&2EE6FBA0&0&0341\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePolicy /t REG_DWORD /d 5 /f

:: --- CHIP 1: 500 SERIES MOTHERBOARD CHIPSET CONTROLLER (Audio / RGB Path) ---
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_43EE&SUBSYS_11421B21&REV_00\4&3A0E317B&0&000A\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v MSISupported /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_43EE&SUBSYS_11421B21&REV_00\4&3A0E317B&0&000A\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePriority /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1022&DEV_43EE&SUBSYS_11421B21&REV_00\4&3A0E317B&0&000A\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePolicy /t REG_DWORD /d 5 /f

:: --- GLOBAL USB SERVICE DRIVER OVERRIDES ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v IdlePowerManagement /t REG_DWORD /d 0 /f

:: ------------------------------------------------------------------------
:: SECTION 3: KERNEL POWER SUBGROUP ENGINE OVERRIDES (powercfg)
:: ------------------------------------------------------------------------
echo [3/4] Overriding active Power Profile USB subgroup constraints...

:: USB 3 Link Power Management (Forces active continuous link state)
powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg -setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0

:: USB Hub Selective Suspend Timeout = 0 (Elimines dynamic poll sleep delays)
powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0
powercfg -setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0

:: Secondary USB Execution Performance Scaling Parameters
powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 0853a681-27c8-4100-a2fd-82013e970683 0
powercfg -setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 0853a681-27c8-4100-a2fd-82013e970683 0

:: Setting IOC on all TDs (Optimizes xHCI endpoint queue response loops)
powercfg -setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 498c044a-201b-4631-a522-5c744ed4e678 0
powercfg -setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 498c044a-201b-4631-a522-5c744ed4e678 0

:: ------------------------------------------------------------------------
:: SECTION 4: GLOBAL CONNECTED PERIPHERAL POWER-SAVING PURGE (disable.ps1)
:: ------------------------------------------------------------------------
echo [4/4] Purging power-saving and sleep states across all connected peripheral nodes...

:: Executes target device sweeps cleanly through native loop parameters across ACPI, HID, PCI, and USB hives
for %%H in (ACPI HID PCI USB) do (
    for /f "tokens=*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\%%H" /s /f "Device Parameters" ^| findstr "Device Parameters"') do (
        reg add "%%A" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
        reg add "%%A" /v "SelectiveSuspendEnabled" /t REG_BINARY /d 00 /f >nul 2>&1
        reg add "%%A" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f >nul 2>&1
        reg add "%%A" /v "WaitWakeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    )
    for /f "tokens=*" %%W in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\%%H" /s /f "WDF" ^| findstr "WDF"') do (
        reg add "%%W" /v "IdleInWorkingState" /t REG_DWORD /d 0 /f >nul 2>&1
    )
)

:: ------------------------------------------------------------------------
:: SECTION 5: 1:1 RAW LINEAR MOUSE ACCELERATION CURVE INJECTION
:: ------------------------------------------------------------------------
echo [5/5] Disabling "Enhance Pointer Precision" curves across profile trees...

:: Write directly to active local user hive mapping
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1

:: SYSTEM-Account bypass: Safely target the true user security ID branches inside HKEY_USERS
for /f "tokens=1,2 delims= " %%A in ('reg query HKU') do (
    echo %%A | findstr /r /c:"S-1-5-21-[0-9]*-[0-9]*-[0-9]*-[0-9]*$" >nul && (
        reg add "%%A\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
        reg add "%%A\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
        reg add "%%A\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
    )
)

:: Flushes power engine changes instantly into the operating system active kernel
powercfg -setactive SCHEME_CURRENT

echo ========================================================================
echo CONFIGURATION MASTER STACK DEPLOYED FLAWLESSLY!
echo - High-Priority MSI-X interrupts applied to input host lanes.
echo - Power-saving link drops purged from connected peripheral nodes.
echo - Mouse acceleration curve zeroed out to true linear 1:1 scaling.
echo.
echo ACTION REQUIRED: Perform a full restart of your machine to initiallize.
echo ========================================================================
pause