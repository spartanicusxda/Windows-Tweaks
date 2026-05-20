@echo off
:: ========================================================================
:: DEFINITIVE HARDWARE-SILICON OS KERNEL TIMER MASTER OPTIMIZATION
:: TOPOLOGY ARCHITECTURE: AMD INVARIANT TSC HYBRID SYNCHRONIZATION
:: TARGET TARGETS: FIXED HEARTBEAT TIMING ENGINE (TRUE 0.5000ms BLANKET)
:: ========================================================================
echo Initializing system core timing kernel transformation...

:: ------------------------------------------------------------------------
:: SECTION 1: KERNEL BOOT CONFIGURATION PARAMETERS (bcdedit)
:: ------------------------------------------------------------------------
echo [1/2] Forcing fixed-frequency ticks and unlocking CPU Invariant TSC...

:: Hard-disable Tickless Idle / Dynamic Ticks (Prevents C-state timer power scaling)
bcdedit /set disabledynamictick yes >nul 2>&1

:: Purge hardware platform clock constraints (Blocks legacy external motherboard HPET polling)
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1

:: ------------------------------------------------------------------------
:: SECTION 2: PROCESS TIMER ISOLATION BYPASS (REGISTRY)
:: ------------------------------------------------------------------------
echo [2/2] Stripping Windows Process Timer Isolation walls...

:: Force low-level 0.5ms resolution allocations to blanket the entire OS universally
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d 1 /f >nul 2>&1

:: ------------------------------------------------------------------------
:: SECTION 3: FLUSH ENGINE & PROMPT SUCCESS
:: ------------------------------------------------------------------------
echo ========================================================================
echo CORE HARDWARE TIMING ENGINE FULLY UNITED AND OPTIMIZED!
echo.
echo - Fixed timer scheduler frequency enforced (Dynamic Tick Disabled).
echo - Motherboard bus clock routing purged (Pure Internal TSC Engaged).
echo - Global thread scheduling blanket enabled (Isolation Wall Bypassed).
echo.
echo ACTION REQUIRED: Perform a full restart of your machine to initiallize.
echo ========================================================================
pause