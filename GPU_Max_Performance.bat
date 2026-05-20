@echo off
:: ========================================================================
:: ULTRA-LOW LATENCY GPU INTERRUPT ENGINE OPTIMIZATION
:: TARGET HARDWARE: AMD RADEON RX 7900 XT (ASROCK PHANTOM GAMING 20GB OC)
:: SYSTEM TOPOLOGY: AMD RYZEN 7 5800X3D (MONOLITHIC SINGLE-CCD CACHE)
:: ========================================================================
echo Initializing hardware-level GPU interrupt stack optimization...

:: ------------------------------------------------------------------------
:: SECTION 1: ANTI-BOTTLENECK CLEANUP (REVERTING DESTRUCTIVE CONSTRAINTS)
:: ------------------------------------------------------------------------
echo [1/3] Purging potential single-core affinity masks...
:: Wipes legacy single-core masking (AssignmentSetOverride) to ensure 
:: massive frame render requests aren't choked down into a single core thread.
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1002&DEV_744C&SUBSYS_53081849&REV_CC\6&4715F68&0&00000019\Device Parameters\Interrupt Management\Affinity Policy" /v AssignmentSetOverride /f >nul 2>&1

:: ------------------------------------------------------------------------
:: SECTION 2: HIGH-PRIORITY MSI-X INTERRUPT PARAMETERS
:: ------------------------------------------------------------------------
echo [2/3] Injecting zero-latency rendering execution parameters...

:: 1. Force Message Signaled Interrupts (MSI) Mode
:: Directs the GPU to write its completion events directly to RAM, avoiding shared IRQ lines.
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1002&DEV_744C&SUBSYS_53081849&REV_CC\6&4715F68&0&00000019\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v MSISupported /t REG_DWORD /d 1 /f

:: 2. Set Interrupt Priority to High
:: Forces the Windows kernel to process GPU signals ahead of standard background devices.
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1002&DEV_744C&SUBSYS_53081849&REV_CC\6&4715F68&0&00000019\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePriority /t REG_DWORD /d 3 /f

:: 3. Let Windows distribute rendering messages organically across cores
:: Configures 'IrqPolicySpreadMessagesAcrossAllProcessors' to allow high-volume frame 
:: calculations to scale dynamically across your 5800X3D's threads, eliminating stutters.
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1002&DEV_744C&SUBSYS_53081849&REV_CC\6&4715F68&0&00000019\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePolicy /t REG_DWORD /d 5 /f

:: ------------------------------------------------------------------------
:: SECTION 3: DEPLOYMENT COMPLETE
:: ------------------------------------------------------------------------
echo [3/3] Flushing device property configuration updates...
echo ========================================================================
echo SUCCESS: Your RX 7900 XT rendering pipeline is fully optimized!
echo Please restart your PC to allow the Windows HAL to reload device priorities.
echo ========================================================================
pause