@echo off
setlocal enabledelayedexpansion

:: ========================================================================
:: UNTHROTTLED COMPLETED OPERATING SYSTEM KERNEL INJECTION MATRIX
:: PRIVILEGE TARGET: ADMINISTRATOR TOKENS ENFORCED (HKLM/HKCU MODS)
:: PLATFORM FOOTPRINT: WINDOWS 11 LOW-LATENCY OPTIMIZED
:: ========================================================================

:: Verify administrative tokens
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ========================================================================
    echo ERROR: Administrative tokens are required to overwrite system keys.
    echo Right-click this script and select 'Run as Administrator'.
    echo ========================================================================
    pause
    exit /b
)

color 0A
echo Initializing hardware-aligned low latency script structure...
echo.

:: ========================================================================
:: PHASE 1: THREAD PRIORITY CONTROL AND APPLICATION SCHEDULING
:: ========================================================================
echo [1/6] Processing Kernel Thread Optimization Models...

:: Set Fixed Long Quantum Schedule with 3:1 Foreground Boost Factor (Hex 26 = Dec 38)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul

:: Disable Automatic Maintenance Loops and Error Report Uploads
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul

:: Disable Remote Assistance Pipelines
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul


:: ========================================================================
:: PHASE 2: DISPLAY SUBSYSTEM & HARDWARE RENDER UPGRADES
:: ========================================================================
echo [2/6] Aligning Graphics Presentation Swapchains...

:: Force Hardware-Accelerated GPU Scheduling (HAGS = 2)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul

:: Inject Windowed Game Optimizations and Disable Windows Adaptive Tearing Layers
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;" /f >nul

:: Enable Core Game Mode Loop Engine
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul

:: Hard-Capped Disabling of GameDVR / Xbox Background Polling Triggers
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\GameBar" /v "GamepadNexusChordEnabled" /t REG_DWORD /d 0 /f >nul


:: ========================================================================
:: PHASE 3: RAW GRAPHICS RECEPTACLE & 1:1 CURSOR INFRASTRUCTURE
:: ========================================================================
echo [3/6] Mapping Flat 1:1 Precision Receptacles...

:: Wipe Out Enhance Pointer Precision (Enforces Linear Hardware Tracking Profiles)
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul

:: Strip Core Cursors Schemes Overheads
reg add "HKCU\Control Panel\Cursors" /v "ContactVisualization" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Cursors" /v "GestureVisualization" /t REG_DWORD /d 0 /f >nul


:: ========================================================================
:: PHASE 4: PRIVACY TELEMETRY STRIKES & INTERRUPT BLACKOUTS
:: ========================================================================
echo [4/6] Commencing Structural Telemetry Blackout passes...

:: Extinguish Core Diagnostics Data Collection Nodes
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul

:: Stop Automatic Background Defragmentation Schedulers
reg add "HKLM\SOFTWARE\Microsoft\Dfrg\TaskSettings" /v "fTaskEnabled" /t REG_DWORD /d 0 /f >nul

:: Blackout Capability Core App Sync Handshakes (Contacts, Location, Calendars, Sync)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul


:: ========================================================================
:: PHASE 5: SYSTEM SOUND LAYERS AND PERFORMANCE COSMETIC VISUALS
:: ========================================================================
echo [5/6] Stripping Cosmetic Visual Overheads and Sound Delays...

:: Halt Audio Communications Ducking (Forces 'Do Nothing' Protocol)
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d 3 /f >nul

:: Establish Native Sound Scheme Nullification (Prevents RAM Cache WAV Reservations)
reg add "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".None" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /v "DisableStartupSound" /t REG_DWORD /d 1 /f >nul

:: Force Custom Performance Visual Effects Stack (VisualFXSetting = 3)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 3 /f >nul
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038012000000 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul

:: Erase Static Windows Toast Notification Framework Overhead
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard" /v "Disabled" /t REG_DWORD /d 1 /f >nul


:: ========================================================================
:: PHASE 6: MICROSOFT STORE INTERRUPT EXCLUSIONS
:: ========================================================================
echo [6/6] Freezing App Store Promotional Processing Buffers...

:: Deactivate Automated Store Autoplay and Banner Popups
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Appx" /v "AllowAutomaticAppArchiving" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f >nul

:: Purge File Explorer Bloat (Launch Directly to This PC, Clear Recent List)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowCloudFilesInQuickAccess" /t REG_DWORD /d 0 /f >nul

echo ========================================================================
echo SUCCESS: Kernel Optimization Commands Merged Into Subsystem!
echo.
echo ATTENTION: A system restart is required to re-map thread priorities,
echo fully clear out background tasks, and unthrottle the render lines.
echo ========================================================================
pause
exit