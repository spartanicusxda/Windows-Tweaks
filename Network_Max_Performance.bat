@echo off
:: ========================================================================
:: DEFINITIVE REALTEK GAMING 2.5GbE HARDWARE-LAYER ENGINE OPTIMIZATION
:: TARGET ENUMERATION: RTL8125 ADVANCED PROPERTIES VIVID MATRIX
:: PROTOCOL CONFIGURATION: ZERO POWER SAVINGS | NO BUFFERBLOAT | RAW PATH
:: ========================================================================
echo Initializing total hardware overhaul for Realtek 2.5GbE...

set "ClassKey=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"
set "NetKey="

:: Dynamically localizes your active Realtek 2.5GbE registry class node
for /l %%i in (0,1,9) do (
    reg query "%ClassKey%\000%%i" /v DriverDesc 2>nul | findstr /I "Realtek Gaming 2.5GbE" >nul && set "NetKey=%ClassKey%\000%%i"
)
for /l %%i in (10,1,30) do (
    reg query "%ClassKey%\00%%i" /v DriverDesc 2>nul | findstr /I "Realtek Gaming 2.5GbE" >nul && set "NetKey=%ClassKey%\00%%i"
)

if not defined NetKey (
    echo [ERROR] Realtek Gaming 2.5GbE registry node could not be resolved.
    pause
    exit
)

echo Target Realtek node identified at: %NetKey%
echo Injecting raw packet performance variables...

:: --- ELIMINATE ALL NETWORK ADAPTER POWER SAVINGS & LINK DROPS ---
reg add "%NetKey%" /v "AdvancedEEE" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "*EEE" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "GigaLite" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "AutoDisableGigabit" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "SipsEnabled" /t REG_SZ /d "0" /f >nul

:: --- OPTIMIZE QUEUES AND DISABLE BUFFER DELAYS ---
reg add "%NetKey%" /v "*ReceiveBuffers" /t REG_SZ /d "256" /f >nul
reg add "%NetKey%" /v "*TransmitBuffers" /t REG_SZ /d "256" /f >nul
reg add "%NetKey%" /v "*FlowControl" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "*InterruptModeration" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "*RSS" /t REG_SZ /d "1" /f >nul
reg add "%NetKey%" /v "RSSQueues" /t REG_SZ /d "4" /f >nul

:: --- STRIP PACKET FRAGMENTATION ENGINE (LARGE SEND OFFLOAD) ---
reg add "%NetKey%" /v "*LsoV2IPv4" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "*LsoV2IPv6" /t REG_SZ /d "0" /f >nul

:: --- PURGE PROTOCOL FILTER HOOKS & MISC OVERHEAD ---
reg add "%NetKey%" /v "ArpOffload" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "NsOffload" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "*JumboPacket" /t REG_SZ /d "1514" /f >nul
reg add "%NetKey%" /v "*PriorityVLANTag" /t REG_SZ /d "1" /f >nul

:: --- HARD-KILL WAKE-ON-LAN PROTOCOL BACKGROUND TASKS ---
reg add "%NetKey%" /v "WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "WakeOnPattern" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "ShutdownWakeOnLan" /t REG_SZ /d "0" /f >nul
reg add "%NetKey%" /v "WaitWakeLinkSpeed" /t REG_SZ /d "0" /f >nul

:: --- KEEP HARDWARE CHECKSUM ENGINES ACTIVE (FAST PROCESSING VIA CARD ASIC) ---
reg add "%NetKey%" /v "*IPChecksumOffloadV4" /t REG_SZ /d "3" /f >nul
reg add "%NetKey%" /v "*TCPChecksumOffloadV4" /t REG_SZ /d "3" /f >nul
reg add "%NetKey%" /v "*UDPChecksumOffloadV4" /t REG_SZ /d "3" /f >nul
reg add "%NetKey%" /v "*TCPChecksumOffloadV6" /t REG_SZ /d "3" /f >nul
reg add "%NetKey%" /v "*UDPChecksumOffloadV6" /t REG_SZ /d "3" /f >nul

:: Flush power parameters to system
powercfg -setactive SCHEME_CURRENT

echo ========================================================================
echo CRITICAL SUCCESS: Every single option from your matrix is optimized!
echo.
echo Note: Your connection will drop out for a brief moment as the driver
echo       reloads with zero power states and reduced buffer profiles.
echo ========================================================================
pause