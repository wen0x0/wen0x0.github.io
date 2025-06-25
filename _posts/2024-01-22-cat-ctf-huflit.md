---
title: "CTF HUFLIT · Cat"
date: 2024-01-22 23:10:32 +0700
categories: [CTF, Forensics]
tags: [write-ups, forensics, ctf huflit]
pin: false
comments: true
published: true
---

## Challenge Info

- **Name**: Cat  
- **Category**: Forensics  
- **Platform**: CTF HUFLIT  
- **Resource**: [Download file](/assets/img/2024/01/Cat.jpg)
- **Description**:  
  *What is hidden behind picture? nyan*

- **Hints**:  
  - *What is hexadecimal?*  
  - *Decode 1 time not enough hehehe*


---

## Recon & Initial Analysis

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

---

## Step-by-step Solution

Dựa vào hint 1 là:  
*What is Hexadecimal*  

Ta sẽ vào check hex byte xem và search thử các key string như: flag, ctf, huflit, ...
![alt text](/assets/img/2024/01/image.png)

Vậy ra search với key "flag" ta sẽ thấy được 1 string đáng nghi  
Dùng `strings` + `grep` để copy string đó ra nào  
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


## References

- [file command (man7.org)](https://man7.org/linux/man-pages/man1/file.1.html)
- [grep command (GNU.org)](https://www.gnu.org/software/grep/manual/grep.html)
- [base64 command (man7.org)](https://man7.org/linux/man-pages/man1/base64.1.html)
- [strings command (GNU Binutils)](https://sourceware.org/binutils/docs/binutils/strings.html)
- [JPEG File Interchange Format (Wikipedia)](https://en.wikipedia.org/wiki/JPEG_File_Interchange_Format)
- [JPEG File Structure (ExifTool FAQ)](https://exiftool.org/faq.html#Q3)
- [Magic numbers & file signatures (Gary Kessler's List)](https://www.garykessler.net/library/file_sigs.html)
- [Understanding file formats (forensicswiki)](https://forensicswiki.xyz/page/File_Formats)

--- 