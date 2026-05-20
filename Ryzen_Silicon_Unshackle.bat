@echo off
:: ========================================================================
:: DEFINITIVE HARDWARE-LAYER PROCESSOR SCHEDULER TUNING SCRIPT
:: HARDWARE PLATFORM: AMD RYZEN 7 5800X3D (8C/16T HOMOGENEOUS SINGLE-CCD)
:: ENFORCEMENT STATE: ZERO ENERGY TRACKING | INSTANT CLOCK STATE SCALING
:: ========================================================================
echo Initiating total core scheduler transformation on active plan...

:: Subgroup GUID shortcut for Processor Power Management
set "SUB_CPU=54533251-82be-4824-96c1-47b60b740d00"

:: --- 1. CORE RESPONSE PERFORMANCE SPEEDS ---
echo [1/4] Overriding Energy Performance Preference and Latency Hints...
:: Force raw performance bias over CPPC2 energy curves
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 0
:: Fix Latency Hint Paradox (Command instant max clocks during latency alerts)
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 4b70f900-cdd9-4e66-aa26-ae8417f98173 0
:: Request absolute maximum core scaling performance during latency bursts
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 619b7505-003b-4e82-b7a6-4dd29c300971 100

:: --- 2. KERNEL EVALUATION TIMERS ---
echo [2/4] Speeding up core workload evaluation cycles...
:: Zero out the 30ms Autonomous averaging delay (Instantaneous clock scaling)
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% cfeda3d0-7697-4566-a922-a9086cd49dfa 0
:: Drop kernel check window from 15ms to 1ms (Forces 15x faster thread monitoring)
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 4d2b0152-7d5c-498b-88e2-34345392a2c5 1

:: --- 3. FREQUENCY STEPPING AND BURST MANAGEMENT ---
echo [3/4] Tuning frequency scaling p-state thresholds...
:: Set workload increase threshold to 0% (Any activity forces an immediate boost)
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 06cadf0e-64ed-448a-8927-ce7bf90eb35d 0
:: Set decrease threshold to 100% (Prevents rapid frequency drops during short idle gaps)
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 12a0ab44-fe28-4fa9-b3bd-4b64f44960a6 100
:: Max out hardware performance boost policy headroom
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 45bcc044-d885-43e2-8605-ee0ec6e96b59 100
:: Force Rocket/Single-Step frequency increases (Direct jump to maximum clocks)
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 465e1f50-b610-473a-ab58-00d1077dc418 1
:: Set high confirmation history to delay core downclocking
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% d8edeb9b-95cf-4f95-a73c-b061973693c8 100
:: Freeze legacy ACPI duty-cycling and hardware clock throttling flags
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0

:: --- 4. HARD CORE LOCKS AND LIMITS ---
echo [4/4] Hard-locking operating limits and power states...
:: Set minimum and maximum processor state states to 100%
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 893dee8e-2bef-41e0-89c6-b55d0929964c 100
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% bc5038f7-23e0-4960-96da-33abaf5935ec 100
:: Lock Core Parking min/max boundaries to 100% (Permanently strips parking out)
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 0cc5b647-c1df-4637-891a-dec35c318583 100
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% ea062031-0e34-4ff1-9b6d-eb1059334028 100
:: Keep native C-States enabled (Value 0) to ensure Precision Boost remains fully functional
powercfg -setacvalueindex SCHEME_CURRENT %SUB_CPU% 5d76a2ca-e8c0-402f-a133-2158492d58ad 0

:: Mount and apply all changes to the active kernel
powercfg -setactive SCHEME_CURRENT

echo ========================================================================
echo SUCCESS: Your Ryzen 7 5800X3D scheduler core is fully optimized!
echo Core parking, power-saving delays, and clock ramp limits are removed.
echo Precision Boost remains fully active to supply maximum performance.
echo ========================================================================
pause