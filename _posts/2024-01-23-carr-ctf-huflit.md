---
title: "CTF HUFLIT · Carr"
date: 2024-01-23 01:32:05 +0700
categories: [CTF, Forensics]
tags: [write-ups, forensics, ctf huflit, ctf]
pin: false
comments: false
published: true
---

## Challenge Info

- **Name**: Carr
- **Category**: Forensics
- **Platform**: CTF HUFLIT
- **Resource**: [Download file](/assets/img/2024/01/carr.zip)
- **Description**: 
  *The flag is uppercase!*

---

## Recon & Initial Analysis

Đề cho ta một file zip, cứ giải nén ra thử thì ta sẽ thấy 1 file ảnh jpg  
![pic.jpg](/assets/img/2024/01/pic.jpg)


Dùng lệnh `file` vào xem định dạng và metadata bên trong file

```bash
file pic.jpg
```

Kết quả

```text
pic.jpg: JPEG image data, JFIF standard 1.01, aspect ratio, density 72x72, segment length 16, 
Exif Standard: [TIFF image data, big-endian, direntries=12, manufacturer=Apple, model=iPhone 7 Plus, orientation=upper-left, xresolution=178, yresolution=186, resolutionunit=2, software=Photos 3.0, datetime=2019:01:30 18:14:56], 
baseline, precision 8, 3024x4032, components 3
```

Ý nghĩa:

**JPEG image data**  
Đây là một ảnh JPEG hợp lệ.

**JFIF standard 1.01**  
JFIF (JPEG File Interchange Format) là chuẩn phổ biến cho JPEG; phiên bản 1.01 chỉ ra nó khá cũ (khoảng đầu 1990s).

**density 72x72**  
DPI (dots per inch), thường không quan trọng với forensics, chỉ liên quan đến hiển thị/printing.

**segment length 16**  
Một phần nhỏ của metadata JPEG (không quá quan trọng nếu không phân tích binary).

**Exif Standard[...]**  
Phần này chứa metadata EXIF
  
**TIFF**  
- EXIF dựa trên định dạng TIFF (Tagged Image File Format).

**big-endian**  
- Kiểu lưu trữ byte trong file (được dùng bởi các thiết bị Apple và một số camera cao cấp). Không ảnh hưởng nhiều đến nội dung ảnh, nhưng dùng để xác định kiểu thiết bị hoặc hệ điều hành tạo ảnh.

**direntries=12**  
- Có 12 mục (entries) trong directory EXIF — tức là ảnh chứa metadata với 12 trường chính.
- Với ảnh gốc chưa chỉnh sửa, con số này thường nằm trong khoảng này hoặc nhiều hơn. Ảnh bị xóa metadata có thể nhỏ hơn.

**manufacturer=Apple, model=iPhone 7 Plus**  
- Ảnh chụp từ một thiết bị Apple iPhone 7 Plus.
- Dữ liệu này giúp:
  - Truy ngược nguồn gốc thiết bị.
  - Đối chiếu metadata với các ảnh khác để xác minh tính xác thực.

**orientation=upper-left**  
- Ảnh đang đúng chiều (góc trên bên trái là vị trí bắt đầu ảnh).
- Nếu orientation khác, có thể thiết bị đã xoay ảnh khi chụp, hoặc có chỉnh sửa.

**xresolution=178, yresolution=186**  
- Chỉ độ phân giải hiển thị (không phải kích thước pixel thực tế).
- Giá trị không chuẩn như 72 hoặc 300 DPI có thể gợi ý ảnh đã bị xử lý bằng phần mềm nào đó (vì phần mềm xử lý ảnh đôi khi thay đổi resolution field).

**resolutionunit=2**  
- Đơn vị đo độ phân giải là inches (2 = inches, theo chuẩn TIFF/EXIF).
- Kết hợp với DPI ở trên để tính kích thước hiển thị nếu cần.

**software=Photos 3.0**  
- Đây là phần mềm dùng để xử lý hoặc lưu ảnh. Trong trường hợp này là:
  - Ứng dụng Photos 3.0 của Apple (dùng trong iOS/macOS).
  - Nếu ảnh chụp bằng iPhone, sau đó được chỉnh sửa nhẹ hoặc chỉ đơn giản là mở rồi lưu lại bằng app Photos, metadata sẽ chứa thông tin này.
- Dấu hiệu tiềm năng ảnh đã qua xử lý nhẹ (ví dụ crop, filter, auto-enhance...).

**datetime=2019:01:30 18:14:56**  
- Ngày giờ ảnh được chụp hoặc lưu cuối cùng tùy vào app xử lý.
- Dùng để xác thực timeline trong điều tra.
- Có thể so sánh với các log hệ thống, GPS timestamp hoặc các ảnh khác để tìm điểm mâu thuẫn.

**baseline, precision 8**  
- Ảnh dùng baseline JPEG encoding (chuẩn phổ biến).
- Precision 8: Mỗi thành phần màu được mã hóa bằng 8-bit — chuẩn thông thường cho JPEG.

**3024x4032**  
- Kích thước ảnh thực tế, tức là:
  - Chiều ngang: 3024 pixel
  - Chiều dọc: 4032 pixel
- Đây là độ phân giải đúng với camera iPhone 7 Plus (12MP) — xác nhận thiết bị.

**components 3**  
- 3 thành phần màu: R (Red), G (Green), B (Blue).
- Đây là cấu trúc ảnh màu chuẩn RGB.

Để vào xem metadata chi tiết hơn chúng ta có thể dùng `exiftool` nhé

```bash
exiftool pic.jpg
```

Kết quả

```text
ExifTool Version Number         : 12.40
File Name                       : pic.jpg
Directory                       : .
File Size                       : 2.4 MiB
File Modification Date/Time     : 2019:10:30 17:14:49+07:00
File Access Date/Time           : 2023:10:31 14:48:14+07:00
File Inode Change Date/Time     : 2025:06:25 18:11:01+07:00
File Permissions                : -rwxrwxrwx
File Type                       : JPEG
File Type Extension             : jpg
MIME Type                       : image/jpeg
JFIF Version                    : 1.01
Exif Byte Order                 : Big-endian (Motorola, MM)
Make                            : Apple
Camera Model Name               : iPhone 7 Plus
Orientation                     : Horizontal (normal)
X Resolution                    : 72
Y Resolution                    : 72
Resolution Unit                 : inches
Software                        : Photos 3.0
Modify Date                     : 2019:01:30 18:14:56
Tile Width                      : 512
Tile Length                     : 512
Exposure Time                   : 1/11
F Number                        : 1.8
Exposure Program                : Program AE
ISO                             : 100
Exif Version                    : 0221
Date/Time Original              : 2019:01:30 18:14:56
Create Date                     : 2019:01:30 18:14:56
Components Configuration        : Y, Cb, Cr, -
Shutter Speed Value             : 1/11
Aperture Value                  : 1.8
Brightness Value                : 0.06665738937
Exposure Compensation           : 0
Metering Mode                   : Multi-segment
Flash                           : Auto, Did not fire
Focal Length                    : 4.0 mm
Subject Area                    : 2015 1511 2217 1330
Run Time Flags                  : Valid
Run Time Value                  : 52880015065708
Run Time Scale                  : 1000000000
Run Time Epoch                  : 0
Acceleration Vector             : 0.005993152504 -0.5791342346 0.8133361648
Sub Sec Time Original           : 128
Sub Sec Time Digitized          : 128
Flashpix Version                : 0100
Color Space                     : sRGB
Exif Image Width                : 3024
Exif Image Height               : 4032
Sensing Method                  : One-chip color area
Scene Type                      : Directly photographed
Exposure Mode                   : Auto
White Balance                   : Auto
Focal Length In 35mm Format     : 28 mm
Scene Capture Type              : Standard
Lens Info                       : 3.99-6.6mm f/1.8-2.8
Lens Make                       : Apple
Lens Model                      : iPhone 7 Plus back dual camera 3.99mm f/1.8
GPS Latitude Ref                : North
GPS Longitude Ref               : East
GPS Altitude Ref                : Above Sea Level
GPS Time Stamp                  : 11:14:51
GPS Speed Ref                   : km/h
GPS Speed                       : 0
GPS Img Direction Ref           : True North
GPS Img Direction               : 191.905
GPS Dest Bearing Ref            : True North
GPS Dest Bearing                : 191.905
GPS Date Stamp                  : 2019:01:30
GPS Horizontal Positioning Error: 1414 m
XMP Toolkit                     : XMP Core 5.4.0
Creator Tool                    : Photos 3.0
Date Created                    : 2019:01:30 18:14:56
Current IPTC Digest             : d41d8cd98f00b204e9800998ecf8427e
IPTC Digest                     : d41d8cd98f00b204e9800998ecf8427e
Image Width                     : 3024
Image Height                    : 4032
Encoding Process                : Baseline DCT, Huffman coding
Bits Per Sample                 : 8
Color Components                : 3
Y Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)
Run Time Since Power Up         : 14:41:20
Aperture                        : 1.8
Image Size                      : 3024x4032
Megapixels                      : 12.2
Scale Factor To 35 mm Equivalent: 7.0
Shutter Speed                   : 1/11
Create Date                     : 2019:01:30 18:14:56.128
Date/Time Original              : 2019:01:30 18:14:56.128
GPS Altitude                    : 3 m Above Sea Level
GPS Date/Time                   : 2019:01:30 11:14:51Z
GPS Latitude                    : 10 deg 47' 38.18" N
GPS Longitude                   : 106 deg 43' 14.04" E
Circle Of Confusion             : 0.004 mm
Field Of View                   : 65.5 deg
Focal Length                    : 4.0 mm (35 mm equivalent: 28.0 mm)
GPS Position                    : 10 deg 47' 38.18" N, 106 deg 43' 14.04" E
Hyperfocal Distance             : 2.07 m
Light Value                     : 5.2
Lens ID                         : iPhone 7 Plus back dual camera 3.99mm f/1.8
```

**Timeline chi tiết**

| Trường                           | Ý nghĩa                 |
| -------------------------------- | ----------------------- |
| Date/Time Original & Create Date | 2019-01-30 18:14:56.128 |
| File Modification Date           | 2019-10-30 17:14:49     |
| File Access Date                 | 2023-10-31 14:48:14     |
| Inode Change Date                | 2025-06-25 18:11:01     |

Ngày tạo ảnh: 30/01/2019  
Ngày chỉnh sửa file: 30/10/2019 — có thể là lần ảnh được lưu lại hoặc sao chép.  
Ngày inode bị thay đổi: 25/06/2025 — ảnh đã được di chuyển, phân quyền hoặc rename gần đây.  
Ngày truy cập gần nhất: 31/10/2023 — được mở bởi người dùng hoặc ứng dụng.  


**Thông số camera lúc chụp**  

| Trường             | Giá trị                               |
| ------------------ | ------------------------------------- |
| F Number           | f/1.8 (rất mở, ánh sáng yếu)          |
| Exposure Time      | 1/11 giây                             |
| ISO                | 100                                   |
| Metering Mode      | Multi-segment                         |
| Flash              | Không bật                             |
| White Balance      | Auto                                  |
| Scene Capture Type | Standard                              |
| Focus              | Tự động, độ sâu trường ảnh tiêu chuẩn |

Các thông số cho thấy: ảnh được chụp trong điều kiện ánh sáng yếu, tay người cầm đứng yên, không dùng đèn flash.


**Phân tích GPS**

| Trường            | Giá trị                    |
| ----------------- | -------------------------- |
| Latitude          | 10.794994° N               |
| Longitude         | 106.720567° E              |
| Địa điểm ước tính | Quận 6, TP.HCM, Việt Nam   |
| Altitude          | 3m trên mực nước biển      |
| GPS Timestamp     | 11:14:51 UTC = 18:14:51 VN |
| Tốc độ            | 0 km/h                     |
| Hướng ảnh         | 191.9° (gần Nam)           |
| Sai số GPS        | **1414m**                  |

Độ sai số GPS lớn: Có thể do trong nhà, hầm xe, hoặc ảnh đã bị can thiệp — có thể cần đối chiếu với ảnh khác chụp cùng thời để xác minh.


**Các trường đáng nghi**

| Trường                                     | Vấn đề                                                                               |
| ------------------------------------------ | ------------------------------------------------------------------------------------ |
| `GPS Horizontal Positioning Error = 1414m` | Tín hiệu GPS **cực kỳ kém**, có thể là ảnh đã qua xử lý hoặc lỗi GPS khi chụp        |
| `Software = Photos 3.0`                    | Ảnh **có thể đã được chỉnh sửa nhẹ** hoặc chỉ đơn giản là được lưu bởi app mặc định  |
| `File Modification Date > Create Date`     | Dấu hiệu **ảnh đã bị lưu lại** sau khi chụp                                          |
| `Permissions = -rwxrwxrwx`                 | Quyền 777 là **rất không thường thấy** — ảnh có thể đã bị người khác ghi/xóa dễ dàng |


**Tạm kết luận** 

| Phân tích                         | Kết luận                                                                                                       |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Ảnh chụp từ iPhone 7 Plus         | Chính xác, metadata đầy đủ                                                                                     |
| Thời gian và vị trí               | Đồng nhất, trừ sai số GPS đáng kể                                                                              |
| Ảnh đã qua xử lý?                 | Không chắc chắn, nhưng dấu hiệu `Photos 3.0` và `modification date` cho thấy **đã lưu lại hoặc chỉnh sửa nhẹ** |
| Ảnh có thể đã bị sao chép/nạp lại | Có — inode thay đổi 2025                                                                                       |


Nghi ngờ có vẻ file đã bị nhúng những dữ liệu bất thường  
Dùng `binwalk` để kiểm tra  

```bash
binwalk pic.jpg
```

Kết quả

```text
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             JPEG image data, JFIF standard 1.01
30            0x1E            TIFF image data, big-endian, offset of first image directory: 8
2474516       0x25C214        Zip archive data, at least v2.0 to extract, compressed size: 4605, uncompressed size: 5269, name: duong.PNG
2479251       0x25D493        End of Zip archive, footer length: 22
2479345       0x25D4F1        Zip archive data, at least v2.0 to extract, compressed size: 5105, uncompressed size: 5814, name: em.PNG
2484574       0x25E95E        End of Zip archive, footer length: 22
2484636       0x25E99C        Zip archive data, at least v2.0 to extract, compressed size: 5386, uncompressed size: 6025, name: vao.PNG
2490148       0x25FF24        End of Zip archive, footer length: 22
2490170       0x25FF3A        PNG image, 244 x 211, 8-bit/color RGBA, non-interlaced
2490261       0x25FF95        Zlib compressed data, compressed
```

Kết luận ngay ảnh pic.jpg đã bị nhúng dữ liệu bất thường — cụ thể là nhiều file ảnh PNG và cả dữ liệu nén ZIP — đây là kỹ thuật steganography hoặc file polyglot (đa định dạng).

**Phân tích kết quả binwalk**

| Offset (hex) | Miêu tả              | Chi tiết                                                        |
| ------------ | -------------------- | --------------------------------------------------------------- |
| `0x0`        | JPEG image data      | Ảnh thật được hiển thị                                          |
| `0x1E`       | TIFF image data      | EXIF metadata                                                   |
| `0x25C214`   | Zip archive          | File tên `duong.PNG`                                            |
| `0x25D493`   | Zip End              | Kết thúc file ZIP đầu tiên                                      |
| `0x25D4F1`   | Zip archive          | File `em.PNG`                                                   |
| `0x25E95E`   | Zip End              | Kết thúc file thứ 2                                             |
| `0x25E99C`   | Zip archive          | File `vao.PNG`                                                  |
| `0x25FF24`   | Zip End              |                                                                 |
| `0x25FF3A`   | PNG image            | File PNG được nhúng trực tiếp (244x211, RGBA)                   |
| `0x25FF95`   | Zlib compressed data | Dữ liệu nén — có thể là phần đuôi của file hoặc file nhúng thêm |

Rõ ràng, ảnh JPEG chứa các file ZIP và PNG, điều này KHÔNG BÌNH THƯỜNG cho một ảnh chụp từ iPhone.

Trích xuất các ảnh đó ra thôi  
Dùng `binwalk` với tùy chọn `-e` (extract)

```bash
binwalk -e pic.jpg
```

`cd` vào folder vừa extract ra, `ls` ra xem có gì

```text
25C214.zip  25D4F1.zip  25E99C.zip  25FF95  25FF95.zlib  vao.PNG
```

Vậy còn thiếu 2 file `duong.PNG` và `em.PNG` nhỉ??   
Có thể `25C214.zip` chứa `duong.PNG` và `25D4F1.zip` chứa `em.PNG`

| Tên file      | Loại | Dung lượng | Ghi chú                                     |
| ------------- | ---- | ---------- | ------------------------------------------- |
| `25C214.zip`  | ZIP  | 21 KB      | Có thể chứa `duong.PNG`                     |
| `25D4F1.zip`  | ZIP  | 16 KB      | Có thể chứa `em.PNG`                        |
| `25E99C.zip`  | ZIP  | 11 KB      | Có thể chứa `vao.PNG`                       |
| `25FF95`      | data | 206 KB     | Có thể là file ảnh PNG hoặc dữ liệu ẩn khác |
| `25FF95.zlib` | Zlib | 5.4 KB     | Dữ liệu nén trích từ `25FF95`               |
| `vao.PNG`     | PNG  | 6 KB       | Có thể là kết quả từ giải nén               |

Tò mò ghê, giải nén các file zip ra xem tiếp nào

Kết quả ta sẽ có 3 file
```text
duong.PNG
vao.PNG
em.PNG
```

Nghe cứ như  
"Đường vào tim em ôi băng giá ~~"

Xem qua mặt mũi 3 file đó nào  

| Tên file    | Ảnh                                                | Mã màu (Hex) | Decimal         |
| ----------- | -------------------------------------------------- | ------------ | --------------- |
| `duong.PNG` | [Xem ảnh duong.PNG](/assets/img/2024/01/duong.PNG) | #4D6572      | (77, 101, 104)  |
| `vao.PNG`   | [Xem ảnh vao.PNG](/assets/img/2024/01/vao.PNG)     | #636564      | (99, 101, 100)  |
| `em.PNG`    | [Xem ảnh em.PNG](/assets/img/2024/01/em.PNG)       | #656E7A      | (101, 110, 122) |


 
Trên các ảnh có các mã màu dạng Hex/Dec  
Đi chuyển các mã này sang ASCII xem thử có ý nghĩa gì không nào

Cứ nghĩ theo câu hát của Như Quỳnh thì thứ tự như sau  
`duong vao ... em` tương ứng ASCII là `Mes ced ... enz`


Dựa vào tên của bài là `Carr` thì ta có thể đoán đoạn `...` là `esB`  
Vì nó là car mà car thì "Mesced**esB**enz" =))

Hoặc cũng có thể check thử hex byte của file `25FF95` khi nãy đã binwalk ra, ta cũng sẽ thấy `esB`

```bash
xxd 25FF95 | head
```

```text
00000000: 0065 7342 ff65 7342 ff65 7342 ff65 7342  .esB.esB.esB.esB
00000010: ff65 7342 ff65 7342 ff65 7342 ff65 7342  .esB.esB.esB.esB
00000020: ff65 7342 ff65 7342 ff65 7342 ff65 7342  .esB.esB.esB.esB
00000030: ff65 7342 ff65 7342 ff65 7342 ff65 7342  .esB.esB.esB.esB
```

Dựa vào hint:  
*The flag is uppercase!*

Thì nội dung flag sẽ là: `MERCEDESBENZ`

Flag:  
```text
HUFLIT{MERCEDESBENZ}
```

---

## Step-by-step Solution

Từ các bước phân tích trên thì các bước giải bài này sẽ ngắn thôi

Trích xuất các ảnh bị nhúng ra
Dùng `binwalk` với tùy chọn `-e` (extract)

```bash
binwalk -e pic.jpg
```

Giải nén tiếp các file zip bên trong folder mà ta vừa extract bằng `binwalk` ra  
Ta sẽ được 3 file: `duong.PNG`, `vao.PNG`, `em.PNG`

Trên các ảnh có các mã màu dạng Hex/Dec  
Đi chuyển các mã này sang ASCII 

Cứ nghĩ theo câu hát của Như Quỳnh thì thứ tự như sau  
`duong vao ... em` tương ứng ASCII là `Mes ced ... enz`

Dựa vào tên của bài là `Carr` thì ta có thể đoán đoạn `...` là `esB`  
Vì nó là car mà car thì "Mesced**esB**enz" kkk

Dựa vào hint:  
*The flag is uppercase!*

Thì nội dung flag sẽ là: `MERCEDESBENZ`

Flag:  
```text
HUFLIT{MERCEDESBENZ}
```

---

## References

- **`xxd` – Make a hexdump or reverse it**  
  - [man7.org - xxd](https://man7.org/linux/man-pages/man1/xxd.1.html)  
  - [vim.org xxd docs](https://vimhelp.org/xxd.txt.html)

- **`file` – Determine file type using magic numbers**  
  - [GNU File Manual](https://linux.die.net/man/1/file)  
  - [Wikipedia - Magic number (programming)](https://en.wikipedia.org/wiki/Magic_number_(programming)#In_files)

- **`strings` – Extract printable characters from binaries**  
  - [GNU Binutils - strings](https://linux.die.net/man/1/strings)  
  - [CyberChef Alternative (Online)](https://gchq.github.io/CyberChef/)

- **`binwalk` – Search for embedded files and data**  
  - [Binwalk GitHub](https://github.com/ReFirmLabs/binwalk)  
  - [Binwalk Cheat Sheet](https://github.com/ReFirmLabs/binwalk/wiki)  
  - [Practical Binwalk in CTFs](https://ctftime.org/writeup/11195)

- **`exiftool` – Read/write image metadata**  
  - [ExifTool Official Site](https://exiftool.org/)  
  - [ExifTool Command Line Reference](https://exiftool.org/exiftool_pod.html)  
  - [SANS: ExifTool for Forensics](https://digital-forensics.sans.org/blog/2012/01/17/using-exiftool-to-analyze-metadata)

- **Hex, Dec, Bin Analysis Tools**  
  - [HexEd.it – Online Hex Editor](https://hexed.it/)  
  - [BinaryHexConverter](https://www.binaryhexconverter.com/)  
  - [Wikipedia – Binary file](https://en.wikipedia.org/wiki/Binary_file)

- **Embedded Files / Stego Detection**  
  - [Detect Hidden Data with Binwalk](https://null-byte.wonderhowto.com/how-to/analyze-hidden-files-inside-images-binwalk-0194869/)  
  - [Forensics Wiki – File formats](https://forensics.wiki/file_format/)  
  - [0xrick's Stego Tools List](https://0xrick.github.io/lists/stego/)  
  - [Zsteg (PNG Steganography)](https://github.com/zed-0xff/zsteg)

- **Entropy & Compression Analysis**  
  - [`ent` by John Walker](https://www.fourmilab.ch/random/)  
  - [SANS: Entropy in Steganography](https://resources.infosecinstitute.com/topic/entropy-analysis-in-steganography/)

- **General Forensics & CTF Practice**  
  - [Awesome DFIR List](https://github.com/kali-ru/awesome-dfir)  
  - [CTF Wiki – Forensics Section](https://ctf-wiki.org/en/docs/forensics/overview/)  
  - [OverTheWire – Bandit Wargame](https://overthewire.org/wargames/bandit/)

---  