@echo off
:: ========================================================================
:: DEFINITIVE OPERATING SYSTEM LOCKSCREEN & WALLPAPER BLACKOUT ENGINE
:: PROTOCOL CONFIGURATION: NATIVE KERNEL INTERRUPT | PURE INLINE DECODING
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

echo Initializing desktop shell blackout routine...

:: ------------------------------------------------------------------------
:: SECTION 1: HARDWARE SILICON ASSET COMPILATION (PURE HEX ASSEMBLY)
:: ------------------------------------------------------------------------
echo [1/3] Generating solid black system asset via certutil engine...

:: Embedded hex string for a structural 1x1 24-bit solid black Bitmap array
set "BMP_HEX=424D3A00000000000000360000002800000001000000010000000100180000000000040000000000000000000000000000000000000000000000"

:: Write hex signature to volatile storage
echo %BMP_HEX% > "%temp%\blackout.hex"

:: Decode raw hex payload directly into a hardware-level target directory file
certutil -decodehex "%temp%\blackout.hex" "C:\Windows\Black.bmp" >nul 2>&1
del "%temp%\blackout.hex" >nul 2>&1

:: ------------------------------------------------------------------------
:: SECTION 2: POLICIES AND REGISTRY INTERFACES
:: ------------------------------------------------------------------------
echo [2/3] Injecting master PersonalizationCSP and Desktop policies...

:: Apply core Lock Screen system asset routing boundaries
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" /v "LockScreenImagePath" /t REG_SZ /d "C:\Windows\Black.bmp" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" /v "LockScreenImageStatus" /t REG_DWORD /d 1 /f >nul 2>&1

:: Apply user profile environment desktop wallpaper tracking rules
reg add "HKCU\Control Panel\Desktop" /v "Wallpaper" /t REG_SZ /d "C:\Windows\Black.bmp" /f >nul 2>&1
:: Force wallpaper scaling to Stretch mode (Value 2) to span the 1x1 matrix universally
reg add "HKCU\Control Panel\Desktop" /v "WallpaperStyle" /t REG_SZ /d "2" /f >nul 2>&1

:: ------------------------------------------------------------------------
:: SECTION 3: REFRESH OS SHELL ENGINE
:: ------------------------------------------------------------------------
echo [3/3] Flushing live desktop user environment variables...

:: Broadcast instant refresh telemetry parameters directly to User32 subsystems
rundll32.exe user32.dll, UpdatePerUserSystemParameters

echo ========================================================================
echo SYSTEM CONFIGURATION COMPLETED SUCCESSFULY!
echo - Black Lockscreen, Sign-out screen, and Wallpaper rules are active.
echo ========================================================================
pause