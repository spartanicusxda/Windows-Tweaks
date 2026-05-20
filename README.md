Navigate to the script directory, right-click the desired optimization file, and select Run as Administrator.

Perform a clean system restart to apply all modifications to the active Windows kernel image.
"""

with open("README.md", "w", encoding="utf-8") as f:
f.write(readme_content.strip())

```python?code_reference&code_event_index=5
readme_content = """# 🚀 Windows 11 Ultra-Low Latency Optimization Suite

A high-performance collection of configuration matrices and automation scripts designed to eliminate kernel-level bottlenecks, stabilize frame pacing (1% lows), and strip hardware polling delays. Cleaned of all private telemetry data and optimized for direct implementation.

> [!WARNING]
> These scripts modify low-level kernel properties, driver parameters, and device power states. Execute individual files as an Administrator and reboot your system to commit updates.

---

## 📂 Feature Matrix

### 🏎️ Kernel, Processor & Scheduler Tuning
* **`Kernel_Timer_Optimization.bat`**: Disables Tickless Idle (Dynamic Ticks), purges external motherboard HPET clock routing, and forces a global 0.5ms system timer resolution via pure CPU Invariant TSC synchronization.
* **`Ryzen_Silicon_Unshackle.bat`**: Overrides CPPC2 energy curves to force a raw performance bias on AMD Ryzen platforms, permanently disables Core Parking, and locks maximum clock frequency states.
* **`Scheduler_Ultimate_Performance.bat`**: Injects a Short, Fixed CPU Quanta length to eliminate process context-switch overhead, sets multimedia responsiveness to 100%, and locks the game subsystem kernel priority class to high.
* **`Advanced_Gaming_Overrides.bat`**: Disables dynamic background power throttling, halts full-screen focus loss from accessibility shortcuts (Sticky/Filter Keys), and grants front-facing windows unthrottled thread execution.
* **`Unthrottled_System_Injections.bat`**: Disables automated background system maintenance tasks, freezes Windows Error Reporting diagnostics, and terminates hidden Remote Assistance background listener threads.

### 🎮 GPU, Storage & Network Infrastructure
* **`Enable_ForceFlipImmediate.bat`**: Injects the `ForceFlipTrueImmediateMode` override into the Graphics Drivers Scheduler hive, enabling unthrottled independent presentation swapchains to minimize input lag.
* **`GPU_Max_Performance.bat`**: Deletes restrictive single-core hardware affinity masks, forces GPU interrupts to high-priority MSI-X message-signaled delivery, and scales calculating threads evenly across CPU cores.
* **`NVMe_Max_Performance.bat`**: Deactivates autonomous NVMe idle power state management (forces PS0 state pinning), removes storage thread affinity constraints, and unlocks parallel hardware queue depth routing.
* **`Network_Max_Performance.bat`**: Maximizes network card performance by disabling Energy Efficient Ethernet (EEE), Green Ethernet, power-saving low-state modes, and Interrupt Moderation while scaling up Receive Side Scaling (RSS) queues.
* **`Optimize_Prefetcher.bat`**: Restricts the Windows Memory Management Prefetch parameters strictly to Application-Only tracking mode, protecting runtime disk I/O bandwidth from boot trace logs.
* **`Storage_And_Memory_Trimming.bat`**: Disables legacy MS-DOS 8.3 short-filename index parsing overhead across NTFS filesystems and permanently deactivates SysMain (SuperFetch) memory compression loops.

### 🖱️ Input Peripherals & USB Low-Latency Locks
* **`USB_Max_Performance.bat`**: Purges legacy core affinity assignment masks from master USB host controllers and globally overwrites system registries to hard-disable native Windows mouse precision/acceleration curves.
* **`HID_Absolute_PowerLock.bat`**: Hard-kills Enhanced Power Management, Selective Suspend, and WDF Idle states across high-polling rate wireless mouse tracking endpoints to block latency cooldown loops.
* **`Keyboard_Absolute_PowerLock.bat`**: Strips low-power controller cooldown states and peripheral controller wake delays across mechanical keyboard controller pipelines to prevent input drops.
* **`Xbox_Controller_PowerLock.bat`**: Bypasses dynamic device idling and Idle-to-D3 sleep states for connected XInput gamepad controller nodes, securing uncompromised bus voltage and zero wake lag.

### ⏱️ Windows Shell, Deployment & Service Trimming
* **`Disable_Startup_Delay.bat`**: Modifies the Explorer shell `Serialize` keys to drop the native application launch timer to 0ms, bypassing background service idling tasks during user desktop log-on.
* **`Fast_Shutdown_Injections.bat`**: Compresses frozen task, user application, and background service termination timeouts down to 1–2 seconds to accelerate desktop reboots.
* **`Disable_System_Restore.bat`**: Bypasses administrative policy lockouts and unlinks the volume tracking filter driver from the C: drive partition, completely neutralizing System Protection background write cycles.
* **`Service_Trimming_Master.bat`**: Permanently cleans up resource-heavy background tasks including Connected User Experiences telemetry (DiagTrack), Diagnostic Policy Services (DPS), and Xbox Live Authorization managers.
* **`Mute_DCOM_Warnings.bat`**: Silences Component Object Model (COM) Activation and Call failure event logging inside the kernel, eliminating diagnostic background logging overhead.
* **`Black_Theme.bat`**: Implements a native inline hex compilation routine to build a solid 1x1 black bitmap array, binding it to the wallpaper, lock screen, and sign-out layouts to eliminate visual asset cache stutter.

---

## 🛠️ Installation & Usage

1. Clone the repository:
