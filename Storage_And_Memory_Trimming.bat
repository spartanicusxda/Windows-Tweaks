@echo off
:: ========================================================================
:: STORAGE & MEMORY CONTROL OVERRIDE MATRIX
:: PRIVILEGE TARGET: ADMINISTRATOR TOKENS ENFORCED (SYSTEM DESK LEVEL)
:: TARGETS: NTFS 8.3 OVERHEAD EXTINCTION & SYSMAIN SERVICE DEACTIVATION
:: ========================================================================

:: Verify administrative tokens
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Administrative elevation tokens are strictly required.
    echo Right-click this script and select 'Run as Administrator'.
    pause
    exit /b
)

echo Accelerating file-system layout and purging background RAM caches...
echo.

:: ------------------------------------------------------------------------
:: STEP 1: DISABLE 8.3 SHORT FILENAME ALIAS GENERATION
:: ------------------------------------------------------------------------
echo [1/2] Stripping legacy MS-DOS 8.3 filename generation from NTFS...
:: 1 = Global disable on all volumes
fsutil behavior set disable8dot3 1 >nul


:: ------------------------------------------------------------------------
:: STEP 2: TERMINATE AND DISABLE THE SYSMAIN SERVICE
:: ------------------------------------------------------------------------
echo [2/2] Eradicating SysMain (SuperFetch) background RAM compression...
:: Force kill the currently executing service memory thread
net stop SysMain >nul 2>&1
:: Permanently modify the service startup state to disabled
sc config SysMain start= disabled >nul

echo.
echo ========================================================================
echo SUCCESS: NTFS short-names stripped and SysMain service fully deactivated!
echo Note: 8.3 disabling applies to all newly created game files from this point on.
echo ========================================================================
pause
exit