---
title: "Tìm hiểu các Process hệ thống Windows 11"
date: 2024-10-14 01:47:31 +0700
categories: [Notes, Windows]
tags: [windows 11, process]
pin: false
comments: false
published: false
---

# Danh sách đầy đủ và chi tiết các Process hệ thống Windows 11

## Giới thiệu

Windows 11 chạy hàng trăm process khác nhau để duy trì hoạt động của hệ thống. Bài viết này cung cấp danh sách chi tiết và đầy đủ nhất về tất cả các process hệ thống, giúp bạn hiểu rõ chức năng, mức độ quan trọng và cách quản lý chúng.

## A. CORE SYSTEM PROCESSES (Các Process hệ thống cốt lõi)

### 1. System Idle Process
- **File thực thi**: Không có (Virtual process)
- **Đường dẫn**: N/A
- **Mô tả**: Process ảo hiển thị tỷ lệ CPU không sử dụng
- **PID**: Thường là 0
- **Parent Process**: Không có
- **CPU Usage**: Cao khi hệ thống rảnh (bình thường)
- **Memory Usage**: 0 KB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Ghi chú**: Đây không phải process thực sự, CPU% cao là điều tốt

### 2. System
- **File thực thi**: ntoskrnl.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows NT Kernel và System
- **PID**: Thường là 4
- **Parent Process**: Không có
- **CPU Usage**: 0-5% (bình thường)
- **Memory Usage**: 100-500 MB
- **Có thể tắt**: KHÔNG (sẽ BSOD)
- **Mức độ quan trọng**: Critical
- **Chức năng**: 
  - Quản lý memory
  - I/O operations
  - System calls
  - Hardware abstraction
  - Kernel mode operations

### 3. Registry
- **File thực thi**: Không có (Kernel process)
- **Đường dẫn**: Kernel space
- **Mô tả**: Windows Registry subsystem
- **PID**: Thường là 72-120
- **Parent Process**: System
- **CPU Usage**: 0-1%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**: Quản lý Windows Registry database

### 4. smss.exe (Session Manager Subsystem)
- **File thực thi**: smss.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Session Manager khởi tạo user sessions
- **Parent Process**: System
- **CPU Usage**: 0%
- **Memory Usage**: 1-5 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - Khởi tạo user sessions
  - Tạo page files
  - Chạy các subsystem processes

### 5. csrss.exe (Client Server Runtime Process)
- **File thực thi**: csrss.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Client Server Runtime Subsystem
- **Parent Process**: smss.exe
- **CPU Usage**: 0-2%
- **Memory Usage**: 10-30 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - Win32 console handling
  - Process và thread management
  - Shutdown functions
  - CreateProcess API

### 6. wininit.exe (Windows Initialization Process)
- **File thực thi**: wininit.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Initialization Process
- **Parent Process**: smss.exe
- **CPU Usage**: 0%
- **Memory Usage**: 3-10 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - Khởi động services.exe
  - Khởi động lsass.exe
  - Khởi động lsm.exe

### 7. winlogon.exe (Windows Logon Process)
- **File thực thi**: winlogon.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Logon Application
- **Parent Process**: smss.exe
- **CPU Usage**: 0-1%
- **Memory Usage**: 5-15 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - User logon/logoff
  - Secure Attention Sequence (Ctrl+Alt+Del)
  - Loading user profile
  - Screen saver management

## B. SERVICE MANAGEMENT PROCESSES

### 8. services.exe (Service Control Manager)
- **File thực thi**: services.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Services và Controller app
- **Parent Process**: wininit.exe
- **CPU Usage**: 0-2%
- **Memory Usage**: 10-30 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - Khởi động, dừng, quản lý Windows services
  - Service database management
  - Service dependencies

### 9. svchost.exe (Service Host Process)
- **File thực thi**: svchost.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Generic Host Process for Win32 Services
- **Parent Process**: services.exe
- **Instances**: 15-30+ processes
- **CPU Usage**: Varies (0-50% per instance)
- **Memory Usage**: 10-200 MB per instance
- **Có thể tắt**: Một số có thể (cẩn thận)
- **Mức độ quan trọng**: Critical to High
- **Services thường chạy**:
  - **AudioSrv**: Windows Audio service
  - **BITS**: Background Intelligent Transfer Service
  - **BrokerInfrastructure**: Background Tasks Infrastructure Service
  - **CryptSvc**: Cryptographic Services
  - **DcomLaunch**: DCOM Server Process Launcher
  - **Dhcp**: DHCP Client
  - **Dnscache**: DNS Client
  - **EventLog**: Windows Event Log
  - **EventSystem**: COM+ Event System
  - **FontCache**: Windows Font Cache Service
  - **LanmanServer**: Server service
  - **LanmanWorkstation**: Workstation service
  - **MMCSS**: Multimedia Class Scheduler
  - **NlaSvc**: Network Location Awareness
  - **nsi**: Network Store Interface Service
  - **PcaSvc**: Program Compatibility Assistant Service
  - **PlugPlay**: Plug and Play service
  - **PolicyAgent**: IPsec Policy Agent
  - **Power**: Power service
  - **ProfSvc**: User Profile Service
  - **RpcEptMapper**: RPC Endpoint Mapper
  - **RpcSs**: Remote Procedure Call (RPC)
  - **SamSs**: Security Accounts Manager
  - **Schedule**: Task Scheduler
  - **seclogon**: Secondary Logon
  - **SENS**: System Event Notification Service
  - **SessionEnv**: Terminal Services Configuration
  - **ShellHWDetection**: Shell Hardware Detection
  - **Spooler**: Print Spooler
  - **Themes**: Themes service
  - **TrkWks**: Distributed Link Tracking Client
  - **UxSms**: Desktop Window Manager Session Manager
  - **Winmgmt**: Windows Management Instrumentation
  - **WinRM**: Windows Remote Management
  - **Wlansvc**: WLAN AutoConfig
  - **WSearch**: Windows Search

### 10. lsass.exe (Local Security Authority Subsystem)
- **File thực thi**: lsass.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Local Security Authority Process
- **Parent Process**: wininit.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 20-100 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - Authentication policies
  - Password changes
  - Access tokens
  - User rights assignments
  - Security auditing

## C. USER INTERFACE PROCESSES

### 11. explorer.exe (Windows Explorer)
- **File thực thi**: explorer.exe
- **Đường dẫn**: C:\Windows\
- **Mô tả**: Windows Explorer/Shell
- **Parent Process**: winlogon.exe (thông qua userinit.exe)
- **CPU Usage**: 1-10%
- **Memory Usage**: 50-200 MB
- **Có thể tắt**: CÓ (có thể restart)
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Desktop shell
  - Taskbar và Start Menu
  - File Explorer
  - System tray
  - Desktop icons

### 12. dwm.exe (Desktop Window Manager)
- **File thực thi**: dwm.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Desktop Window Manager
- **Parent Process**: winlogon.exe
- **CPU Usage**: 0-15%
- **Memory Usage**: 50-300 MB
- **GPU Usage**: Moderate to High
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Window composition
  - Aero Glass effects
  - Window animations
  - Transparency effects
  - Multiple monitor support

### 13. ShellExperienceHost.exe
- **File thực thi**: ShellExperienceHost.exe
- **Đường dẫn**: C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\
- **Mô tả**: Shell Experience Host cho Windows 11
- **Parent Process**: svchost.exe
- **CPU Usage**: 1-5%
- **Memory Usage**: 30-100 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Start Menu
  - Widgets panel
  - Notification Center
  - Action Center

### 14. StartMenuExperienceHost.exe
- **File thực thi**: StartMenuExperienceHost.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\
- **Mô tả**: Start Menu Experience Host
- **Parent Process**: ApplicationFrameHost.exe
- **CPU Usage**: 0-3%
- **Memory Usage**: 20-80 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**: Start Menu functionality

### 15. SearchHost.exe
- **File thực thi**: SearchHost.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\
- **Mô tả**: Search Host Process
- **Parent Process**: RuntimeBroker.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 30-150 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Medium
- **Chức năng**: Windows Search UI

### 16. TextInputHost.exe
- **File thực thi**: TextInputHost.exe
- **Đường dẫn**: C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\
- **Mô tả**: Text Input Host
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-2%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: Medium
- **Chức năng**:
  - Touch keyboard
  - Handwriting panel
  - IME support

## D. SECURITY PROCESSES

### 17. MsMpEng.exe (Windows Defender Antimalware)
- **File thực thi**: MsMpEng.exe
- **Đường dẫn**: C:\ProgramData\Microsoft\Windows Defender\Platform\[version]\
- **Mô tả**: Windows Defender Antimalware Service
- **Parent Process**: services.exe
- **CPU Usage**: 0-50% (có thể cao khi scan)
- **Memory Usage**: 100-500 MB
- **Có thể tắt**: CÓ (không khuyến khích)
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Real-time protection
  - Malware scanning
  - Threat detection
  - Quarantine management

### 18. NisSrv.exe (Network Inspection Service)
- **File thực thi**: NisSrv.exe
- **Đường dẫn**: C:\ProgramData\Microsoft\Windows Defender\Platform\[version]\
- **Mô tả**: Windows Defender Network Inspection Service
- **Parent Process**: services.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Medium
- **Chức năng**: Network traffic inspection

### 19. SecurityHealthSystray.exe
- **File thực thi**: SecurityHealthSystray.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Security System Tray
- **Parent Process**: explorer.exe
- **CPU Usage**: 0-1%
- **Memory Usage**: 10-30 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Medium
- **Chức năng**: Security status notifications

### 20. SecurityHealthService.exe
- **File thực thi**: SecurityHealthService.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Security Health Service
- **Parent Process**: services.exe
- **CPU Usage**: 0-2%
- **Memory Usage**: 5-20 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**: Security center management

## E. NETWORK PROCESSES

### 21. NetworkUXBroker.exe
- **File thực thi**: NetworkUXBroker.exe
- **Đường dẉn**: C:\Windows\System32\
- **Mô tả**: Network UX Broker
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-2%
- **Memory Usage**: 5-20 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: Medium
- **Chức năng**: Network connection UI

### 22. dasHost.exe (Device Association Service Host)
- **File thực thi**: dasHost.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Device Association Service Host
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-1%
- **Memory Usage**: 5-15 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Device pairing và connection

### 23. WinNetMon.exe
- **File thực thi**: WinNetMon.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Network Data Usage Monitor
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-1%
- **Memory Usage**: 5-15 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Network data usage tracking

## F. AUDIO PROCESSES

### 24. audiodg.exe (Windows Audio Device Graph Isolation)
- **File thực thi**: audiodg.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Audio Device Graph Isolation
- **Parent Process**: Không có parent trực tiếp
- **CPU Usage**: 0-20% (có thể cao)
- **Memory Usage**: 10-100 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Audio stream processing
  - Audio effects processing
  - Audio driver isolation
  - Per-application audio processing

### 25. AudioSrv (trong svchost.exe)
- **Service Name**: AudioSrv
- **Display Name**: Windows Audio
- **Mô tả**: Windows Audio Service
- **CPU Usage**: 0-5%
- **Memory Usage**: Shared with svchost.exe
- **Có thể tắt**: CÓ (mất audio)
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Audio device management
  - Volume control
  - Audio routing

### 26. AudioEndpointBuilder (trong svchost.exe)
- **Service Name**: AudioEndpointBuilder
- **Display Name**: Windows Audio Endpoint Builder
- **Mô tả**: Audio Endpoint Builder Service
- **CPU Usage**: 0-2%
- **Memory Usage**: Shared with svchost.exe
- **Có thể tắt**: CÓ (ảnh hưởng audio)
- **Mức độ quan trọng**: High
- **Chức năng**: Audio endpoint management

## G. UPDATE VÀ MAINTENANCE PROCESSES

### 27. TiWorker.exe (Windows Modules Installer Worker)
- **File thực thi**: TiWorker.exe
- **Đường dẫn**: C:\Windows\winsxs\
- **Mô tả**: Windows Modules Installer Worker
- **Parent Process**: services.exe
- **CPU Usage**: 0-100% (khi hoạt động)
- **Memory Usage**: 50-500 MB
- **Disk Usage**: Rất cao khi hoạt động
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Windows Update installation
  - Optional features installation
  - Component cleanup
  - System file maintenance

### 28. wuauclt.exe (Windows Update AutoUpdate Client)
- **File thực thi**: wuauclt.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Update AutoUpdate Client
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-30%
- **Memory Usage**: 20-100 MB
- **Có thể tắt**: CÓ (mất auto update)
- **Mức độ quan trọng**: High
- **Chức năng**: Windows Update client operations

### 29. UsoClient.exe (Update Session Orchestrator Client)
- **File thực thi**: UsoClient.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Update Session Orchestrator Client
- **Parent Process**: services.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**: Update orchestration và scheduling

### 30. MaintenanceService.exe
- **File thực thi**: MaintenanceService.exe
- **Đường dẫn**: C:\Program Files\Mozilla Maintenance Service\ (nếu có Firefox)
- **Mô tả**: Mozilla Maintenance Service
- **Parent Process**: services.exe
- **CPU Usage**: 0%
- **Memory Usage**: 1-5 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Firefox update service

## H. STORAGE VÀ FILE SYSTEM PROCESSES

### 31. SearchIndexer.exe (Windows Search Indexer)
- **File thực thi**: SearchIndexer.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Microsoft Windows Search Indexer
- **Parent Process**: services.exe
- **CPU Usage**: 0-50% (khi indexing)
- **Memory Usage**: 50-500 MB
- **Disk Usage**: Cao khi indexing
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Medium
- **Chức năng**:
  - File content indexing
  - Search database maintenance
  - Metadata extraction

### 32. SearchProtocolHost.exe
- **File thực thi**: SearchProtocolHost.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Microsoft Windows Search Protocol Host
- **Parent Process**: SearchIndexer.exe
- **CPU Usage**: 0-20%
- **Memory Usage**: 10-100 MB
- **Có thể tắt**: Tự động tắt
- **Mức độ quan trọng**: Medium
- **Chức năng**: File parsing cho search index

### 33. SearchFilterHost.exe
- **File thực thi**: SearchFilterHost.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Microsoft Windows Search Filter Host
- **Parent Process**: SearchIndexer.exe
- **CPU Usage**: 0-30%
- **Memory Usage**: 10-200 MB
- **Có thể tắt**: Tự động tắt
- **Mức độ quan trọng**: Medium
- **Chức năng**: Content filtering và extraction

### 34. defrag.exe
- **File thực thi**: defrag.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Disk Defragmenter Utility
- **Parent Process**: taskeng.exe hoặc svchost.exe
- **CPU Usage**: 0-20%
- **Memory Usage**: 10-50 MB
- **Disk Usage**: Rất cao khi chạy
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Medium
- **Chức năng**: Disk defragmentation và optimization

## I. MICROSOFT EDGE PROCESSES

### 35. msedge.exe (Microsoft Edge Browser)
- **File thực thi**: msedge.exe
- **Đường dẫn**: C:\Program Files (x86)\Microsoft\Edge\Application\
- **Mô tả**: Microsoft Edge Web Browser
- **Parent Process**: Nhiều instances
- **Architecture**: Multi-process (như Chrome)
- **CPU Usage**: 0-100% (tùy usage)
- **Memory Usage**: 50-1000+ MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low to Medium
- **Process types**:
  - **Browser Process**: Main browser process
  - **Renderer Process**: Tab content rendering
  - **GPU Process**: Hardware acceleration
  - **Utility Process**: Various helper functions
  - **Extension Process**: Extension hosting

### 36. msedgewebview2.exe (WebView2 Runtime)
- **File thực thi**: msedgewebview2.exe
- **Đường dẫn**: C:\Program Files (x86)\Microsoft\EdgeWebView\Application\
- **Mô tả**: Microsoft Edge WebView2 Runtime
- **Parent Process**: Varies
- **CPU Usage**: 0-50%
- **Memory Usage**: 20-200 MB
- **Có thể tắt**: CÓ (có thể ảnh hưởng apps)
- **Mức độ quan trọng**: Medium
- **Chức năng**: Embedded web content trong apps

## J. RUNTIME VÀ BROKER PROCESSES

### 37. RuntimeBroker.exe
- **File thực thi**: RuntimeBroker.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Runtime Broker
- **Parent Process**: svchost.exe
- **Instances**: Multiple
- **CPU Usage**: 0-30% per instance
- **Memory Usage**: 10-100 MB per instance
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**:
  - Universal Windows Platform (UWP) app permissions
  - API access brokering
  - Resource management for store apps

### 38. ApplicationFrameHost.exe
- **File thực thi**: ApplicationFrameHost.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Application Frame Host
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-20%
- **Memory Usage**: 20-200 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: Medium
- **Chức năng**: UWP app window management

### 39. SystemSettingsBroker.exe
- **File thực thi**: SystemSettingsBroker.exe
- **Đường dẫn**: C:\Windows\ImmersiveControlPanel\
- **Mô tả**: System Settings Broker
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Medium
- **Chức năng**: Windows Settings app broker

### 40. backgroundTaskHost.exe
- **File thực thi**: backgroundTaskHost.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Background Task Host
- **Parent Process**: svchost.exe
- **Instances**: Multiple
- **CPU Usage**: 0-20% per instance
- **Memory Usage**: 5-50 MB per instance
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: Medium
- **Chức năng**: Background tasks cho UWP apps

## K. SYSTEM MONITORING VÀ WMI PROCESSES

### 41. WmiPrvSE.exe (WMI Provider Host)
- **File thực thi**: WmiPrvSE.exe
- **Đường dẫn**: C:\Windows\System32\wbem\
- **Mô tả**: WMI Provider Host
- **Parent Process**: svchost.exe (Winmgmt)
- **Instances**: Multiple
- **CPU Usage**: 0-50% per instance
- **Memory Usage**: 10-200 MB per instance
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**:
  - WMI data collection
  - System monitoring
  - Management interface
  - Performance counters

### 42. taskhostw.exe (Task Host Window)
- **File thực thi**: taskhostw.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Host Process for Windows Tasks
- **Parent Process**: services.exe
- **Instances**: Multiple
- **CPU Usage**: 0-20%
- **Memory Usage**: 5-50 MB
- **Có thể tắt**: Tự động (task-dependent)
- **Mức độ quan trọng**: Medium
- **Chức năng**: Host cho Windows scheduled tasks

### 43. dllhost.exe (COM+ Surrogate)
- **File thực thi**: dllhost.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: COM+ Surrogate Process
- **Parent Process**: Varies
- **Instances**: Multiple
- **CPU Usage**: 0-30%
- **Memory Usage**: 5-100 MB
- **Có thể tắt**: Tự động
- **Mức độ quan trọng**: Medium
- **Chức năng**:
  - COM+ component hosting
  - Thumbnail generation
  - File property extraction

## L. PRINT VÀ SPOOLER PROCESSES

### 44. spoolsv.exe (Print Spooler)
- **File thực thi**: spoolsv.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Print Spooler Service
- **Parent Process**: services.exe
- **CPU Usage**: 0-20%
- **Memory Usage**: 10-100 MB
- **Có thể tắt**: CÓ (mất print function)
- **Mức độ quan trọng**: Medium
- **Chức năng**:
  - Print job management
  - Printer driver hosting
  - Print queue management

### 45. splwow64.exe (Print Driver Host)
- **File thực thi**: splwow64.exe
- **Đường dẫn**: C:\Windows\splwow64\
- **Mô tả**: Print Driver Host for Applications
- **Parent Process**: spoolsv.exe
- **CPU Usage**: 0-30%
- **Memory Usage**: 5-50 MB
- **Có thể tắt**: Tự động
- **Mức độ quan trọng**: Medium
- **Chức năng**: 32-bit print driver hosting

## M. GAMING VÀ GRAPHICS PROCESSES

### 46. GameBarPresenceWriter.exe
- **File thực thi**: GameBarPresenceWriter.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Game Bar Presence Writer
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 5-20 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Game activity tracking

### 47. GameBar.exe
- **File thực thi**: GameBar.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.Xbox.TCUI_8wekyb3d8bbwe\
- **Mô tả**: Xbox Game Bar
- **Parent Process**: RuntimeBroker.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 20-100 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**:
  - Game overlay
  - Screen recording
  - Screenshots
  - Performance monitoring

### 48. XblGameSave.exe
- **File thực thi**: XblGameSave.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Xbox Live Game Save Service
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 5-30 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Xbox game save synchronization

## N. COMMUNICATION VÀ NOTIFICATION PROCESSES

### 49. PhoneExperienceHost.exe
- **File thực thi**: PhoneExperienceHost.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.Windows.PhoneExperienceHost_8wekyb3d8bbwe\
- **Mô tả**: Phone Experience Host
- **Parent Process**: ApplicationFrameHost.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 20-80 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Phone integration features

### 50. SkypeHost.exe
- **File thực thi**: SkypeHost.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.SkypeApp_kzf8qxf38zg5c\
- **Mô tả**: Skype UWP Host
- **Parent Process**: ApplicationFrameHost.exe
- **CPU Usage**: 0-20%
- **Memory Usage**: 30-150 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Skype application host

### 51. YourPhone.exe
- **File thực thi**: YourPhone.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.YourPhone_8wekyb3d8bbwe\
- **Mô tả**: Your Phone Companion
- **Parent Process**: ApplicationFrameHost.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 50-200 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Phone-PC integration

## O. ACCESSIBILITY VÀ INPUT PROCESSES

### 52. osk.exe (On-Screen Keyboard)
- **File thực thi**: osk.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: On-Screen Keyboard
- **Parent Process**: explorer.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 10-30 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Virtual keyboard

### 53. narrator.exe
- **File thực thi**: Narrator.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Microsoft Narrator
- **Parent Process**: explorer.exe
- **CPU Usage**: 0-15%
- **Memory Usage**: 20-100 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Screen reader for accessibility

### 54. magnify.exe
- **File thực thi**: magnify.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Microsoft Magnifier
- **Parent Process**: explorer.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Screen magnification tool

## P. DRIVER VÀ HARDWARE PROCESSES

### 55. DriverStore File Repository
- **Service Name**: TrustedInstaller
- **File thực thi**: TiWorker.exe, TrustedInstaller.exe
- **Đường dẫn**: C:\Windows\servicing\
- **Mô tả**: Windows Modules Installer
- **Parent Process**: services.exe
- **CPU Usage**: 0-100% (khi hoạt động)
- **Memory Usage**: 50-500 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - Driver installation
  - System component updates
  - Windows features management

### 56. PnPUtil.exe
- **File thực thi**: PnPUtil.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Plug and Play Utility
- **Parent Process**: Varies
- **CPU Usage**: 0-20%
- **Memory Usage**: 5-20 MB
- **Có thể tắt**: Tự động
- **Mức độ quan trọng**: Medium
- **Chức năng**: Driver package management

### 57. DeviceCensus.exe
- **File thực thi**: DeviceCensus.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Device Census
- **Parent Process**: Task Scheduler
- **CPU Usage**: 0-30%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Hardware inventory collection

## Q. TELEMETRY VÀ DIAGNOSTIC PROCESSES

### 58. DiagTrack.exe (Connected User Experiences and Telemetry)
- **File thực thi**: Chạy trong svchost.exe
- **Service Name**: DiagTrack
- **Mô tả**: Connected User Experiences and Telemetry
- **Parent Process**: services.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 20-100 MB
- **Có thể tắt**: CÓ (có thể disable)
- **Mức độ quan trọng**: Low
- **Chức năng**: Telemetry data collection

### 59. CompatTelRunner.exe (Microsoft Compatibility Telemetry)
- **File thực thi**: CompatTelRunner.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Microsoft Compatibility Telemetry
- **Parent Process**: Task Scheduler
- **CPU Usage**: 0-50% (khi chạy)
- **Memory Usage**: 50-300 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Compatibility data collection

### 60. WerFault.exe (Windows Error Reporting)
- **File thực thi**: WerFault.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Error Reporting
- **Parent Process**: svchost.exe
- **CPU Usage**: 0-30%
- **Memory Usage**: 10-100 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Medium
- **Chức năng**: Error report generation và submission

## R. CORTANA VÀ AI PROCESSES

### 61. SearchUI.exe (Cortana)
- **File thực thi**: SearchUI.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\
- **Mô tả**: Cortana Search UI
- **Parent Process**: ApplicationFrameHost.exe
- **CPU Usage**: 0-20%
- **Memory Usage**: 50-200 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**:
  - Voice assistant
  - Search interface
  - AI-powered assistance

### 62. CortanaUI.exe
- **File thực thi**: CortanaUI.exe
- **Đường dẫn**: C:\Windows\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\
- **Mô tả**: Cortana UI Process
- **Parent Process**: ApplicationFrameHost.exe
- **CPU Usage**: 0-15%
- **Memory Usage**: 30-150 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Cortana user interface

## S. CLOUD VÀ SYNC PROCESSES

### 63. OneDrive.exe
- **File thực thi**: OneDrive.exe
- **Đường dẫn**: C:\Users\[Username]\AppData\Local\Microsoft\OneDrive\
- **Mô tả**: Microsoft OneDrive
- **Parent Process**: explorer.exe
- **CPU Usage**: 0-30%
- **Memory Usage**: 50-300 MB
- **Network Usage**: Variable
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low to Medium
- **Chức năng**:
  - File synchronization
  - Cloud storage access
  - Backup functionality

### 64. FileCoAuth.exe
- **File thực thi**: FileCoAuth.exe
- **Đường dẫn**: C:\Users\[Username]\AppData\Local\Microsoft\OneDrive\
- **Mô tả**: Microsoft OneDrive File CoAuthoring
- **Parent Process**: OneDrive.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trợng**: Low
- **Chức năng**: Real-time collaboration support

## T. VIRTUALIZATION VÀ HYPER-V PROCESSES

### 65. vmms.exe (Virtual Machine Management Service)
- **File thực thi**: vmms.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Hyper-V Virtual Machine Management Service
- **Parent Process**: services.exe
- **CPU Usage**: 0-20%
- **Memory Usage**: 50-500 MB
- **Có thể tắt**: CÓ (nếu không dùng Hyper-V)
- **Mức độ quan trọng**: Medium (nếu dùng virtualization)
- **Chức năng**: Hyper-V VM management

### 66. vmwp.exe (Virtual Machine Worker Process)
- **File thực thi**: vmwp.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Hyper-V Worker Process
- **Parent Process**: vmms.exe
- **Instances**: One per VM
- **CPU Usage**: Variable (depends on VM load)
- **Memory Usage**: Variable (VM memory allocation)
- **Có thể tắt**: CÓ (sẽ tắt VM)
- **Mức độ quan trọng**: Medium
- **Chức năng**: Individual VM execution

### 67. VBoxSVC.exe (VirtualBox Service)
- **File thực thi**: VBoxSVC.exe
- **Đường dẫn**: C:\Program Files\Oracle\VirtualBox\
- **Mô tả**: VirtualBox Service
- **Parent Process**: services.exe
- **CPU Usage**: 0-10%
- **Memory Usage**: 20-100 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low (third-party)
- **Chức năng**: VirtualBox VM management

## U. ADDITIONAL SYSTEM PROCESSES

### 68. consent.exe (User Account Control)
- **File thực thi**: consent.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: User Account Control Consent UI
- **Parent Process**: winlogon.exe
- **CPU Usage**: 0% (khi không active)
- **Memory Usage**: 0-20 MB
- **Có thể tắt**: KHÔNG nên
- **Mức độ quan trọng**: High
- **Chức năng**: UAC elevation prompts

### 69. LogonUI.exe
- **File thực thi**: LogonUI.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Windows Logon User Interface Host
- **Parent Process**: winlogon.exe
- **CPU Usage**: 0-5%
- **Memory Usage**: 10-50 MB
- **Có thể tắt**: KHÔNG
- **Mức độ quan trọng**: Critical
- **Chức năng**: Login screen interface

### 70. userinit.exe
- **File thực thi**: userinit.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Userinit Logon Application
- **Parent Process**: winlogon.exe
- **CPU Usage**: 0% (sau khi complete)
- **Memory Usage**: 0 MB (exits after startup)
- **Có thể tắt**: Tự động exit
- **Mức độ quan trọng**: Critical
- **Chức năng**:
  - User profile loading
  - Shell startup (explorer.exe)
  - Logon scripts execution

### 72. rdpclip.exe (Remote Desktop Clipboard)
- **File thực thi**: rdpclip.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: RDP Clipboard Monitor
- **Parent Process**: Varies
- **CPU Usage**: 0-2%
- **Memory Usage**: 5-20 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Clipboard sharing trong RDP sessions

### 73. mstsc.exe (Remote Desktop Connection)
- **File thực thi**: mstsc.exe
- **Đường dẫn**: C:\Windows\System32\
- **Mô tả**: Remote Desktop Connection
- **Parent Process**: explorer.exe
- **CPU Usage**: 0-30%
- **Memory Usage**: 20-200 MB
- **Có thể tắt**: CÓ
- **Mức độ quan trọng**: Low
- **Chức năng**: Remote desktop client

## TROUBLESHOOTING VÀ PERFORMANCE ANALYSIS

### Công cụ phân tích Process

#### 1. Task Manager (taskmgr.exe)
- **Shortcut**: Ctrl + Shift + Esc
- **Tính năng**:
  - CPU, Memory, Disk, Network usage
  - Process details và command lines
  - Services management
  - Startup programs
  - Performance graphs
  - User sessions

#### 2. Resource Monitor (resmon.exe)
- **Mở từ**: Task Manager > Performance > Open Resource Monitor
- **Tính năng**:
  - Detailed resource usage per process
  - File handles và network connections
  - Disk activity monitoring
  - Memory usage breakdown

#### 3. Process Explorer (Microsoft Sysinternals)
- **Download**: [Microsoft Sysinternals Suite](https://learn.microsoft.com/en-us/sysinternals/downloads/)
- **Tính năng**:
  - Process tree hierarchy
  - DLL dependencies
  - Handle information
  - Process strings
  - Virus Total integration
  - Replace Task Manager option

#### 4. Performance Toolkit (WPT)
- **Component**: Windows SDK
- **Tools**:
  - **WPA (Windows Performance Analyzer)**
  - **WPR (Windows Performance Recorder)**
  - **Xperf** command line tools

### Common Performance Issues

#### High CPU Usage Scenarios

**1. TiWorker.exe (100% CPU)**
- **Nguyên nhân**: Windows Update installation
- **Giải pháp**: 
  - Chờ complete (có thể mất vài giờ)
  - Check Windows Update status
  - Restart if stuck > 4 hours
  - Run Windows Update Troubleshooter

**2. SearchIndexer.exe (High CPU)**
- **Nguyên nhân**: Indexing large number of files
- **Giải pháp**:
  - Temporary disable Windows Search
  - Add exclusions for large folders
  - Rebuild search index
  - Schedule indexing during off-hours

**3. MsMpEng.exe (High CPU)**
- **Nguyên nhân**: Windows Defender scanning
- **Giải pháp**:
  - Add exclusions for trusted folders
  - Schedule scans for low-usage times
  - Check for conflicting antivirus
  - Temporary disable real-time protection

**4. svchost.exe (Multiple high usage)**
- **Nguyên nhân**: Various services in same host
- **Giải pháp**:
  - Identify problematic service: `tasklist /svc`
  - Use Resource Monitor for details
  - Restart specific services
  - Check Windows Updates

#### High Memory Usage Scenarios

**1. explorer.exe (High Memory)**
- **Nguyên nhân**: 
  - Memory leaks
  - Too many file thumbnails
  - Corrupted shell extensions
- **Giải pháp**:
  - Restart explorer.exe
  - Disable thumbnail generation
  - Boot in Safe Mode to test
  - Check for shell extension conflicts

**2. Multiple svchost.exe (High Memory)**
- **Nguyên nhân**: Service memory leaks
- **Giải pháp**:
  - Identify services: Process Explorer
  - Restart problematic services
  - Check Event Logs for errors
  - Memory dump analysis

**3. RuntimeBroker.exe (High Memory)**
- **Nguyên nhân**: UWP app issues
- **Giải pháp**:
  - Close UWP apps
  - Reset Windows Store apps
  - Check background app permissions
  - Disable problematic store apps

#### Disk Usage 100% Scenarios

**1. System Process (High Disk)**
- **Nguyên nhân**:
  - Page file activity
  - System file corruption
  - Driver issues
- **Giải pháp**:
  - Run `chkdsk /f`
  - Check page file settings
  - Update drivers
  - Run `sfc /scannow`

**2. Antimalware Service Executable**
- **Nguyên nhân**: Real-time scanning
- **Giải pháp**:
  - Add exclusions
  - Schedule scans
  - Check for conflicts
  - Limit CPU usage in Windows Defender

### Security Analysis

#### Identifying Malicious Processes

**Red Flags:**
1. **Unusual locations**: Tiến trình chạy từ thư mục %temp%, %appdata%
2. **Misspelled names**: Ví dụ "scvhost.exe" thay vì "svchost.exe"
3. **Multiple instances**: Có quá nhiều tiến trình cùng tên
4. **High network activity**: Có kết nối ra ngoài không mong đợi
5. **Missing digital signatures**: File thực thi không có chữ ký
6. **Unusual parent-child relationships**: Tiến trình cha không đúng

**Verification Steps:**
1. **Check file location**: Right-click > Open file location
2. **Verify digital signature**: Properties (Thuộc tính) > Digital Signatures (Chữ ký số)
3. **Upload to VirusTotal**: Kiểm tra độ uy tín của hash
4. **Check process arguments**: Process Explorer > Properties
5. **Monitor network activity**: Resource Monitor > Network tab

#### Common Malware Process Names
- **Fake svchost.exe**: Không nằm trong System32, tiến trình cha sai
- **Fake explorer.exe**: Nhiều phiên bản, vị trí sai
- **Random names**: File thực thi có tên vô nghĩa
- **System impersonation**: "winlogon32.exe", "lsass32.exe"

### Optimization Strategies

#### Startup Optimization
1. **Disable unnecessary startup programs**:
   - Task Manager > tab Startup
   - Disable (Vô hiệu hóa) các chương trình có impact cao
   - Dùng `msconfig` cho các service hệ thống

2. **Fast Startup settings**:
   - Control Panel > Power Options > Choose what power buttons do
   - Cân nhắc tắt khi cần troubleshooting (khắc phục sự cố)

#### Service Optimization
1. **Identify unnecessary services**:
   - Mở `services.msc`
   - Chuyển sang Manual (Thủ công) cho các service không quan trọng
   - Không bao giờ tắt các service hệ thống quan trọng

2. **Common services to optimize**:
   - **Windows Search**: Tắt nếu không dùng search
   - **Fax Service**: Tắt nếu không dùng fax
   - **Print Spooler**: Tắt nếu không dùng máy in
   - **Remote Desktop**: Tắt nếu không dùng RDP

#### Memory Management
1. **Virtual Memory optimization**:
   - Đặt kích thước page file (file hoán trang) thủ công
   - Xem xét đặt trên SSD
   - Theo dõi mức sử dụng page file

2. **Memory cleanup**:
   - Khởi động lại thường xuyên
   - Tắt ứng dụng không dùng
   - Dùng công cụ Memory Cleanup có sẵn

### Advanced Monitoring

#### Performance Counters
Các chỉ số hữu ích để theo dõi:
- **Processor(_Total)\% Processor Time**: % thời gian CPU bận
- **Memory\Available MBytes**: Dung lượng RAM còn trống
- **PhysicalDisk(_Total)\% Disk Time**: % thời gian ổ đĩa bận
- **Network Interface\Bytes Total/sec**: Tổng băng thông mạng
- **Process(ProcessName)\Working Set**: RAM mà tiến trình đang dùng

#### Event Log Analysis
Các log chính cần theo dõi:
- **System Log**: Vấn đề phần cứng và driver
- **Application Log**: Lỗi ứng dụng
- **Security Log**: Sự kiện xác thực (login/logout)
- **Setup Log**: Vấn đề cài đặt

#### WMI Queries

Các lệnh WMI hữu ích để giám sát tiến trình:

```cmd
wmic process get Name,ProcessId,PageFileUsage,WorkingSetSize
wmic process where "Name='svchost.exe'" get ProcessId,CommandLine
wmic service get Name,State,StartMode,ProcessId
```

## Best Practices cho System Administrators

### Daily Monitoring
1. **Check Task Manager performance graphs**
2. **Monitor Event Logs for errors**
3. **Review high resource usage processes**
4. **Check system temperatures và fan speeds**

### Weekly Maintenance
1. **Full system antivirus scan**
2. **Disk cleanup và defragmentation**
3. **Windows Update check**
4. **Registry cleanup (với caution)**

### Monthly Reviews
1. **Analyze performance trends**
2. **Review installed programs**
3. **Check startup programs**
4. **Update drivers và firmware**

### Emergency Response
1. **High CPU/Memory usage**:
   - Identify problematic process
   - Check for malware
   - Restart services if safe
   - Reboot as last resort

2. **System unresponsive**:
   - Ctrl + Alt + Del
   - Task Manager > End task
   - Safe Mode boot
   - System Restore

3. **Suspected malware**:
   - Disconnect from network
   - Boot from antivirus rescue disk
   - Full system scan
   - Consider system restore/reset

## Kết luận

Hiểu rõ về các process hệ thống Windows 11 là kỹ năng quan trọng cho:

1. **System Administrators**: Quản lý và troubleshoot hệ thống hiệu quả
2. **Power Users**: Tối ưu hóa hiệu suất máy tính cá nhân
3. **Security Professionals**: Phát hiện và phân tích threats
4. **Developers**: Hiểu môi trường runtime của applications

### Key Takeaways:

1. **Không bao giờ end task các Critical system processes** (System, csrss.exe, winlogon.exe, services.exe, lsass.exe)

2. **Luôn verify processes trước khi tắt** - Check file location, digital signature, và parent process

3. **Monitor resource usage thường xuyên** - Sử dụng Task Manager, Resource Monitor, và Process Explorer

4. **Understand normal behavior** - High CPU từ TiWorker.exe during updates là bình thường

5. **Keep system updated** - Windows Updates thường fix performance và security issues

6. **Use multiple tools** - Task Manager cho overview, Process Explorer cho details, Performance Toolkit cho advanced analysis

7. **Document baselines** - Biết performance bình thường để identify issues nhanh hơn

Việc nắm vững kiến thức về các process này sẽ giúp bạn trở thành một Windows power user hoặc system administrator hiệu quả hơn, có khả năng troubleshoot problems nhanh chóng và maintain hệ thống ổn định.