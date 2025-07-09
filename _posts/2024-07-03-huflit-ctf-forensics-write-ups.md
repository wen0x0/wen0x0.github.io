---
title: "HUFLIT CTF – Forensics Write-ups"
date: 2024-07-03 23:10:32 +0700
categories: [Notes, CTF, Cybersecurity, Forensics]
tags: [write-ups, forensics, ctf huflit, ctf]
pin: false
comments: false
published: true
---

Đây là write-ups của mình dành cho các challenge về Forensics của CTF HUFLIT. Một phần vì đây là bài tập ở trường, một phần vì mình muốn chia sẻ kinh nghiệm và cách tiếp cận với những ai quan tâm đến lĩnh vực Digital Forensics.

---

## Cat

- **Resource**: [File](/assets/img/2024/01/Cat.jpg)
- **Description**:  
  *What is hidden behind picture? nyan*

- **Hints**:  
  - *What is hexadecimal?*  
  - *Decode 1 time not enough hehehe*

---

Đề cho ta duy nhất một tấm hình của "Quàng Thượng" như sau
![Cat's Image](/assets/img/2024/01/Cat.jpg)

Trước tiên thì cứ ngó nghiêng xem con file này mặt mũi, tên họ như nào đã

```bash
file Cat.jpg  
```

Kết quả:

```text
Cat.jpg: JPEG image data, JFIF standard 1.01, resolution (DPI), density 300x300, segment length 16, Exif Standard: [TIFF image data, little-endian, direntries=270]
```

Ý nghĩa:  
**Cat.jpg**  
Tên file đang được phân tích.

**JPEG image data**  
Đây là file ảnh định dạng JPEG – chuẩn nén ảnh phổ biến.

**JFIF standard 1.01**  
JFIF (JPEG File Interchange Format) là một tiêu chuẩn mô tả cách dữ liệu JPEG được lưu trữ trong file.  
  - 1.01 là phiên bản của JFIF
  - Đảm bảo tương thích giữa các thiết bị/ứng dụng khi hiển thị ảnh


**resolution (DPI), density 300x300**  
DPI: Dots Per Inch – mật độ điểm ảnh (mức độ chi tiết khi in):
  - 300x300 DPI là độ phân giải khá cao (dành cho in ấn)
  - Đây là metadata, không liên quan đến kích thước pixel (VD: 1024x768)

**segment length 16**  
Một phần của cấu trúc nội bộ file JPEG.  
JPEG có nhiều segment marker (0xFF...), mỗi segment mang metadata, độ dài segment là 16 byte ở đây.

**Exif Standard: [...]**  
File này chứa metadata Exif (Exchangeable Image File Format) — dùng trong ảnh chụp bởi máy ảnh, điện thoại.

**[TIFF image data, little-endian, direntries=270]**  
Đây là phần mở rộng mô tả nội dung bên trong Exif:
- TIFF image data: Dữ liệu metadata lưu ở định dạng TIFF
- little-endian: Byte order của dữ liệu trong TIFF
- direntries=270: Có 270 mục metadata (directory entries) được lưu (rất nhiều thông tin: camera, GPS, timestamp...)

Nghi ngờ có thể ảnh đã bị nhúng thông tin như:
- Text ẩn trong Exif
- File ẩn bằng kỹ thuật steganography
- Thêm file khác bằng append hoặc encode đặc biệt
- ...


Dựa vào hint 1 là:  
*What is Hexadecimal*  

Ta sẽ vào check hex byte xem và search thử các key string như: flag, ctf, huflit, ...
![alt text](/assets/img/2024/01/image.png)

Vậy ra search với key "flag" ta sẽ thấy được 1 string đáng nghi  
Dùng `strings` + `grep` để dễ copy string đó hơn  

```bash
strings Cat.jpg | grep flag
```

```text
flag: "U0ZWR1RFbFVlM04wTTJjd1h6RnpiaWQwWDJJd2NqRnVPVjl1ZVRSdU9qTjk="
```

Đây là string đã được encrypt qua Base64 rồi  
Vậy thì đi decode nó lấy flag thôi kkk  

```bash
echo -n "U0ZWR1RFbFVlM04wTTJjd1h6RnpiaWQwWDJJd2NqRnVPVjl1ZVRSdU9qTjk=" | base64 -d
```

Kết quả không như mong đợi lắm =))  

> SFVGTElUe3N0M2cwXzFzbid0X2IwcjFuOV9ueTRuOjN9

Nhưng hint 2 có bảo là:  

*Decode 1 time not enough hehehe*

Vậy thì decode thêm lần nữa nhỉ??  

```bash
echo -n "U0ZWR1RFbFVlM04wTTJjd1h6RnpiaWQwWDJJd2NqRnVPVjl1ZVRSdU9qTjk=" | base64 -d | base64 -d
```

Lụm ngay quả flag nhé

```text
HUFLIT{st3g0_1sn't_b0r1n9_ny4n:3}
```

---

## Carr

- **Resource**: [File](/assets/img/2024/01/carr.zip)
- **Description**:  
  *The flag is uppercase!*

---

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

## Date of birth?

- **Resource**: [File](/assets/img/2024/01/dateofbirth.zip)
- **Description**:  
  *UPPERCASE THE FLAG*

---

Đề bài cho ta 1 file zip, extract nó ra ta được 1 file Word Document

```bash
file thi3.docx
```

```text
thi3.docx: Microsoft Word 2007+
```

Như thường lệ thì ta kiểm tra metadata của nó

```bash
exiftool thi3.docx
```

```text
ExifTool Version Number         : 12.40
File Name                       : thi3.docx
Directory                       : .
File Size                       : 48 MiB
File Modification Date/Time     : 2019:10:31 09:43:15+07:00
File Access Date/Time           : 2019:10:31 15:43:01+07:00
File Inode Change Date/Time     : 2025:06:26 18:06:50+07:00
File Permissions                : -rwxrwxrwx
File Type                       : DOCX
File Type Extension             : docx
MIME Type                       : application/vnd.openxmlformats-officedocument.wordprocessingml.document
Zip Required Version            : 10
Zip Bit Flag                    : 0
Zip Compression                 : None
Zip Modify Date                 : 2019:10:31 09:42:00
Zip CRC                         : 0x00000000
Zip Compressed Size             : 0
Zip Uncompressed Size           : 0
Zip File Name                   : docProps/
Template                        : Normal.dotm
Total Edit Time                 : 40 minutes
Pages                           : 7
Words                           : 780
Characters                      : 4450
Application                     : Microsoft Office Word
Doc Security                    : None
Lines                           : 37
Paragraphs                      : 10
Scale Crop                      : No
Heading Pairs                   : Title, 1
Titles Of Parts                 :
Company                         :
Links Up To Date                : No
Characters With Spaces          : 5220
Shared Doc                      : No
Hyperlinks Changed              : No
App Version                     : 16.0000
Title                           :
Subject                         :
Creator                         : Windows User
Keywords                        :
Description                     :
Last Modified By                : Windows User
Revision Number                 : 1
Create Date                     : 2017:09:07 14:00:00Z
Modify Date                     : 2017:09:07 14:40:00Z
```

Khi xem kỹ hơn output của `exiftool`, ta có thể rút ra một vài điểm đáng nghi:

- **Create Date** và **Modify Date** đều là **2017**, rất cũ so với `File Modification Date` là năm **2019**, điều này cho thấy file có thể đã được tạo từ rất lâu nhưng được chỉnh sửa/tái sử dụng gần đây.
- **File Inode Change Date** là năm **2025**, tức là tương lai so với cả `Modify` và `Access`. Điều này thường xảy ra khi file mới bị **copy hoặc ghi lại** trên một hệ thống mới, hoặc **metadata bị can thiệp**.
- `Zip Compression` báo là **None**, đồng thời kích thước nén là **0**, trong khi `.docx` vốn là file `.zip` chứa nhiều XML → điều này **bất thường** và có thể là dấu hiệu file bị craft để giấu dữ liệu.
- Các trường như `Title`, `Subject`, `Description`, `Company`, `Keywords` đều bị **để trống**, chỉ có `Creator` và `Last Modified By` là `Windows User` — một tên rất chung chung, có thể là mặc định hoặc cố tình giữ ẩn danh.

Metadata tuy không chứa flag nhưng đã **gợi ý** rằng file này có thể đã bị **chỉnh sửa**

Dùng `unzip` hoặc bất cứ tool giải nén nào để extract file `thi3.docx` xem thử

```bash
unzip thi3.docx
```

```text
Archive:  thi3.docx
   creating: docProps/
  inflating: docProps/app.xml
  inflating: docProps/core.xml
   creating: word/
  inflating: word/document.xml
  inflating: word/fontTable.xml
   creating: word/media/
  inflating: word/media/Huong toc ma non Quang le_thi3.wav
  inflating: word/media/image1.png
  inflating: word/numbering.xml
  inflating: word/settings.xml
  inflating: word/styles.xml
   creating: word/theme/
  inflating: word/theme/theme1.xml
  inflating: word/webSettings.xml
   creating: word/_rels/
  inflating: word/_rels/document.xml.rels
  inflating: [Content_Types].xml
   creating: _rels/
  inflating: _rels/.rels
```

Dạo quanh các file, folder trên thì có 1 em file khá khả nghi

`Huong toc ma non Quang le_thi3.wav`

Mở lên nghe thì cũng chỉ là một đoạn nhạc Quang Lê hát mà thôi  
Tuy nhiên khi đến đoạn ... thì ta sẽ nghe có 1 âm thanh lạ =)))

![Huong toc ma non Quang le_thi3.wav](/assets/img/2024/01/audio.png)

Thử làm chậm lại để nghe rõ hơn thì mình nghi là đoạn này đã bị reverse rồi  
Khi recover lại đoạn này để nghe thử thì đúng như mình dự đoán 

Dựa vào tên đề bài thì ta cũng đoán được ra nội dung flag nhỉ??

Flag: 

```text
HUFLIT{01051940}
```

---

## ASCIS 2023 Quals: For 2

- **Resource**: [File](/assets/img/2024/01/for2.tar)
- **Description**:  
  *Bài này được các anh chị tiền bối lụm về từ ASCIS 2023 nhé*

---

Đề bài cho ta 1 file tar, ngại gì không extract ra nào

```bash
file for2.tar
```

```text
for2.tar: POSIX tar archive
```

Extract ra đê

```bash
tar -xvf for2.tar
```

Kết quả ra một đống luôn đó nha =)))

```text
017f54b0dc633a0e29aa43309b5245b37f3fbcaa4e8bde246ff4902fb3a396b7.json
01c3092f7f85bd873a0291c379b875154101df7602943765ce91e83139c8cf51/
01c3092f7f85bd873a0291c379b875154101df7602943765ce91e83139c8cf51/VERSION
01c3092f7f85bd873a0291c379b875154101df7602943765ce91e83139c8cf51/json
01c3092f7f85bd873a0291c379b875154101df7602943765ce91e83139c8cf51/layer.tar
02a0b3813e7a1ced18ed2641684feae3da3ffe188b33ebab343462043ddfa8fc/
02a0b3813e7a1ced18ed2641684feae3da3ffe188b33ebab343462043ddfa8fc/VERSION
02a0b3813e7a1ced18ed2641684feae3da3ffe188b33ebab343462043ddfa8fc/json
02a0b3813e7a1ced18ed2641684feae3da3ffe188b33ebab343462043ddfa8fc/layer.tar
2d7f13c9225ba680a4e3be0a0fa8e889ab968cd583ab62c61d991eada9038bfa/
2d7f13c9225ba680a4e3be0a0fa8e889ab968cd583ab62c61d991eada9038bfa/VERSION
2d7f13c9225ba680a4e3be0a0fa8e889ab968cd583ab62c61d991eada9038bfa/json
2d7f13c9225ba680a4e3be0a0fa8e889ab968cd583ab62c61d991eada9038bfa/layer.tar
3bcecd32ffde40117c68eee14aceca4b5defe71b954e36d20bdd359ed22e2e67/
3bcecd32ffde40117c68eee14aceca4b5defe71b954e36d20bdd359ed22e2e67/VERSION
3bcecd32ffde40117c68eee14aceca4b5defe71b954e36d20bdd359ed22e2e67/json
3bcecd32ffde40117c68eee14aceca4b5defe71b954e36d20bdd359ed22e2e67/layer.tar
46da70c1e600d04438234857b2f134434f8f3eb579884a69ae372a88ff87735c/
46da70c1e600d04438234857b2f134434f8f3eb579884a69ae372a88ff87735c/VERSION
46da70c1e600d04438234857b2f134434f8f3eb579884a69ae372a88ff87735c/json
46da70c1e600d04438234857b2f134434f8f3eb579884a69ae372a88ff87735c/layer.tar
4ddc8837072a619380728ba768843a57301cad6b8334b4fd2b59790a90a692f2/
4ddc8837072a619380728ba768843a57301cad6b8334b4fd2b59790a90a692f2/VERSION
4ddc8837072a619380728ba768843a57301cad6b8334b4fd2b59790a90a692f2/json
4ddc8837072a619380728ba768843a57301cad6b8334b4fd2b59790a90a692f2/layer.tar
5883e35a00216fff61bbe36f4f8a1fc8359e1d85d8889d4ba8441f5cf6226a7c/
5883e35a00216fff61bbe36f4f8a1fc8359e1d85d8889d4ba8441f5cf6226a7c/VERSION
5883e35a00216fff61bbe36f4f8a1fc8359e1d85d8889d4ba8441f5cf6226a7c/json
5883e35a00216fff61bbe36f4f8a1fc8359e1d85d8889d4ba8441f5cf6226a7c/layer.tar
6169006917012d05f8b0c586dcbbbb2d2a0c603ad8cd06a892a57495046c4eab/
6169006917012d05f8b0c586dcbbbb2d2a0c603ad8cd06a892a57495046c4eab/VERSION
6169006917012d05f8b0c586dcbbbb2d2a0c603ad8cd06a892a57495046c4eab/json
6169006917012d05f8b0c586dcbbbb2d2a0c603ad8cd06a892a57495046c4eab/layer.tar
934817bb8def699219dfa7975d2130723f969163e4c13985362acf246035a741/
934817bb8def699219dfa7975d2130723f969163e4c13985362acf246035a741/VERSION
934817bb8def699219dfa7975d2130723f969163e4c13985362acf246035a741/json
934817bb8def699219dfa7975d2130723f969163e4c13985362acf246035a741/layer.tar
9aa252519e7fe8e3c6d835823141fc8ef5757030a64589c625857c951ccb2227/
9aa252519e7fe8e3c6d835823141fc8ef5757030a64589c625857c951ccb2227/VERSION
9aa252519e7fe8e3c6d835823141fc8ef5757030a64589c625857c951ccb2227/json
9aa252519e7fe8e3c6d835823141fc8ef5757030a64589c625857c951ccb2227/layer.tar
b8064e6a78c59443ae1563850db719d118e3797d473781552fd28babefe1899d/
b8064e6a78c59443ae1563850db719d118e3797d473781552fd28babefe1899d/VERSION
b8064e6a78c59443ae1563850db719d118e3797d473781552fd28babefe1899d/json
b8064e6a78c59443ae1563850db719d118e3797d473781552fd28babefe1899d/layer.tar
cbcc60d48bcedacf42a5d7f652d45fbc4b775748b5ba42d556779629c404c0a9/
cbcc60d48bcedacf42a5d7f652d45fbc4b775748b5ba42d556779629c404c0a9/VERSION
cbcc60d48bcedacf42a5d7f652d45fbc4b775748b5ba42d556779629c404c0a9/json
cbcc60d48bcedacf42a5d7f652d45fbc4b775748b5ba42d556779629c404c0a9/layer.tar
cf70b74faf694929fd1005215faad2af6c9709b824d0fa32ac3589662b3c3911/
cf70b74faf694929fd1005215faad2af6c9709b824d0fa32ac3589662b3c3911/VERSION
cf70b74faf694929fd1005215faad2af6c9709b824d0fa32ac3589662b3c3911/json
cf70b74faf694929fd1005215faad2af6c9709b824d0fa32ac3589662b3c3911/layer.tar
d6b38f2419514f01b858e7d21f40aff34dc36c9dde58f7e8631154d2ea3b7816/
d6b38f2419514f01b858e7d21f40aff34dc36c9dde58f7e8631154d2ea3b7816/VERSION
d6b38f2419514f01b858e7d21f40aff34dc36c9dde58f7e8631154d2ea3b7816/json
d6b38f2419514f01b858e7d21f40aff34dc36c9dde58f7e8631154d2ea3b7816/layer.tar
d89d2a673f04d46d5e182cc487f2918d97e5bedaa081c822b7ef41fb91702157/
d89d2a673f04d46d5e182cc487f2918d97e5bedaa081c822b7ef41fb91702157/VERSION
d89d2a673f04d46d5e182cc487f2918d97e5bedaa081c822b7ef41fb91702157/json
d89d2a673f04d46d5e182cc487f2918d97e5bedaa081c822b7ef41fb91702157/layer.tar
e9d8442eba71b83bc4ba5f0079b87cfc45c2f8a369e2780aebec6fd84cf206f6/
e9d8442eba71b83bc4ba5f0079b87cfc45c2f8a369e2780aebec6fd84cf206f6/VERSION
e9d8442eba71b83bc4ba5f0079b87cfc45c2f8a369e2780aebec6fd84cf206f6/json
e9d8442eba71b83bc4ba5f0079b87cfc45c2f8a369e2780aebec6fd84cf206f6/layer.tar
f3d96bbceae775ec58582c1670ac2a2b062fe1e8a54bdcfb40b0699fe708ad68/
f3d96bbceae775ec58582c1670ac2a2b062fe1e8a54bdcfb40b0699fe708ad68/VERSION
f3d96bbceae775ec58582c1670ac2a2b062fe1e8a54bdcfb40b0699fe708ad68/json
f3d96bbceae775ec58582c1670ac2a2b062fe1e8a54bdcfb40b0699fe708ad68/layer.tar
fb26f999749b902d3d6446c1a9831ceb6c8150b89a274a04b5044f30cf81471d/
fb26f999749b902d3d6446c1a9831ceb6c8150b89a274a04b5044f30cf81471d/VERSION
fb26f999749b902d3d6446c1a9831ceb6c8150b89a274a04b5044f30cf81471d/json
fb26f999749b902d3d6446c1a9831ceb6c8150b89a274a04b5044f30cf81471d/layer.tar
manifest.json
repositories
```

Thôi thì đọc trước 2 file `manifest.json`, `repositories` vậy

Lần theo dấu vết của `repositories`

```text
{
  "todhudson1006/ascisfor": {
    "latest": "fb26f999749b902d3d6446c1a9831ceb6c8150b89a274a04b5044f30cf81471d"
  }
}
```

| Trường                     | Ý nghĩa                                                                                                                   |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `"todhudson1006/ascisfor"` | Tên đầy đủ của Docker image (tên người dùng + tên image)                                                                  |
| `"latest"`                 | Tag của image (ở đây là `latest`)                                                                                         |
| `"fb26f9..."`              | Digest (layer ID) tương ứng với tag `latest` – chính là layer được dùng làm **entrypoint (top layer)** khi load image lại |


Dùng đoạn value của key `latest` để ra search tên folder có value như vậy rồi đi vào đó

```bash
cd "fb26f999749b902d3d6446c1a9831ceb6c8150b89a274a04b5044f30cf81471d"
```

Bên trong là

```text
VERSION  json  layer.tar
```

Tạm gác lại file `json`  
file `VERSION` thì không có gì đặc biệt lắm, ta tiếp tục extract `layer.tar`

```bash
tar -xvf layer.tar
```

Phát hiện 1 folder `root`, đi vào thấy `flag` ngay

```bash
cat root/flag
```

```text
ASCIS{Th1s_1s_m4y_b3_n0t_r43l_fl4g}
```

Tuy nhiên đó là flag giả ==  
Khi nãy bên ngoài chúng ta còn 1 em file `json` chưa phân tích kĩ  
Quay lại xem thử nào  

```bash
cat json | jq
```

```text
{
  "id": "fb26f999749b902d3d6446c1a9831ceb6c8150b89a274a04b5044f30cf81471d",
  "parent": "2d7f13c9225ba680a4e3be0a0fa8e889ab968cd583ab62c61d991eada9038bfa",
  "created": "2023-10-25T07:31:35.470346231Z",
  "container": "3120bdc5293c652384de37f654c6d6445e73f29dcb9f251eeabf134d1c40d1c1",
  "container_config": {
    "Hostname": "3120bdc5293c",
    "Domainname": "",
    "User": "",
    "AttachStdin": false,
    "AttachStdout": false,
    "AttachStderr": false,
    "ExposedPorts": {
      "443/tcp": {},
      "80/tcp": {}
    },
    "Tty": false,
    "OpenStdin": false,
    "StdinOnce": false,
    "Env": [
      "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
      "NGINX_VERSION=1.25.2",
      "PKG_RELEASE=1",
      "NJS_VERSION=0.8.0"
    ],
    "Cmd": [
      "/bin/sh",
      "-c",
      "#(nop) ",
      "CMD [\"/usr/sbin/nginx\" \"-g\" \"daemon off;\"]"
    ],
    "Healthcheck": {
      "Test": [
        "CMD-SHELL",
        "curl --fail -k http://localhost:80 || exit 1"
      ]
    },
    "Image": "sha256:5203951dfb4ed292f8ef6b74ad1372068bbf45c10a038e978fdbff07b473cbe6",
    "Volumes": null,
    "WorkingDir": "",
    "Entrypoint": [
      "/docker-entrypoint.sh"
    ],
    "OnBuild": null,
    "Labels": {
      "MAINTAINER": "Sectigo <system@sectigo.one>",
      "maintainer": "NGINX Docker Maintainers <docker-maint@nginx.com>"
    },
    "StopSignal": "SIGQUIT"
  },
  "docker_version": "24.0.2",
  "config": {
    "Hostname": "",
    "Domainname": "",
    "User": "",
    "AttachStdin": false,
    "AttachStdout": false,
    "AttachStderr": false,
    "ExposedPorts": {
      "443/tcp": {},
      "80/tcp": {}
    },
    "Tty": false,
    "OpenStdin": false,
    "StdinOnce": false,
    "Env": [
      "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
      "NGINX_VERSION=1.25.2",
      "PKG_RELEASE=1",
      "NJS_VERSION=0.8.0"
    ],
    "Cmd": [
      "/usr/sbin/nginx",
      "-g",
      "daemon off;"
    ],
    "Healthcheck": {
      "Test": [
        "CMD-SHELL",
        "curl --fail -k http://localhost:80 || exit 1"
      ]
    },
    "Image": "sha256:5203951dfb4ed292f8ef6b74ad1372068bbf45c10a038e978fdbff07b473cbe6",
    "Volumes": null,
    "WorkingDir": "",
    "Entrypoint": [
      "/docker-entrypoint.sh"
    ],
    "OnBuild": null,
    "Labels": {
      "MAINTAINER": "Sectigo <system@sectigo.one>",
      "maintainer": "NGINX Docker Maintainers <docker-maint@nginx.com>"
    },
    "StopSignal": "SIGQUIT"
  },
  "architecture": "amd64",
  "os": "linux"
}
```

Nói sơ qua thì đây là metadata của một Docker image layer  
File này là một phần của cấu trúc lưu trữ image khi Docker image được export (`docker save`) ra file `.tar`.  

| Trường             | Ý nghĩa                                                  |
| ------------------ | -------------------------------------------------------- |
| `id`               | ID của layer này (SHA256)                                |
| `parent`           | ID của layer cha (lớp trước đó trong chuỗi image layers) |
| `created`          | Thời điểm layer được tạo                                 |
| `container`        | Container ID được dùng để tạo ra layer này               |
| `container_config` | Cấu hình container dùng để build layer này               |
| `config`           | Cấu hình của image sau khi thêm layer này                |
| `docker_version`   | Phiên bản Docker dùng                                    |
| `architecture`     | Kiến trúc CPU (ở đây là `amd64`)                         |
| `os`               | Hệ điều hành mục tiêu (`linux`)                          |

Dùng value của key `parent` để đi vào folder đó như khi nãy

```bash
cd "2d7f13c9225ba680a4e3be0a0fa8e889ab968cd583ab62c61d991eada9038bfa"
```

Cũng sẽ gặp lại 3 file như khi nãy là `VERSION`, `json` và `layer.tar`    
Extract `layer.tar`  

```bash
tar -xvf layer.tar
```

Kết quả

```text
root/
root/.wh.entrypoint.sh
root/flag
```

Chắc là flag real nhỉ??

```text
ASCIS{Y0u_f1nd_th4_fl4g_1n_D0ck4r}
```

---

## Who visited?

- **Resource**: [File](/assets/img/2024/01/whoattack.zip)
- **Description**:  
  *Uppercase the flag and Underline between character*

---

Giải nén file zip đề cho, ta sẽ có ngay 1 file `thi6.pcapng`  
Có vẻ đây là 1 bài Network Forensics rồi

Kiểm tra metadata của PCAPNG

```bash
capinfos thi6.pcapng
```

```text
File name:           thi6.pcapng
File type:           Wireshark/... - pcapng
File encapsulation:  Ethernet
File timestamp precision:  microseconds (6)
Packet size limit:   file hdr: (not set)
Number of packets:   5084
File size:           2391 kB
Data size:           2220 kB
Capture duration:    244.260707 seconds
First packet time:   2020-11-20 21:55:46.429682
Last packet time:    2020-11-20 21:59:50.690389
Data byte rate:      9090 bytes/s
Data bit rate:       72 kbps
Average packet size: 436.76 bytes
Average packet rate: 20 packets/s
SHA256:              f9d8e446d6c28f040a5b83cf112aaf66e666cff01800f03f97d215ce8267e347
RIPEMD160:           d7b346a9a73670aea4028ce2d44639f03e0dfc96
SHA1:                c8c10c3e8fb8bfe9558ded53ed97fa3d4405e4ba
Strict time order:   True
Capture hardware:    Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz (with SSE4.2)
Capture oper-sys:    Mac OS X 10.16, build 20B29 (Darwin 20.1.0)
Capture application: Dumpcap (Wireshark) 3.0.6 (v3.0.6-0-g908c8e357d0f)
Number of interfaces in file: 1
Interface #0 info:
                     Name = en0
                     Description = Wi-Fi
                     Encapsulation = Ethernet (1 - ether)
                     Capture length = 524288
                     Time precision = microseconds (6)
                     Time ticks per second = 1000000
                     Time resolution = 0x06
                     Operating system = Mac OS X 10.16, build 20B29 (Darwin 20.1.0)
                     Number of stat entries = 1
                     Number of packets = 5084
```

Xem các host có tham gia 

```bash
tshark -r capture.pcap -q -z endpoints,ip
```

```text
================================================================================
IPv4 Endpoints
Filter:<No Filter>
                       |  Packets  | |  Bytes  | | Tx Packets | | Tx Bytes | | Rx Packets | | Rx Bytes |
192.168.0.104               2920       1316981       1249          153008        1671         1163973
192.168.0.102               2079        889457       1021          281078        1058          608379
216.58.221.228               611        493989        443          474515         168           19474
49.213.114.128               396        355863        258          344135         138           11728
69.171.250.15                343         39682        169           20261         174           19421
192.168.0.1                  330         35111        166           21960         164           13151
216.58.199.98                321        127888        195          101070         126           26818
172.217.24.206               238         88581        133           33839         105           54742
13.226.210.71                235         57473        117           41564         118           15909
172.67.130.122               117         83323         66           78899          51            4424
172.217.31.227               114         69479         65           63540          49            5939
172.67.220.254               112         72941         63           68861          49            4080
87.250.251.119               109         24757         48           15110          61            9647
49.213.114.192                97         49452         43           42358          54            7094
199.217.116.50                92         32392         47           26446          45            5946
216.58.200.78                 91         50671         54           45018          37            5653
172.217.26.131                88         82842         28            3646          60           79196
216.58.200.14                 81         49703         46           45309          35            4394
172.217.24.195                78         40054         45           35682          33            4372
49.213.114.244                73         29182         32           23319          41            5863
216.58.220.198                71         25436         40           22173          31            3263
54.186.135.223                66         16845         34           13094          32            3751
117.18.237.29                 60          8912         28            5060          32            3852
13.225.103.90                 58         30526         33           27751          25            2775
49.213.78.75                  52          8413         24            5523          28            2890
216.58.200.67                 51          9173         21            3922          30            5251
69.171.250.35                 51         10038         25            5435          26            4603
13.225.103.16                 49         10587         23            7663          26            2924
216.58.200.65                 49         17697         26           14620          23            3077
224.0.0.251                   48         12228          0               0          48           12228
74.125.68.189                 46          4813         25            2533          21            2280
69.171.250.20                 46          9325         22            5531          24            3794
172.217.161.174               45         24423         26           21897          19            2526
49.213.114.147                44         11009         19            8139          25            2870
172.217.174.195               44         15079         19            8641          25            6438
172.217.161.142               43         26300         20            9657          23           16643
184.51.136.223                41         14717         18           12204          23            2513
49.213.78.34                  40         16024         19            7629          21            8395
103.229.10.173                40         12827         16           10677          24            2150
172.217.26.138                40          5251         18            2136          22            3115
64.233.189.155                38          5597         16            2563          22            3034
104.18.164.34                 38         12728         20           10490          18            2238
52.98.90.178                  37          8766         24            8064          13             702
49.213.78.33                  36         14220         17            6883          19            7337
216.58.199.14                 35         24248         20           17785          15            6463
172.217.24.66                 31          3564         16            1939          15            1625
13.225.103.113                29          8800         15            7045          14            1755
17.253.87.202                 28          8983         12            7303          16            1680
13.225.103.31                 28          9061         15            7125          13            1936
192.168.0.112                 26          7524         24            6766           2             758
172.217.174.206               20         13249         10            4494          10            8755
172.217.26.130                19          6441          9            3765          10            2676
216.58.197.104                18          1521          8             606          10             915
172.217.24.193                17          1474          7             540          10             934
49.213.114.5                  16          1083          8             591           8             492
192.168.0.100                 16          3282         16            3282           0               0
17.253.85.204                 14          4490          6            3652           8             838
13.225.103.68                 14          1143          6             474           8             669
108.177.97.188                13           850          6             422           7             428
192.168.0.101                 13          2298         10            1494           3             804
172.217.25.8                  13          4268          6            3299           7             969
49.213.114.177                10           975          5             669           5             306
113.171.64.17                 10           750          5             408           5             342
49.213.114.176                10           987          5             681           5             306
239.255.255.250                8          1736          0               0           8            1736
172.217.26.142                 7          5089          3            2441           4            2648
198.252.206.25                 6           348          2             132           4             216
216.58.220.206                 6           588          3             294           3             294
17.253.84.253                  6           540          3             270           3             270
52.98.84.82                    5           301          2             108           3             193
224.0.0.2                      4           184          0               0           4             184
17.57.145.53                   4           386          2             185           2             201
224.0.0.1                      2           100          0               0           2             100
224.0.0.22                     2           108          0               0           2             108
192.168.0.255                  2           220          0               0           2             220
================================================================================
```

Thống kê các protocol

```bash
tshark -r thi6.pcapng -q -z io,phs
```

```text
===================================================================
Protocol Hierarchy Statistics
Filter:

eth                                      frames:5084 bytes:2220491
  ip                                     frames:5045 bytes:2217673
    udp                                  frames:858 bytes:300745
      quic                               frames:256 bytes:188645
      data                               frames:210 bytes:61033
      dns                                frames:328 bytes:35011
      mdns                               frames:48 bytes:13560
      ssdp                               frames:8 bytes:1736
      ntp                                frames:6 bytes:540
      nbns                               frames:2 bytes:220
    tcp                                  frames:4153 bytes:1914377
      tls                                frames:1852 bytes:1295670
        tcp.segments                     frames:326 bytes:430604
          tls                            frames:280 bytes:392269
      http                               frames:14 bytes:7845
        ocsp                             frames:11 bytes:6749
          tcp.segments                   frames:3 bytes:1301
    igmp                                 frames:12 bytes:576
    icmp                                 frames:22 bytes:1975
  arp                                    frames:33 bytes:1548
    text                                 frames:6 bytes:306
  ipv6                                   frames:6 bytes:1270
    icmpv6                               frames:4 bytes:360
    udp                                  frames:2 bytes:910
      mdns                               frames:2 bytes:910
===================================================================
```

Thống kê thời gian

```bash
tshark -r thi6.pcapng -q -z io,stat,0
```

```text
=====================================
| IO Statistics                     |
|                                   |
| Duration: 244.3 secs              |
| Interval: 244.3 secs              |
|                                   |
| Col 1: Frames and bytes           |
|-----------------------------------|
|                |1                 |
| Interval       | Frames |  Bytes  |
|-----------------------------------|
|   0.0 <> 244.3 |   5084 | 2220491 |
=====================================
```

Từ `protocol stats`: ICMP là nhóm nhỏ nhưng tồn tại

```text
icmp frames: 22 bytes: 1975
```

Với hơn 5000 packets, thì chỉ có 22 là ICMP — Một con số rất nhỏ.

Nhưng chính vì số lượng ít mà vẫn tồn tại, nên ta sẽ bắt đầu phân tích ICMP trước rồi mới đến các kênh phổ biến (HTTP, DNS, TLS, QUIC...).

Từ `endpoints`: Ta có thể nghi ngờ các giao tiếp nội bộ 

```text
192.168.0.102 <=> 192.168.0.104
Packets: 2079 <=> 2920
```

Không có HTTP hoặc TLS giữa hai IP này, có lẽ không phải lướt web.

Nhưng vẫn có lưu lượng tương tác nhiều, nghi vấn giao tiếp ngầm hoặc điều khiển.

So với các IP ngoài (Google, Facebook...) thì 102 và 104 giao tiếp nội bộ, có thể là attacker đang ẩn mình hoặc truyền dữ liệu lén.

`capinfos` cũng cho ta thấy 
Gói ICMP rải rác (frame 2837, 4637, 4871...) trong suốt 4 phút  
Không phải một chuỗi ping liên tục, mà là ping theo kiểu ngắt quãng có chủ đích, hành vi giống covert channel.

```text
Capture duration: 244.3 secs
Average packet rate: 20 packets/s
```

Tiến hành lọc toàn bộ gói ICMP để xem chi tiết hơn

```bash
tshark -r thi6.pcapng -Y "icmp" -T fields \
  -e frame.number \
  -e frame.time_relative \
  -e ip.src \
  -e ip.dst \
  -e icmp.type \
  -e icmp.seq \
  -e data
```

```text
958     42.616159000    192.168.0.104   216.58.220.206  8       1       513c040000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
959     42.680923000    216.58.220.206  192.168.0.104   0       1       513c040000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
982     43.617651000    192.168.0.104   216.58.220.206  8       2       2042040000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
983     43.663613000    216.58.220.206  192.168.0.104   0       2       2042040000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
1005    44.619138000    192.168.0.104   216.58.220.206  8       3       0348040000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
1009    44.681907000    216.58.220.206  192.168.0.104   0       3       0348040000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
2836    116.010384000   192.168.0.104   192.168.0.102   8       1       64484a316553426a5958416762574635494764705957356e49485a70
2837    116.010460000   192.168.0.102   192.168.0.104   0       1       64484a316553426a5958416762574635494764705957356e49485a70
4637    197.822558000   192.168.0.104   192.168.0.102   8       1       5a573467646d397049484e6f59584a6c4947467549476c6a6258416b4947526c49
4638    197.822634000   192.168.0.102   192.168.0.104   0       1       5a573467646d397049484e6f59584a6c4947467549476c6a6258416b4947526c49
4871    227.601156000   192.168.0.104   192.168.0.102   8       1       4778686553426b595841675957343d
4872    227.601235000   192.168.0.102   192.168.0.104   0       1       4778686553426b595841675957343d
5030    239.579231000   192.168.0.104   69.171.250.35   8       1       8edb030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5034    239.612007000   69.171.250.35   192.168.0.104   0       1       8edb030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5060    240.580759000   192.168.0.104   69.171.250.35   8       2       6ae2030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5062    240.613002000   69.171.250.35   192.168.0.104   0       2       6ae2030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5065    241.582721000   192.168.0.104   69.171.250.35   8       3       19ea030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5066    241.613268000   69.171.250.35   192.168.0.104   0       3       19ea030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5071    242.583646000   192.168.0.104   69.171.250.35   8       4       f4ec030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5072    242.622464000   69.171.250.35   192.168.0.104   0       4       f4ec030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5076    243.585232000   192.168.0.104   69.171.250.35   8       5       2cf4030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
5078    243.622611000   69.171.250.35   192.168.0.104   0       5       2cf4030000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
```

Hầu hết các gói ICMP trong capture đều mang payload mẫu mặc định  
Đây là payload mặc định của lệnh ping, không chứa thông tin gì đặc biệt

```text
101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
```

Ngược lại, có 3 cụm gói có payload khác biệt rõ ràng và chứa dữ liệu có thể là base64 hoặc ASCII

```text
2836–2837: 64484a316553426a5958416762574635494764705957356e49485a70
4637–4638: 5a573467646d397049484e6f59584a6c4947467549476c6a6258416b4947526c49
4871–4872: 4778686553426b595841675957343d
```

Đây là 3 đoạn dữ liệu lạ nằm trong ICMP Echo Request/Reply nội bộ (giữa 192.168.0.104 và 192.168.0.102).  
Ngoài ra, ta thấy:
- Tất cả có ICMP Type 8 (request) và Type 0 (reply)
- Gói này không gửi ra ngoài Internet như mấy gói tới 216.58... hay 69.171... (Google, Facebook...)

Gom payload của 3 gói trên lại rồi giải mã nào  

```bash
echo "64484a316553426a5958416762574635494764705957356e49485a70\
5a573467646d397049484e6f59584a6c4947467549476c6a6258416b4947526c49\
4778686553426b595841675957343d" | xxd -r -p | base64 -d
```

```text
truy cap may giang vien voi share an icmp$ de lay dap an
```

Hint của đề là:  
*Uppercase the flag and Underline between character*

Nên maybe flag sẽ như này??

```
HUFLIT{TRUY_CAP_MAY_GIANG_VIEN_VOI_SHARE_AN_ICMP$_DE_LAY_DAP_AN}
```

---

## Riverside

- **Resource**: [File](https://8yh843-my.sharepoint.com/:u:/g/personal/tnqa_8yh843_onmicrosoft_com/ESuDPS7AnrhEoHI5gWfKiV0BRbGQBXCuYtpdXV6iPYldyw?e=uP3u16)
- **Description**:  
  *format flag: HUFLIT{md5(flag)}*

---

Bổ file đề ra bằng `unzip`, ta có ngay 1 em file `mem` khá múp (~ 3.6GB) =))

```bash
file mem
```

```text
mem: DOS/MBR boot sector, code offset 0x52+2, OEM-ID "NTFS    ", sectors/cluster 8, Media descriptor 0xf8, sectors/track 63, heads 255, hidden sectors 128, dos < 4.0 BootSector (0), FAT (1Y bit by descriptor); NTFS, sectors/track 63, physical drive 0x80, sectors 7573503, $MFT start cluster 262144, $MFTMirror start cluster 2, bytes/RecordSegment 2^(-1*246), clusters/index block 1, serial number 0b4de8f7ade8f33a0; contains bootstrap BOOTMGR
```

File này là một sector khởi động (boot sector) từ vùng đầu của một ổ đĩa hoặc phân vùng.  
Dữ liệu boot sector này chứa thông tin quan trọng về cấu trúc phân vùng và được sử dụng khi máy tính khởi động.

Chi tiết thì

| Trường                            | Ý nghĩa                                                                                                                                            |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `DOS/MBR boot sector`             | Đây là một boot sector theo định dạng MBR (Master Boot Record), có thể được dùng bởi BIOS để boot vào hệ điều hành.                                |
| `code offset 0x52+2`              | Mã khởi động (bootstrap code) bắt đầu từ offset `0x52+2 = 0x54` (84 thập phân).                                                                    |
| `OEM-ID "NTFS    "`               | Chuỗi OEM ID là "NTFS    ", định dạng phân vùng là NTFS. Chuỗi này thường bắt đầu từ offset 0x03.                                                  |
| `sectors/cluster 8`               | Mỗi cluster chứa 8 sector. Với sector size thường là 512 byte → 1 cluster = 4 KB.                                                                  |
| `Media descriptor 0xf8`           | Giá trị 0xF8 là descriptor cho ổ cứng chuẩn. (Floppy dùng 0xF0)                                                                                    |
| `sectors/track 63`                | Số sector trên mỗi track là 63 (chuẩn thông thường trong BIOS CHS geometry).                                                                       |
| `heads 255`                       | Có 255 đầu đọc/ghi trên mỗi cylinder (CHS geometry chuẩn).                                                                                         |
| `hidden sectors 128`              | Có 128 sector bị ẩn trước phân vùng này (thường là khoảng không gian chứa MBR hoặc partition table).                                               |
| `dos < 4.0 BootSector (0)`        | Mã khởi động tương thích với DOS phiên bản dưới 4.0, có thể là flag phân tích.                                                                     |
| `FAT (1Y bit by descriptor)`      | Có thể đang tham chiếu đến cách nhận diện loại hệ thống file qua Media Descriptor. Tuy nhiên, ở đây định dạng là NTFS.                             |
| `NTFS`                            | Nhấn mạnh lại hệ thống tập tin là **NTFS** (Windows NT File System).                                                                               |
| `physical drive 0x80`             | BIOS device number `0x80` — đây là ổ đĩa đầu tiên (primary hard disk).                                                                             |
| `sectors 7573503`                 | Tổng số sector trong phân vùng này là 7,573,503. Với sector 512 byte → khoảng 3.6 GB.                                                              |
| `$MFT start cluster 262144`       | `$MFT` (Master File Table) — bảng quản lý tập tin chính bắt đầu tại cluster 262144.                                                                |
| `$MFTMirror start cluster 2`      | `$MFTMirror` — bản sao dự phòng của `$MFT`, đặt tại cluster 2.                                                                                     |
| `bytes/RecordSegment 2^(-1*246)`  | Cái này hơi bất thường. Giá trị thông thường là 1024, 2048, 4096… Dạng biểu diễn log 2 có thể là cách phân tích của công cụ. Có khả năng lỗi dịch. |
| `clusters/index block 1`          | Có 1 cluster trên mỗi index block (dùng cho directory indexing).                                                                                   |
| `serial number 0b4de8f7ade8f33a0` | Serial number duy nhất của phân vùng (GUID-like), dùng để nhận diện.                                                                               |
| `contains bootstrap BOOTMGR`      | Có chứa **BOOTMGR**, tức là vùng này có thể khởi động vào Windows loader.                                                                          |

Đây là một phân vùng khởi động NTFS, có thể là ổ `C:\` của một hệ điều hành Windows.  
Đã chứa BOOTMGR, có khả năng khởi động hệ thống.  
`$MFT` và `$MFTMirror` được định vị rõ ràng, điều này sẽ giúp kiểm tra/recover dữ liệu nếu có lỗi.  
Các tham số CHS (sectors/track, heads) là để đảm bảo tương thích BIOS cũ, thường không còn được sử dụng trong hệ thống hiện đại (sử dụng LBA).

Dùng `fsstat` để xem thử thông tin có gì mới không

```bash
fsstat mem
```

```text
FILE SYSTEM INFORMATION
--------------------------------------------
File System Type: NTFS
Volume Serial Number: B4DE8F7ADE8F33A0
OEM Name: NTFS
Volume Name: recover
Version: Windows XP

METADATA INFORMATION
--------------------------------------------
First Cluster of MFT: 262144
First Cluster of MFT Mirror: 2
Size of MFT Entries: 1024 bytes
Size of Index Records: 4096 bytes
Range: 0 - 256
Root Directory: 5

CONTENT INFORMATION
--------------------------------------------
Sector Size: 512
Cluster Size: 4096
Total Cluster Range: 0 - 946686
Total Sector Range: 0 - 7573502

$AttrDef Attribute Values:
$STANDARD_INFORMATION (16)   Size: 48-72   Flags: Resident
$ATTRIBUTE_LIST (32)   Size: No Limit   Flags: Non-resident
$FILE_NAME (48)   Size: 68-578   Flags: Resident,Index
$OBJECT_ID (64)   Size: 0-256   Flags: Resident
$SECURITY_DESCRIPTOR (80)   Size: No Limit   Flags: Non-resident
$VOLUME_NAME (96)   Size: 2-256   Flags: Resident
$VOLUME_INFORMATION (112)   Size: 12-12   Flags: Resident
$DATA (128)   Size: No Limit   Flags:
$INDEX_ROOT (144)   Size: No Limit   Flags: Resident
$INDEX_ALLOCATION (160)   Size: No Limit   Flags: Non-resident
$BITMAP (176)   Size: No Limit   Flags: Non-resident
$REPARSE_POINT (192)   Size: 0-16384   Flags: Non-resident
$EA_INFORMATION (208)   Size: 8-8   Flags: Resident
$EA (224)   Size: 0-65536   Flags:
$LOGGED_UTILITY_STREAM (256)   Size: 0-65536   Flags: Non-resident
```

**FILE SYSTEM INFORMATION**

| Trường                                     | Ý nghĩa                                                                                                                                |
| ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| **File System Type: NTFS**                 | Xác nhận hệ thống tập tin là NTFS (New Technology File System – của Windows).                                                          |
| **Volume Serial Number: B4DE8F7ADE8F33A0** | Số nhận dạng duy nhất của volume, trùng với boot sector. Có thể dùng để xác định partition.                                            |
| **OEM Name: NTFS**                         | Tên OEM đặt trong boot sector, thường là “NTFS    ” trong hệ thống NTFS chuẩn.                                                         |
| **Volume Name: recover**                   | Tên của ổ đĩa (volume label) là `recover`.                                                                                             |
| **Version: Windows XP**                    | Phiên bản hệ điều hành ghi format filesystem này là Windows XP – lưu ý là format thôi chứ không có nghĩa hệ điều hành đang dùng là XP. |

**METADATA INFORMATION**

| Trường                                | Ý nghĩa                                                                                                       |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **First Cluster of MFT: 262144**      | `$MFT` là bảng ghi thông tin về tất cả file – bắt đầu ở cluster 262144.                                       |
| **First Cluster of MFT Mirror: 2**    | `$MFTMirr` – bản sao của `$MFT` dùng để khôi phục nếu MFT chính bị hỏng.                                      |
| **Size of MFT Entries: 1024 bytes**   | Mỗi bản ghi trong `$MFT` có kích thước 1024 byte.                                                             |
| **Size of Index Records: 4096 bytes** | Kích thước bản ghi index trong thư mục, thường là 1 cluster = 4096 byte.                                      |
| **Range: 0 - 256**                    | Có thể là ID range của system metadata entries, ví dụ Entry 0 là `$MFT`, 5 là thư mục gốc (`Root Directory`). |
| **Root Directory: 5**                 | Entry ID 5 trong MFT là thư mục gốc (`/`). Trong NTFS, đây là quy ước chuẩn.                                  |


**CONTENT INFORMATION**

| Trường                              | Ý nghĩa                                                                     |
| ----------------------------------- | --------------------------------------------------------------------------- |
| **Sector Size: 512**                | Mỗi sector có 512 byte.                                                     |
| **Cluster Size: 4096**              | Mỗi cluster gồm 8 sector → 4096 byte (chuẩn NTFS hiện đại).                 |
| **Total Cluster Range: 0 - 946686** | Tổng số cluster = 946,687. Tổng dung lượng ổ = 946,687 × 4096B ≈ **3.6 GB** |
| **Total Sector Range: 0 - 7573502** | Tổng sector = 7,573,503 × 512B = 3.8 GB                                     |


**$AttrDef Attribute Values**

Bảng này liệt kê các attribute chuẩn của NTFS – mỗi file là 1 record trong $MFT, và được biểu diễn bởi các attribute.

| Tên                      | Mã (ID)  | Ý nghĩa                                                  | Kích thước | Cờ                  |
| ------------------------ | -------- | -------------------------------------------------------- | ---------- | ------------------- |
| `$STANDARD_INFORMATION`  | 16       | Metadata cơ bản: thời gian tạo, quyền, flags             | 48-72      | **Resident**        |
| `$ATTRIBUTE_LIST`        | 32       | Dùng khi file có nhiều attribute phân tán                | No limit   | **Non-resident**    |
| `$FILE_NAME`             | 48       | Tên file + metadata nhỏ                                  | 68–578     | **Resident, Index** |
| `$OBJECT_ID`             | 64       | GUID ID của file (ít gặp)                                | 0–256      | **Resident**        |
| `$SECURITY_DESCRIPTOR`   | 80       | ACL, owner, SID…                                         | No limit   | **Non-resident**    |
| `$VOLUME_NAME`           | 96       | Label của ổ đĩa                                          | 2–256      | **Resident**        |
| `$VOLUME_INFORMATION`    | 112      | Thông tin về volume: version, flags…                     | 12         | **Resident**        |
| `$DATA`                  | 128      | Dữ liệu chính của file                                   | No limit   | —                   |
| `$INDEX_ROOT`            | 144      | Dữ liệu chỉ mục của thư mục nhỏ (B+ tree)                | No limit   | **Resident**        |
| `$INDEX_ALLOCATION`      | 160      | Danh sách cluster chứa index (với thư mục lớn)           | No limit   | **Non-resident**    |
| `$BITMAP`                | 176      | Bitmap theo dõi index allocation                         | No limit   | **Non-resident**    |
| `$REPARSE_POINT`         | 192      | Điểm nối lại như symlink, junction                       | 0–16384    | **Non-resident**    |
| `$EA_INFORMATION`, `$EA` | 208, 224 | Extended Attributes (thường không dùng trên NTFS thường) | 8; 0–65536 | Vary                |
| `$LOGGED_UTILITY_STREAM` | 256      | Dữ liệu hệ thống phục vụ file consistency                | 0–65536    | **Non-resident**    |


Tóm lại:

- Đây là volume NTFS kích thước ~3.6GB, định dạng bởi hệ điều hành (hoặc tool) thuộc thời Windows XP.
- Volume được đặt tên là recover → có thể là phân vùng phục hồi, forensic hoặc dữ liệu cứu hộ.
- MFT và metadata là chuẩn NTFS, có thể dễ dàng phân tích bằng fls, istat, icat, mftdump, hoặc analyzeMFT.
- Có thể truy xuất $MFT, xem cấu trúc file, extract file bị xóa nếu chưa bị overwrite.

Vậy thì dò folder và file thoi nào

```bash
fls -f ntfs -o 0 mem
```

```text
r/r 4-128-1:    $AttrDef
r/r 8-128-2:    $BadClus
r/r 8-128-1:    $BadClus:$Bad
r/r 6-128-4:    $Bitmap
r/r 7-128-1:    $Boot
d/d 11-144-4:   $Extend
r/r 2-128-1:    $LogFile
r/r 0-128-6:    $MFT
r/r 1-128-1:    $MFTMirr
r/r 9-128-8:    $Secure:$SDS
r/r 9-144-11:   $Secure:$SDH
r/r 9-144-14:   $Secure:$SII
r/r 10-128-1:   $UpCase
r/r 10-128-4:   $UpCase:$Info
r/r 3-128-3:    $Volume
d/d 36-144-1:   System Volume Information
d/- * 0:        thi2
d/- * 42:       Web
-/d * 39-144-5: thi2
V/V 256:        $OrphanFiles
```

Kết quả trên cho thấy các file hệ thống của NTFS như `$MFT`, `$LogFile`, `$AttrDef`, và cả các thư mục người dùng như `thi2` và `Web`.

Các entry quan trọng

| Entry                                     | Ý nghĩa                                                                                     |
| ----------------------------------------- | ------------------------------------------------------------------------------------------- |
| `r/r 0-128-6: $MFT`                       | Bảng Master File Table – trái tim của hệ thống file NTFS.                                   |
| `r/r 1-128-1: $MFTMirr`                   | Bản sao của MFT, dùng khi bị lỗi.                                                           |
| `d/- * 0: thi2`                           | **Thư mục gốc** hoặc thư mục đặc biệt được người dùng tạo. Ký hiệu `*` cho biết **bị xóa**. |
| `d/d 36-144-1: System Volume Information` | Thư mục hệ thống dùng bởi Windows cho các restore point, Indexing, v.v.                     |
| `V/V 256: $OrphanFiles`                   | Thư mục chứa **các file rời rạc hoặc bị xóa nhưng chưa overwrite** – dùng để khôi phục.     |
| `d/- * 42: Web`                           | Một thư mục người dùng khác – **đã bị xóa**.                                                |


Có 2 bản ghi `thi2`:

```text
d/- * 0: thi2
-/d * 39-144-5: thi2
```

Dùng bản ghi thứ hai vì có inode thật (không phải `0` – thường là `root` hoặc damaged)

```bash
fls -f ntfs -o 0 mem 39
```

```
r/r * 40-128-1: bando.jpg
r/r * 40-128-3: bando.jpg:com.apple.lastuseddate#PS
r/r * 40-128-4: bando.jpg:com.apple.metadatakMDItemWhereFroms
r/r * 40-128-5: bando.jpg:com.apple.metadata_kMDItemUserTags
r/r * 40-128-6: bando.jpg:com.apple.quarantine
d/d * 48-144-1: hinh
r/r * 41-128-1: hublot.jpg
r/r * 41-128-3: hublot.jpg:com.apple.lastuseddate#PS
r/r * 41-128-4: hublot.jpg:com.apple.quarantine
r/r * 42-128-1: khobau.jpg
r/r * 42-128-3: khobau.jpg:com.apple.lastuseddate#PS
r/r * 42-128-4: khobau.jpg:com.apple.metadatakMDItemWhereFroms
r/r * 42-128-5: khobau.jpg:com.apple.metadata_kMDItemUserTags
r/r * 42-128-6: khobau.jpg:com.apple.quarantine
r/r * 43-128-1: network.pcap
r/r * 43-128-3: network.pcap:com.apple.metadatakMDItemWhereFroms
r/r * 43-128-4: network.pcap:com.apple.quarantine
r/r * 44-128-1: thi2.zip
r/r * 45-128-1: thongbao.pdf
r/r * 45-128-3: thongbao.pdf:AFP_AfpInfo
r/r * 45-128-4: thongbao.pdf:com.apple.quarantine
r/r * 46-128-3: thuxanh.rtf
r/r * 46-128-4: thuxanh.rtf:AFP_AfpInfo
r/r * 46-128-5: thuxanh.rtf:com.apple.lastuseddate#PS
r/r * 46-128-6: thuxanh.rtf:com.apple.metadatakMDLabel_7yj6tur34gg767v6joha44wo6q
r/r * 46-128-7: thuxanh.rtf:com.apple.metadata_kMDItemUserTags
d/d * 51-144-1: untitled folder
r/r * 47-128-1: Victory-TwoStepsFromHell-3890867.mp3
r/r * 47-128-3: Victory-TwoStepsFromHell-3890867.mp3:com.apple.lastuseddate#PS
r/r * 47-128-4: Victory-TwoStepsFromHell-3890867.mp3:com.apple.metadatakMDItemWhereFroms
r/r * 47-128-5: Victory-TwoStepsFromHell-3890867.mp3:com.apple.quarantine
```

Danh sách file chính trong thi2 cần recover

| Inode      | Tên file                       | Ghi chú          |
| ---------- | ------------------------------ | ---------------- |
| `40-128-1` | `bando.jpg`                    | Ảnh              |
| `41-128-1` | `hublot.jpg`                   | Ảnh              |
| `42-128-1` | `khobau.jpg`                   | Ảnh              |
| `43-128-1` | `network.pcap`                 | Gói dữ liệu mạng |
| `44-128-1` | `thi2.zip`                     | File nén         |
| `45-128-1` | `thongbao.pdf`                 | Tài liệu PDF     |
| `46-128-3` | `thuxanh.rtf`                  | Văn bản          |
| `47-128-1` | `Victory-TwoStepsFromHell.mp3` | Nhạc             |

Các file khác như `*:AFP_AfpInfo`, `*:com.apple.*` là **metadata** (không quan trọng với việc recover dữ liệu chính)

Dùng `icat` để recover

```bash
mkdir -p recovered/thi2
icat -f ntfs -o 0 mem 40 > recovered/thi2/bando.jpg
icat -f ntfs -o 0 mem 41 > recovered/thi2/hublot.jpg
icat -f ntfs -o 0 mem 42 > recovered/thi2/khobau.jpg
icat -f ntfs -o 0 mem 43 > recovered/thi2/network.pcap
icat -f ntfs -o 0 mem 44 > recovered/thi2/thi2.zip
icat -f ntfs -o 0 mem 45 > recovered/thi2/thongbao.pdf
icat -f ntfs -o 0 mem 46 > recovered/thi2/thuxanh.rtf
icat -f ntfs -o 0 mem 47 > recovered/thi2/Victory-TwoStepsFromHell.mp3
```

Có 2 thư mục con là `hinh` inode 48 và `untitled folder` inode 51, nhưng có lẽ để sau

Trong đấy có 1 em file zip là `thi2.zip` nhưng em này cần password T-T

Lảo đảo thì có 1 em file document là `thuxanh.rtf` với nội dung trông khá "bình thường", đọc thì chẳng có nghĩa gì mấy :b

![thuxanh.rtf](/assets/img/2024/01/thuxanh.png)

Dạo quanh một hồi thì có em file `thongbao.pdf`, bên trong chứa một đoạn chữ nhỏ xíu, giấu tít phía góc dưới =.=

![alt text](/assets/img/2024/01/spammimic.png)

> Mở bằng trình đọc PDF nào đó hẳn hoi thì dễ thấy hơn là browser nhé 

[`Spam Mimic`](https://www.spammimic.com/) đơn giản là một tool giúp chuyển đổi 1 đoạn tin thành 1 đoạn trông như là spam và có thể làm ngược lại

Nhớ lại khi nãy em `thuxanh.rtf` có nội dung khá "bình thường"  
Đem đống đó đi decode bằng [`Spam Mimic`](https://www.spammimic.com/) nào =))  

Kết quả

```text
Y2FsbCBtZSAwOTAyNjU5MDUw
```

Theo trực giác của 1 dân chơi mã hóa thì đoạn đấy là Base64 encoded đấy =))

```bash
echo "Y2FsbCBtZSAwOTAyNjU5MDUw" | base64 -d
```

Kết quả hay đấy

```text
call me 0902659050
```

Thế là gọi vào `0902659050` rồi hỏi flag à =))??

Thử đem đoạn trên dùng làm password để extract `thi2.zip` khi nãy thử

Kết quả thì... không khả thi lắm ==

![alt text](/assets/img/2024/01/thi2zip.png)

Loay hoay với cái sđt `0902659050` một hồi thì nhớ lại con điện thoại nokia cũ xì của ông thầy  
Có bàn phím như này  

![Nokia keypad](/assets/img/2024/01/phone.png)

Dựa theo cách đánh chữ và ký tự trên con phone của thầy thì từ số `0902659050`, ta có thể ra 1 đoạn mới vô nghĩa mà hữu dụng trong bài này =))

```text
0 9 0 2 6 5 9 0 5 0
+ w + a m j w + j +
```

`+w+amjw+j+` chính là password để extract `thi2.zip` 

Di chuyển tiếp vào trong `thi2`, ta sẽ thấy 1 tấm hình `thi2.jpg`

![thi2.jpg](/assets/img/2024/01/thi2.jpg)

Dùng `exiftool` check tiếp hình này nào

```bash
exiftool thi2.jpg
```

```text
ExifTool Version Number         : 12.40
File Name                       : thi2.jpg
Directory                       : .
File Size                       : 3.0 MiB
File Modification Date/Time     : 2018:09:23 13:42:19+07:00
File Access Date/Time           : 2019:10:31 09:36:05+07:00
File Inode Change Date/Time     : 2025:06:27 00:02:49+07:00
File Permissions                : -rwxrwxrwx
File Type                       : JPEG
File Type Extension             : jpg
MIME Type                       : image/jpeg
Exif Byte Order                 : Big-endian (Motorola, MM)
Make                            : Apple
Camera Model Name               : iPhone 7 Plus
X Resolution                    : 72
Y Resolution                    : 72
Resolution Unit                 : inches
Software                        : 12.0
Modify Date                     : 2018:09:23 13:42:19
Y Cb Cr Positioning             : Centered
Exposure Time                   : 1/2128
F Number                        : 1.8
Exposure Program                : Program AE
ISO                             : 20
Exif Version                    : 0221
Date/Time Original              : 2018:09:23 13:42:19
Create Date                     : 2018:09:23 13:42:19
Components Configuration        : Y, Cb, Cr, -
Shutter Speed Value             : 1/2128
Aperture Value                  : 1.8
Brightness Value                : 9.892353013
Exposure Compensation           : 0
Metering Mode                   : Multi-segment
Flash                           : Auto, Did not fire
Focal Length                    : 4.0 mm
Subject Area                    : 2015 1511 2217 1330
Run Time Flags                  : Valid
Run Time Value                  : 4415928790041
Run Time Scale                  : 1000000000
Run Time Epoch                  : 0
Acceleration Vector             : 0.006496704652 -0.9607270367 -0.2691131831
Sub Sec Time Original           : 723
Sub Sec Time Digitized          : 723
Flashpix Version                : 0100
Color Space                     : Uncalibrated
Exif Image Width                : 3024
Exif Image Height               : 4032
Sensing Method                  : One-chip color area
Scene Type                      : Directly photographed
Exposure Mode                   : Auto
White Balance                   : Auto
Focal Length In 35mm Format     : 28 mm
Scene Capture Type              : Standard
Lens Info                       : 3.99000001-6.6mm f/1.8-2.8
Lens Make                       : Apple
Lens Model                      : iPhone 7 Plus back dual camera 3.99mm f/1.8
GPS Latitude Ref                : North
GPS Longitude Ref               : East
GPS Altitude Ref                : Above Sea Level
GPS Time Stamp                  : 06:42:19
GPS Speed Ref                   : km/h
GPS Speed                       : 1.25
GPS Img Direction Ref           : True North
GPS Img Direction               : 265.9993284
GPS Dest Bearing Ref            : True North
GPS Dest Bearing                : 265.9993284
GPS Date Stamp                  : 2018:09:23
GPS Horizontal Positioning Error: 30 m
Compression                     : JPEG (old-style)
Thumbnail Offset                : 2206
Thumbnail Length                : 9219
Profile CMM Type                : Apple Computer Inc.
Profile Version                 : 4.0.0
Profile Class                   : Display Device Profile
Color Space Data                : RGB
Profile Connection Space        : XYZ
Profile Date Time               : 2017:07:07 13:22:32
Profile File Signature          : acsp
Primary Platform                : Apple Computer Inc.
CMM Flags                       : Not Embedded, Independent
Device Manufacturer             : Apple Computer Inc.
Device Model                    :
Device Attributes               : Reflective, Glossy, Positive, Color
Rendering Intent                : Perceptual
Connection Space Illuminant     : 0.9642 1 0.82491
Profile Creator                 : Apple Computer Inc.
Profile ID                      : ca1a9582257f104d389913d5d1ea1582
Profile Description             : Display P3
Profile Copyright               : Copyright Apple Inc., 2017
Media White Point               : 0.95045 1 1.08905
Red Matrix Column               : 0.51512 0.2412 -0.00105
Green Matrix Column             : 0.29198 0.69225 0.04189
Blue Matrix Column              : 0.1571 0.06657 0.78407
Red Tone Reproduction Curve     : (Binary data 32 bytes, use -b option to extract)
Chromatic Adaptation            : 1.04788 0.02292 -0.0502 0.02959 0.99048 -0.01706 -0.00923 0.01508 0.75168
Blue Tone Reproduction Curve    : (Binary data 32 bytes, use -b option to extract)
Green Tone Reproduction Curve   : (Binary data 32 bytes, use -b option to extract)
Image Width                     : 3024
Image Height                    : 4032
Encoding Process                : Baseline DCT, Huffman coding
Bits Per Sample                 : 8
Color Components                : 3
Y Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)
Run Time Since Power Up         : 1:13:36
Aperture                        : 1.8
Image Size                      : 3024x4032
Megapixels                      : 12.2
Scale Factor To 35 mm Equivalent: 7.0
Shutter Speed                   : 1/2128
Create Date                     : 2018:09:23 13:42:19.723
Date/Time Original              : 2018:09:23 13:42:19.723
Thumbnail Image                 : (Binary data 9219 bytes, use -b option to extract)
GPS Altitude                    : 11.1 m Above Sea Level
GPS Date/Time                   : 2018:09:23 06:42:19Z
GPS Latitude                    : 21 deg 2' 49.13" N
GPS Longitude                   : 105 deg 54' 53.56" E
Circle Of Confusion             : 0.004 mm
Field Of View                   : 65.5 deg
Focal Length                    : 4.0 mm (35 mm equivalent: 28.0 mm)
GPS Position                    : 21 deg 2' 49.13" N, 105 deg 54' 53.56" E
Hyperfocal Distance             : 2.07 m
Light Value                     : 15.1
Lens ID                         : iPhone 7 Plus back dual camera 3.99mm f/1.8
```

Theo tên đề bài thì có lẽ nó liên quan đến GPS nhiều hơn nhỉ??

| Trường                   | Giá trị                            |
| ------------------------ | ---------------------------------- |
| **GPS Position**         | 21° 2' 49.13" N, 105° 54' 53.56" E |
| **Địa điểm**             | Trung tâm **Hà Nội**, Việt Nam     |
| **GPS Altitude**         | 11.1 m trên mực nước biển          |
| **GPS Speed**            | 1.25 km/h                          |
| **GPS Img Direction**    | 266° (hướng Tây)                   |
| **GPS Horizontal Error** | 30 m                               |

![alt text](/assets/img/2024/01/riverside.png)

Đúng là `riverside` thật =))

Thôi thì hash md5 tọa độ lấy flag luon nhe

```bash
echo -n "21 deg 2' 49.13\" N, 105 deg 54' 53.56\" E" | md5sum
```

Flag:  

```text
HUFLIT{f66e45234d4536cb88f12bc2cc95f760}
```

---

