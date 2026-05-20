@echo off
:: ========================================================================
:: WINDOWS KERNEL GRAPHICS COMPOSITOR PIPELINE MODIFICATION ENGINE
:: CONFIGURATION: FORCE FLIP TRUE IMMEDIATE PRESENTATION (INDEPENDENT FLIP)
:: PRIVILEGE REQUIREMENT: ADMINISTRATOR ELEVATION ENFORCED
:: ========================================================================

:: Verify administrative execution tokens
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ========================================================================
    echo ERROR: This script must be executed with full Administrator privileges.
    echo Right-click the .bat file and select 'Run as Administrator'.
    echo ========================================================================
    pause
    exit /b
)

echo Initializing low-latency graphics engine registry configuration...

:: Inject the ForceFlipTrueImmediateMode override into the Graphics Drivers Scheduler hive
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "ForceFlipTrueImmediateMode" /t REG_DWORD /d 1 /f >nul 2>&1

if %errorlevel% equ 0 (
    echo ========================================================================
    echo SUCCESS: ForceFlipTrueImmediateMode has been written to the kernel registry!
    echo.
    echo ATTENTION: You MUST restart your computer for the display subsystem to
    echo reload and activate the unthrottled presentation swapchains.
    echo ========================================================================
) else (
    echo ========================================================================
    echo ERROR: Failed to write to the system registry database.
    echo Verify your security software is not locking system keys.
    echo ========================================================================
)

pause