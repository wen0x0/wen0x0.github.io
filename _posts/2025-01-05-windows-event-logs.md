---
title: "Windows Event Logs: Cuốn nhật ký của Windows"
date: 2025-01-05 22:50:41 +0700
categories: [Notes, Windows, Cybersecurity, Forensics]
tags: [event logs, windows, logging, troubleshooting, forensics]
pin: false
comments: false
published: true
---

Nếu bạn từng tự hỏi Windows làm gì khi bạn không nhìn, thì Windows Event Logs chính là cuốn nhật ký bí mật mà nó ghi chép mọi thứ. Từ việc bạn đăng nhập lúc 3 giờ sáng để chơi game, đến lúc máy tính quyết định "tự sướng" bằng cách restart giữa buổi họp quan trọng - tất cả đều được ghi lại một cách tỉ mỉ như một thám tử tư.

## Event Logs là gì và tại sao nó quan trọng?

Windows Event Logs là hệ thống ghi nhật ký tập trung của Windows, hoạt động như một "black box" cho hệ điều hành. Nó ghi lại mọi sự kiện quan trọng xảy ra trên hệ thống - từ những việc nhỏ nhặt như việc khởi động một service, đến những sự cố nghiêm trọng như system crash.

Tưởng tượng Event Logs như một thư ký cực kỳ tận tâm, không bao giờ nghỉ việc, và có trí nhớ siêu phàm. Nó sẽ ghi lại:
- Ai đăng nhập vào hệ thống và khi nào
- Ứng dụng nào bị crash và tại sao
- Các thay đổi về security policy
- Lỗi phần cứng và driver
- Hoạt động của các service và process

## Cấu trúc Event Logs: Phân loại theo "thể loại"

Windows tổ chức Event Logs thành các categories khác nhau, mỗi loại phục vụ một mục đích riêng biệt:

### Application Log
Đây là nơi các ứng dụng "tâm sự" về cuộc đời của chúng. Nếu Microsoft Word quyết định tự tử giữa chừng khi bạn đang viết báo cáo, thông tin về cái chết bi thảm đó sẽ được ghi lại ở đây.

### System Log
Đây là nhật ký của chính hệ điều hành Windows. Mọi thứ từ việc khởi động services, lỗi driver, đến những lúc Windows quyết định "đi ngủ" đột ngột đều được ghi ở đây.

### Security Log
Đây là "camera an ninh" của Windows. Mọi hoạt động liên quan đến bảo mật - đăng nhập, thay đổi quyền, truy cập file được bảo vệ - đều được ghi lại với độ chi tiết đáng sợ.

### Setup Log
Ghi lại quá trình cài đặt và cập nhật Windows. Nếu Windows Update làm hỏng máy bạn, đây là nơi để tìm bằng chứng "tội phạm".

### Forwarded Events
Dành cho môi trường enterprise, nơi các event từ máy khác được forward về để giám sát tập trung.

## Các loại Event Level: Từ "Mọi thứ ổn" đến "Thế giới đang kết thúc"

Windows phân loại các event theo mức độ nghiêm trọng:

### Information (Thông tin)
Những sự kiện bình thường, như việc một service khởi động thành công. Giống như việc Windows nói "Hôm nay tôi đã thức dậy và làm việc bình thường".

### Warning (Cảnh báo)
Có gì đó không ổn nhưng chưa đến mức nghiêm trọng. Giống như việc Windows nói "Ê, disk space sắp hết rồi đấy, nhưng tôi vẫn chạy được".

### Error (Lỗi)
Có gì đó đã xảy ra sai. Một service không khởi động được, hoặc một ứng dụng bị crash. Windows đang nói "Tôi đã cố gắng, nhưng không được".

### Critical (Nghiêm trọng)
Đây là lúc Windows hét lên "HELP ME!". Hệ thống có thể sắp crash hoặc đã gặp lỗi nghiêm trọng.

### Success Audit & Failure Audit
Dành riêng cho Security Log, ghi lại việc ai đó thành công hoặc thất bại trong việc làm gì đó (thường là đăng nhập).

## Cách truy cập Event Logs

### Method 1: Event Viewer (Cách truyền thống)
Mở **Event Viewer** bằng cách:
- Nhấn `Win + R`, gõ `eventvwr.msc`
- Hoặc tìm "Event Viewer" trong Start Menu
- Hoặc vào Computer Management → Event Viewer

### Method 2: PowerShell (Cách của dân pro)
PowerShell cung cấp cmdlet `Get-EventLog` và `Get-WinEvent` để query event log:

```powershell
# Xem 10 event mới nhất từ System log
Get-EventLog -LogName System -Newest 10

# Tìm tất cả error events trong 24 giờ qua
Get-EventLog -LogName System -EntryType Error -After (Get-Date).AddDays(-1)

# Sử dụng Get-WinEvent (mạnh hơn)
Get-WinEvent -LogName System -MaxEvents 100 | Where-Object {$_.LevelDisplayName -eq "Error"}
```

### Method 3: Command Line
Sử dụng `wevtutil` command:

```cmd
# List tất cả log names
wevtutil el

# Export Security log ra file XML
wevtutil epl Security C:\security_log.evtx

# Query events
wevtutil qe System /c:10 /rd:true /f:text
```

## Hiểu Event ID: Những con số "thần thánh"

Mỗi event có một Event ID - một con số duy nhất định danh loại event đó. Một số Event ID "nổi tiếng" mà admin nào cũng phải biết:

### Security Events
- **4624**: Successful logon (ai đó đăng nhập thành công)
- **4625**: Failed logon (ai đó đăng nhập thất bại)
- **4648**: Logon using explicit credentials (ai đó dùng credential khác)
- **4720**: User account created (tạo user mới)
- **4726**: User account deleted (xóa user)

### System Events
- **6005**: Event Log service started (Windows vừa khởi động)
- **6006**: Event Log service stopped (Windows đang tắt)
- **6008**: Unexpected shutdown (Windows tắt đột ngột)
- **7034**: Service crashed unexpectedly (service bị crash)
- **7036**: Service changed state (service khởi động/dừng)

### Application Events
- **1000**: Application Error (ứng dụng bị crash)
- **1001**: Application Hang (ứng dụng bị treo)

## Event Log trong Security và Forensics

Event Log là công cụ không thể thiếu trong digital forensics và incident response. Nó giúp:

### Phát hiện Intrusion
- Theo dõi failed login attempts
- Phát hiện privilege escalation
- Theo dõi lateral movement

### Compliance và Audit
- Ghi lại ai làm gì và khi nào
- Tracking file access
- Monitoring policy changes

### Troubleshooting
- Tìm nguyên nhân của system crash
- Phát hiện hardware issues
- Debug application problems

## Cấu hình Event Log: Tùy chỉnh theo ý muốn

### Thay đổi Log Size
Mặc định, Event Log có giới hạn về kích thước. Có thể thay đổi qua:
- Event Viewer → Properties của từng log
- Group Policy
- Registry

### Log Retention Policy
Có thể cấu hình Windows xử lý như thế nào khi log đầy:
- **Overwrite events as needed**: Ghi đè events cũ
- **Archive log when full**: Backup log và tạo log mới
- **Do not overwrite events**: Không ghi thêm event mới

### Syslog Integration
Windows có thể forward events đến syslog server:
```powershell
# Tạo subscription để forward events
wecutil cs subscription.xml
```

## Best Practices: Làm sao để không bị Event Log "dìm"

### Monitoring quan trọng
- Thiết lập alerts cho critical events
- Monitor failed login attempts
- Theo dõi service failures

### Log Management
- Định kỳ backup logs
- Tăng log size cho môi trường production
- Sử dụng log forwarding cho centralized monitoring

### Filtering và Analysis
- Sử dụng custom views trong Event Viewer
- Tạo PowerShell scripts để automated analysis
- Integrate với SIEM solutions

## Event Log Forensics: Khi Windows trở thành "nhân chứng"

### Timeline Analysis
Event Log giúp tạo timeline của các sự kiện:
```powershell
# Tạo timeline của logon events
Get-WinEvent -LogName Security | Where-Object {$_.Id -eq 4624} | 
Select-Object TimeCreated, @{Name="User";Expression={$_.Properties[5].Value}} |
Sort-Object TimeCreated
```

### Correlation Analysis
Kết hợp multiple event sources để tạo big picture:
- System + Security + Application logs
- Network logs + Event logs
- File system monitoring + Event logs

### Evidence Collection
Event logs là digital evidence quan trọng:
- Export logs in native format (.evtx)
- Maintain chain of custody
- Document analysis methodology

## Troubleshooting thường gặp

### Event Log Service không khởi động
- Check Windows Event Log service
- Verify log file permissions
- Check disk space

### Logs bị corrupt
- Sử dụng `wevtutil` để repair
- Restore từ backup
- Clear log nếu cần thiết

### Performance issues
- Reduce log size
- Increase log retention
- Move logs to faster storage

## Tương lai của Event Log

Microsoft đang phát triển Event Log với:
- Enhanced filtering capabilities
- Better integration với cloud services
- Improved correlation features
- Machine learning-based analysis

Windows Event Logs có thể trông khô khan và kỹ thuật, nhưng nó là một trong những công cụ mạnh mẽ nhất để hiểu và quản lý hệ thống Windows. Nó như một thám tử tư âm thầm, ghi lại mọi dấu vết để giúp bạn giải quyết vấn đề khi cần thiết.

Hãy nhớ rằng, trong thế giới IT, knowledge is power, và Event Log chính là kho báu tri thức về hệ thống của bạn. Đừng để nó chỉ nằm đó mà không khai thác - hãy học cách "nói chuyện" với nó, và nó sẽ kể cho bạn nghe những câu chuyện thú vị về máy tính của bạn.

---
