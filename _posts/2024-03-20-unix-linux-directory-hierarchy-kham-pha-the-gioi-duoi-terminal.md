---
title: "Unix/Linux Directory Hierarchy: Khám phá thế giới dưới Terminal"
date: 2024-03-20 19:15:00 +0700
categories: [Notes]
tags: [linux, unix, filesystem, directories, system-administration]
pin: false
comments: false
published: true
---

Bạn có bao giờ cảm thấy như một du khách lạc lối trong một thành phố xa lạ khi mở terminal lần đầu tiên không? Nhìn vào cấu trúc thư mục của Linux/Unix, bạn có thể nghĩ: "Tại sao lại có `/usr`, `/var`, `/opt`? Ai đặt tên những cái này vậy?" 

Hôm nay, chúng ta sẽ cùng nhau khám phá "bản đồ thành phố" này - tìm hiểu về Filesystem Hierarchy Standard (FHS) và ý nghĩa của từng "khu phố" trong hệ thống Unix/Linux. Đây không chỉ là một cuộc tham quan, mà còn là hành trình hiểu được triết lý thiết kế của những người tiên phong đã tạo nên nền tảng của thế giới công nghệ hiện đại.

## Giới thiệu về Filesystem Hierarchy Standard (FHS)

Trước khi bắt đầu cuộc hành trình, chúng ta cần hiểu rằng cấu trúc thư mục Unix/Linux tuân theo một tiêu chuẩn gọi là FHS. Đây như "quy hoạch đô thị" của thế giới Unix - mọi thứ đều có vị trí và mục đích riêng, không ai muốn sống trong một thành phố hỗn loạn cả.

FHS được thiết kế với những nguyên tắc:
- **Tính nhất quán**: Cùng một loại file thì nằm ở cùng một nơi
- **Khả năng dự đoán**: Bạn biết tìm gì ở đâu
- **Tính bảo mật**: Phân quyền rõ ràng cho từng khu vực
- **Khả năng chia sẻ**: Một số thư mục có thể được mount từ xa

Bây giờ, hãy cùng khám phá từng "địa danh" trong thành phố Unix/Linux!

## `/` - Root: Vua của mọi thư mục

```
/
├── bin/
├── boot/
├── dev/
├── etc/
├── home/
├── lib/
├── media/
├── mnt/
├── opt/
├── proc/
├── root/
├── run/
├── sbin/
├── srv/
├── sys/
├── tmp/
├── usr/
└── var/
```

Root directory (`/`) là "thủ đô" của hệ thống - nơi mà mọi thứ khác bắt đầu. Nó như điểm gốc tọa độ (0,0) trong toán học, tất cả các đường dẫn đều bắt đầu từ đây.

**Đặc điểm quan trọng:**
- Chỉ có root user mới có quyền ghi vào thư mục này
- Không bao giờ được xóa (trừ khi bạn muốn hệ thống "bay màu")
- Chứa các thư mục hệ thống quan trọng nhất

## `/bin` - Binary: Kho vũ khí cơ bản

Thư mục `/bin` chứa các chương trình (binary executables) cần thiết cho tất cả user, kể cả khi hệ thống ở chế độ single-user. Đây như "hộp công cụ cơ bản" mà ai cũng cần.

**Những cư dân nổi tiếng:**
- `ls` - liệt kê file (như "xem có gì trong phòng")
- `cp` - copy file (máy photocopy của command line)  
- `mv` - move/rename file (dịch vụ chuyển nhà)
- `rm` - remove file (lệnh "tiêu hủy" nguy hiểm nhất)
- `cat` - hiển thị nội dung file (không phải mèo đâu!)
- `grep` - tìm kiếm text (thám tử siêu đẳng)
- `bash` - shell interpreter (người thông dịch)

**Triết lý thiết kế:** Chỉ chứa những command thiết yếu cho system recovery và basic operations.

## `/sbin` - System Binary: Phòng làm việc của quản trị viên

Nếu `/bin` là hộp công cụ cho mọi người, thì `/sbin` là "phòng làm việc riêng của sếp" - chứa các command chỉ dành cho system administrator.

**Những "công cụ quyền lực":**
- `fdisk` - quản lý partition (như chia đất)
- `fsck` - kiểm tra filesystem (bác sĩ chẩn đoán ổ cứng)
- `mount`/`umount` - gắn/tháo filesystem
- `iptables` - quản lý firewall (lính canh mạng)
- `systemctl` - quản lý services (điều khiển các dịch vụ)

**Lưu ý:** Các command này thường cần quyền root để chạy.

## `/usr` - Unix System Resources: Khu thương mại sầm uất

Đây có lẽ là thư mục có tên "misleading" nhất! `/usr` không phải viết tắt của "user" mà là "Unix System Resources". Nó như "khu thương mại" của hệ thống - chứa hầu hết các ứng dụng và dữ liệu không thay đổi.

### `/usr/bin` - Chợ ứng dụng chính

Chứa hầu hết các command và ứng dụng mà user thường dùng:
- Text editors: `vim`, `nano`, `emacs`
- Compilers: `gcc`, `python`, `node`  
- Network tools: `wget`, `curl`, `ssh`
- Development tools: `git`, `make`, `gdb`

### `/usr/sbin` - Phòng làm việc mở rộng của admin

Các system administration tools không thiết yếu cho system recovery:
- `cron` - scheduler (thư ký đặt lịch)
- `nginx`, `apache` - web servers
- Network configuration tools

### `/usr/lib` - Thư viện chung

Chứa shared libraries (.so files) mà các ứng dụng cần:
```bash
/usr/lib/
├── x86_64-linux-gnu/    # Libraries for 64-bit
├── python3.8/           # Python modules
├── gcc/                 # Compiler libraries
└── systemd/             # System service files
```

### `/usr/local` - Khu dân cư cao cấp

Đây là nơi cài đặt software do admin compile từ source code, không phải từ package manager:
- `/usr/local/bin` - Custom executables
- `/usr/local/lib` - Custom libraries  
- `/usr/local/share` - Custom shared data

**Triết lý:** "Locally installed software" - không bị ghi đè khi update hệ thống.

### `/usr/share` - Kho dữ liệu chung

Chứa architecture-independent data:
- Documentation: `/usr/share/doc`, `/usr/share/man`
- Icons và themes: `/usr/share/icons`, `/usr/share/themes`
- Fonts: `/usr/share/fonts`
- Application data: config templates, example files

## `/var` - Variable: Khu vực năng động

Tên `/var` xuất phát từ "variable" - nơi lưu trữ dữ liệu thay đổi liên tục trong quá trình hoạt động của hệ thống.

### `/var/log` - Nhà kho hồ sơ

Tất cả log files đều "sinh sống" tại đây:
- `/var/log/syslog` - System messages (nhật ký chung)
- `/var/log/auth.log` - Authentication logs (ai đăng nhập khi nào)
- `/var/log/apache2/` - Web server logs
- `/var/log/mysql/` - Database logs

**Mẹo hay:** `tail -f /var/log/syslog` để theo dõi log real-time.

### `/var/cache` - Kho chứa tạm thời

Cache files để tăng tốc độ:
- Package manager cache: `/var/cache/apt`
- Application cache data
- Thumbnail images

### `/var/tmp` - Bãi rác "bền vững"

Khác với `/tmp`, files trong `/var/tmp` tồn tại lâu hơn (qua reboot):
- Temporary files cần giữ lâu
- Incomplete downloads
- Work-in-progress data

### `/var/spool` - Hàng đợi công việc

"Spool" là nơi xếp hàng chờ xử lý:
- `/var/spool/mail` - Email queue
- `/var/spool/cron` - Scheduled jobs
- `/var/spool/cups` - Print queue

### `/var/lib` - Kho dữ liệu ứng dụng

Application state information:
- `/var/lib/mysql` - Database files
- `/var/lib/docker` - Container data
- `/var/lib/systemd` - Service state

## `/etc` - Et Cetera: Trung tâm điều hành

Tên `/etc` có nhiều giả thuyết, nhưng thông dụng nhất là "Et Cetera" (và những thứ khác). Đây là "trung tâm điều hành" chứa tất cả configuration files.

### Những file config quan trọng:

**System Configuration:**
- `/etc/passwd` - User account info (không chứa password thật!)
- `/etc/shadow` - Encrypted passwords
- `/etc/group` - Group information
- `/etc/hosts` - Local DNS mapping
- `/etc/fstab` - Filesystem mount points

**Network Configuration:**
- `/etc/network/interfaces` (Debian/Ubuntu)
- `/etc/resolv.conf` - DNS servers
- `/etc/ssh/sshd_config` - SSH daemon config

**Service Configuration:**
- `/etc/apache2/` - Web server config
- `/etc/mysql/` - Database config
- `/etc/nginx/` - Reverse proxy config

**Startup Configuration:**
- `/etc/rc.local` - Local startup script (legacy)
- `/etc/systemd/` - Modern service management

## `/home` - Khu dân cư

Mỗi user (trừ root) có một "căn nhà" riêng trong `/home`:
```
/home/
├── alice/
│   ├── Documents/
│   ├── Downloads/
│   ├── Desktop/
│   └── .bashrc          # Personal shell config
├── bob/
└── charlie/
```

**Đặc điểm:**
- User chỉ có full control trong home directory của mình
- Chứa personal files, settings, và projects
- Hidden files (bắt đầu bằng `.`) chứa user-specific configurations

## `/root` - Lâu đài của vua

Home directory của root user - không nằm trong `/home` để đảm bảo root luôn có thể truy cập ngay cả khi `/home` có vấn đề.

**Tại sao tách biệt?**
- Security: Isolated từ user directories
- Reliability: Luôn available ngay cả khi filesystem có lỗi
- Simplicity: Đường dẫn ngắn và dễ nhớ

## `/tmp` - Bãi rác tạm thời

Temporary files storage - "bãi rác" được dọn dẹp thường xuyên:
- Thường được clear khi reboot
- Any user có thể ghi (với sticky bit set)
- Không nên lưu dữ liệu quan trọng

**Ví dụ sử dụng:**
```bash
# Tạo temp file
mktemp /tmp/mywork.XXXXXX

# Extract archive to temp location  
tar -xzf archive.tar.gz -C /tmp
```

## `/opt` - Optional: Khu đô thị mới

Dành cho "optional software packages" - thường là commercial software hoặc self-contained applications:
```
/opt/
├── google/
│   └── chrome/
├── oracle/
│   └── java/
└── teamviewer/
```

**Triết lý:** Mỗi package có thư mục riêng, không "làm bẩn" filesystem standard.

## `/boot` - Garage khởi động

Chứa files cần thiết để boot hệ thống:
- `vmlinuz` - Linux kernel
- `initrd.img` - Initial RAM disk
- `grub/` - Bootloader configuration
- `System.map` - Kernel symbol table

**Cảnh báo:** Đừng xóa gì trong này trừ khi bạn muốn hệ thống không boot được!

## `/dev` - Device: Cổng giao tiếp thiết bị

Unix triết lý "everything is a file" được thể hiện rõ ở `/dev` - nơi hardware devices được represent as files:

### Block Devices (Storage):
- `/dev/sda`, `/dev/sdb` - SATA drives
- `/dev/nvme0n1` - NVMe SSD
- `/dev/loop0` - Loopback device

### Character Devices:
- `/dev/tty` - Current terminal
- `/dev/null` - "Black hole" (loại bỏ output)
- `/dev/zero` - Infinite zeros
- `/dev/random` - Random number generator

### Special Files:
```bash
# Discard output
command > /dev/null 2>&1

# Generate random data
dd if=/dev/random of=keyfile bs=1024 count=1

# Create large sparse file
dd if=/dev/zero of=bigfile bs=1M count=1000
```

## `/proc` - Process: Cửa sổ nhìn vào hệ thống

Đây là pseudo-filesystem - không phải files thật mà là interface để truy cập kernel information:

### System Information:
- `/proc/cpuinfo` - CPU details
- `/proc/meminfo` - Memory usage
- `/proc/version` - Kernel version
- `/proc/uptime` - System uptime

### Process Information:
- `/proc/[PID]/` - Process-specific info
- `/proc/[PID]/cmdline` - Command arguments
- `/proc/[PID]/environ` - Environment variables
- `/proc/[PID]/fd/` - File descriptors

**Ví dụ thực tế:**
```bash
# Xem CPU info
cat /proc/cpuinfo | grep "model name"

# Xem memory usage
cat /proc/meminfo | grep "MemTotal\|MemFree"

# Xem process command line
cat /proc/1234/cmdline
```

## `/sys` - System: Cửa sổ hardware

Sysfs - modern interface để tương tác với kernel và hardware:
- `/sys/class/` - Device classes (network, block, etc.)
- `/sys/devices/` - Device tree
- `/sys/kernel/` - Kernel parameters
- `/sys/power/` - Power management

**Ví dụ:**
```bash
# Xem network interfaces
ls /sys/class/net/

# Control LED (nếu có quyền)
echo 1 > /sys/class/leds/power/brightness
```

## `/run` - Runtime: Thông tin thời gian thực

Chứa runtime information từ khi boot:
- `/run/systemd/` - Systemd runtime data
- `/run/user/[UID]/` - User session data
- `/run/lock/` - Lock files
- Process ID files (`.pid`)

**Đặc điểm:** Thường là tmpfs (RAM-based filesystem).

## `/media` và `/mnt` - Mount Points: Bãi đỗ thiết bị

### `/media` - Tự động mount
Modern systems tự động mount removable media:
```
/media/
├── cdrom/
└── usb0/
```

### `/mnt` - Manual mount
Traditional mount point cho admin:
```bash
# Mount USB drive manually
sudo mount /dev/sdb1 /mnt/usb

# Mount network share
sudo mount -t nfs server:/path /mnt/nfs
```

## `/srv` - Service Data: Kho dữ liệu dịch vụ

Chứa site-specific data served by system:
- `/srv/www/` - Web server content
- `/srv/ftp/` - FTP server files
- `/srv/git/` - Git repositories

**Triết lý:** Tách biệt service data khỏi application code.

## `/lib` và `/lib64` - Libraries: Thư viện hệ thống

Essential shared libraries cần thiết cho programs trong `/bin` và `/sbin`:
- `/lib/modules/` - Kernel modules
- `/lib/systemd/` - Systemd components
- `/lib64/` - 64-bit libraries (trên một số systems)

**Dynamic Linking:**
```bash
# Xem library dependencies
ldd /bin/ls

# Library cache
ldconfig
```

## Những thư mục ít gặp nhưng đáng biết

### `/lost+found` - Đồ thất lạc
Chỉ có trên ext2/3/4 filesystems - chứa files recovered sau filesystem check.

### `/selinux` - Security Enhanced Linux
Nếu SELinux được enable, đây là mount point cho selinuxfs.

## Best Practices và lưu ý quan trọng

### Quyền truy cập
```bash
# Xem permissions
ls -la /

# Một số thư mục quan trọng và permissions
drwxr-xr-x  /bin     # Executable by all
drwxr-xr-x  /etc     # Readable by all
drwx------  /root    # Only root access
drwxrwxrwt  /tmp     # Sticky bit - special permissions
```

### Filesystem types
```bash
# Xem mounted filesystems
df -T

# Mount information
cat /proc/mounts
```

### Disk usage monitoring
```bash
# Check disk usage
du -sh /var/log/*
du -sh /usr/*

# Find large files
find / -size +100M -type f 2>/dev/null
```

### Backup considerations
**Critical directories to backup:**
- `/etc` - System configuration
- `/home` - User data
- `/var/lib` - Application data
- `/opt` - Optional software

**Don't backup:**
- `/proc`, `/sys`, `/dev` - Virtual filesystems
- `/tmp` - Temporary files
- `/var/cache` - Cache data

## Troubleshooting thông qua filesystem

### System won't boot
Kiểm tra:
- `/boot` - Kernel files
- `/etc/fstab` - Mount configuration
- `/var/log/` - Boot logs

### Disk full
```bash
# Find what's using space
df -h
du -sh /* | sort -hr

# Clean up
sudo apt-get clean           # Package cache
sudo journalctl --vacuum-time=30d  # System logs
```

### Permission issues
```bash
# Reset home directory permissions
sudo chown -R user:user /home/user
sudo chmod -R 755 /home/user
```

## Sự khác biệt giữa các distributions

### Red Hat/CentOS/Fedora
- Network config: `/etc/sysconfig/network-scripts/`
- Service management: Systemd (modern) hoặc SysV init (legacy)

### Debian/Ubuntu
- Network config: `/etc/network/interfaces` hoặc Netplan
- Package cache: `/var/cache/apt/`

### Arch Linux
- Package manager cache: `/var/cache/pacman/`
- System config: Follows FHS closely

### macOS (Darwin)
- Similar structure nhưng có additions:
  - `/Applications` - GUI applications
  - `/System` - System files
  - `/Users` thay vì `/home`

## Tương lai của filesystem hierarchy

### Container era changes:
- Immutable filesystems
- Overlay filesystems
- Container-specific directories

### Cloud-native considerations:
- `/etc` configurations via ConfigMaps
- Persistent volumes for data
- Ephemeral storage patterns

## Kết luận

Hiểu về cấu trúc thư mục Unix/Linux không chỉ giúp bạn navigate hệ thống một cách hiệu quả, mà còn hiểu sâu về triết lý thiết kế đằng sau những quyết định này. Mỗi thư mục đều có lý do tồn tại và vai trò riêng trong "sinh thái hệ thống".

Từ `/bin` với những công cụ thiết yếu, `/etc` với configurations quan trọng, đến `/var` với dữ liệu động, và `/usr` với ứng dụng phong phú - tất cả tạo nên một hệ thống có tổ chức, dễ bảo trì và scale.

Nhớ rằng, filesystem hierarchy không chỉ là quy tắc mà còn là ngôn ngữ chung giúp system administrators trên khắp thế giới có thể hiểu và làm việc với bất kỳ hệ thống Unix/Linux nào. Đây chính là sức mạnh của standardization!

**Lời khuyên cuối:** Hãy dành thời gian explore từng thư mục, đọc man pages (`man hier`), và thực hành. Filesystem mastery là foundation cho mọi kỹ năng system administration sau này.

*"In Unix, everything is a file, and every file has its place."*

---
