@echo off
:: ========================================================================
:: ULTRA-LOW LATENCY NVME STORAGE STACK OPTIMIZATION
:: TARGET HARDWARE: KINGSTON KC3000 4TB (PHISON E18 GENERATION 4 CONTROLLER)
:: SYSTEM TOPOLOGY: AMD RYZEN 7 5800X3D (MONOLITHIC SINGLE-CCD CACHE)
:: ========================================================================
echo Initializing hardware-level storage stack optimization...

:: ------------------------------------------------------------------------
:: SECTION 1: CRITICAL RECOVERY & CLEANUP (REVERTING PERFORMANCES SABOTAGE)
:: ------------------------------------------------------------------------
:: Wipes the single-core constraint. Your multi-threaded game engine requires parallel storage threads.
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_2646&DEV_5013&SUBSYS_50132646&REV_01\4&202489A6&0&0009\Device Parameters\Interrupt Management\Affinity Policy" /v AssignmentSetOverride /f >nul 2>&1

:: Wipes QueueDepth=1 constraint. This returns the SSD to its native parallel queues (32/64 queues) instead of acting like an old spinning hard drive.
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v QueueDepth /f >nul 2>&1

:: ------------------------------------------------------------------------
:: SECTION 2: HARDWARE INTERRUPT & POWER MANAGEMENT STATE (PS0 PINNING)
:: ------------------------------------------------------------------------
:: Forces Message Signaled Interrupts (MSI) Mode
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_2646&DEV_5013&SUBSYS_50132646&REV_01\4&202489A6&0&0009\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v MSISupported /t REG_DWORD /d 1 /f

:: Elevates NVMe hardware execution weight to absolute High priority
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_2646&DEV_5013&SUBSYS_50132646&REV_01\4&202489A6&0&0009\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePriority /t REG_DWORD /d 3 /f

:: Configures IrqPolicySpreadMessagesAcrossAllProcessors to scale asset streams dynamically across your cores
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_2646&DEV_5013&SUBSYS_50132646&REV_01\4&202489A6&0&0009\Device Parameters\Interrupt Management\Affinity Policy" /v DevicePolicy /t REG_DWORD /d 5 /f

:: Disables autonomous drive idling, pinning the Phison E18 controller into its max performance power state (PS0) permanently
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_2646&DEV_5013&SUBSYS_50132646&REV_01\4&202489A6&0&0009\Device Parameters\StorNVMe" /v EnableIdlePowerManagement /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\PCI\VEN_2646&DEV_5013&SUBSYS_50132646&REV_01\4&202489A6&0&0009\Device Parameters\StorNVMe" /v IdleTimeoutInMS /t REG_DWORD /d 0 /f

:: ------------------------------------------------------------------------
:: SECTION 3: KERNEL POWER CONFIGURATION SUB_DISK & SUB_PCIEXPRESS DEEP TWEAKS
:: ------------------------------------------------------------------------
echo Injecting kernel power profile variables...

:: Turn off hard disk timeout = 0 (Never spin down / sleep)
powercfg -setacvalueindex SCHEME_CURRENT SUB_DISK 0b2d69d7-a2a1-449c-9680-f91c70521c60 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK 0b2d69d7-a2a1-449c-9680-f91c70521c60 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK 80e3c60e-bb94-4ad8-bbe0-0d3195efc663 0

:: AHCI/NVMe Link Power Management = 0 (Active / Absolute Link Performance)
powercfg -setacvalueindex SCHEME_CURRENT SUB_DISK dab60367-53fe-4fbc-825e-521d069d2456 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK dab60367-53fe-4fbc-825e-521d069d2456 0

:: NVMe Idle Timeout Parameters = 0 (Prevents operational state drops)
powercfg -setacvalueindex SCHEME_CURRENT SUB_DISK 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
powercfg -setacvalueindex SCHEME_CURRENT SUB_DISK d639518a-e56d-4345-8af2-b9f32fb26109 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK d639518a-e56d-4345-8af2-b9f32fb26109 0

:: NVMe Power State Transition Latency Tolerance = 0 (Zero wake-up delay allowed)
powercfg -setacvalueindex SCHEME_CURRENT SUB_DISK d3d55efd-c1ff-424e-9dc3-441be7833010 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK d3d55efd-c1ff-424e-9dc3-441be7833010 0

:: Storage Concurrency Allocation optimization
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK fc7372b6-ab2d-43ee-8797-15e9841f2cca 1

:: NVM Express Specification Subsystem power management = 0 (Disabled)
powercfg -setacvalueindex SCHEME_CURRENT SUB_DISK fc95af4d-40e7-4b6d-835a-56d131dbc80e 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK fc95af4d-40e7-4b6d-835a-56d131dbc80e 0

:: Device Idle Policy = 0 (Performance execution priority)
powercfg -setacvalueindex SCHEME_CURRENT SUB_DISK dbc9e238-6de9-49e3-92cd-8c2b4946b472 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_DISK dbc9e238-6de9-49e3-92cd-8c2b4946b472 0

:: PCIe Link State Power Management (ASPM) = 0 (Turned completely off for Maximum Link Throughput)
powercfg -setacvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0
powercfg -setdcvalueindex SCHEME_CURRENT 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0

:: ------------------------------------------------------------------------
:: SECTION 4: GLOBAL KERNEL IDLE RESILIENCY & TIME SUBSYSTEMS OVERRIDES
:: ------------------------------------------------------------------------
:: Subgroup None execution overrides
powercfg -setdcvalueindex SCHEME_CURRENT SUB_NONE 4faab71a-92e5-4726-b531-224559672d19 0

:: Interrupt Steering Resiliency (SUB_IR) = 0 (Prevents dynamic delays / micro-stutters)
powercfg -setdcvalueindex SCHEME_CURRENT SUB_IR 3166bc41-7e98-4e03-b34e-ec0f5f2b218e 0
powercfg -setdcvalueindex SCHEME_CURRENT SUB_IR c36f0eb4-2988-4a70-8eee-0884fc2c2433 0

:: Global Kernel Deep Sleep Resiliency override
powercfg -setdcvalueindex SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0

:: ------------------------------------------------------------------------
:: SECTION 5: FORCING ACTIVE FLUSH TO THE ENVIRONMENT
:: ------------------------------------------------------------------------
:: Flushes the configuration straight into the live environment database
powercfg -setactive SCHEME_CURRENT

echo ========================================================================
echo SUCCESS: Your KC3000 Storage Engine is fully optimized!
echo Please restart your PC to register hardware priority level adjustments.
echo ========================================================================
pause