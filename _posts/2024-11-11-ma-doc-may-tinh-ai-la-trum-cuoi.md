---
title: "Malware 101: Ai là trùm cuối trong thế giới mã độc?"
date: 2024-11-11 02:23:52 +0700
categories: [Blog, Cybersecurity, Malware]
tags: [malware, cybersecurity]
pin: false
comments: false
published: true
---

Cuộc sống công nghệ thật tuyệt… cho đến khi máy tính bỗng chậm rì, quạt kêu vù vù, hoặc đầy quảng cáo nhảm. Đó có thể là do **malware (mã độc)** – những kẻ phá hoại vô hình luôn rình rập. 

Hãy cùng khám phá **các loại malware** để biết kẻ nào nguy hiểm nhất nha.

---

## Virus

### Nó là gì?

Giống như virus cúm, **virus máy tính** bám vào file bình thường (Word, PDF, game, app…). Khi bạn mở file, virus “thức dậy” và bắt đầu phá hoại.

### Nó làm gì?

- Phá hỏng hoặc xóa file  
- Lây sang các file khác  
- Làm máy chậm, đứng, không khởi động

### Ví dụ thực tế

**CIH (Chernobyl Virus, 1998)**: Phá hỏng phần cứng, thiệt hại hàng triệu USD.

---

## Worm

### Nó là gì?

**Worm (sâu máy tính)** tự nhân bản và lây lan cực nhanh qua Internet hoặc USB mà **không cần mở file**.

### Nó làm gì?

- Lan nhanh, gây nghẽn mạng  
- Cài thêm malware khác

### Ví dụ thực tế

- **ILOVEYOU (2000)**: Email “I LOVE YOU” lây khắp thế giới, thiệt hại 10 tỷ USD.  
- **WannaCry (2017)**: Ransomware lây qua mạng nội bộ, làm tê liệt bệnh viện, công ty.

---

## Trojan

### Nó là gì?

**Trojan** giống “ngựa thành Troy”: giả làm phần mềm hữu ích (crack game, phần mềm miễn phí) nhưng thực ra là malware.

### Nó làm gì?

- Lấy cắp dữ liệu  
- Điều khiển máy từ xa  
- Cài malware khác

### Ví dụ thực tế

**Emotet**: Ban đầu là trojan ngân hàng, sau thành công cụ cài ransomware.

---

## RAT (Remote Access Trojan)

### Nó là gì?

**RAT** là trojan đặc biệt cho phép hacker **điều khiển máy từ xa** mà bạn không hề biết.

### Nó làm gì?

- Mở webcam, mic  
- Lấy file, chạy lệnh  
- Cài malware khác

### Ví dụ thực tế

**DarkComet RAT**: Từng dùng để giám sát mục tiêu chính trị.

---

## Logic Bomb / Time Bomb

### Nó là gì?

**Logic Bomb (Time Bomb)** là malware “gài mìn”, chỉ kích hoạt khi đủ điều kiện (ngày giờ, thao tác cụ thể).

### Nó làm gì?

- Xóa file, phá hỏng hệ thống  
- Mã hóa dữ liệu

### Ví dụ thực tế

Nhân viên IT cũ gài Logic Bomb xóa dữ liệu ngân hàng sau khi bị sa thải.

---

## Ransomware

### Nó là gì?

**Ransomware** là kẻ bắt cóc dữ liệu. Nó khóa hoặc mã hóa file rồi đòi tiền chuộc.

### Nó làm gì?

- Mã hóa file  
- Đòi tiền chuộc (thường bằng Bitcoin)

### Ví dụ thực tế

- **Ryuk**: Tấn công bệnh viện, trường học, đòi hàng trăm ngàn USD.  
- **LockBit**: Nhóm ransomware khét tiếng tấn công doanh nghiệp toàn cầu.

---

## Spyware

### Nó là gì?

**Spyware** là phần mềm gián điệp, âm thầm theo dõi bạn.

### Nó làm gì?

- Ghi phím bấm (password, tin nhắn)  
- Chụp màn hình, webcam  
- Lấy thông tin ngân hàng

### Ví dụ thực tế

**FinSpy**: Được bán cho chính phủ nhiều nước để giám sát mục tiêu.

---

## Adware

### Nó là gì?

**Adware** không nguy hiểm bằng virus nhưng cực kỳ phiền.

### Nó làm gì?

- Hiện quảng cáo liên tục  
- Làm máy chậm, treo  
- Có thể cài malware khác

### Ví dụ thực tế

Phần mềm crack game/phim lậu thường kèm adware.

---

## Rootkit

### Nó là gì?

**Rootkit** là malware ẩn thân, che giấu chính nó và các malware khác khỏi mắt người dùng.

### Nó làm gì?

- Cho hacker toàn quyền máy  
- Rất khó phát hiện, gỡ bỏ

### Ví dụ thực tế

**Sony BMG Rootkit (2005)**: Che DRM nhạc, gây rủi ro bảo mật cho hàng triệu người.

---

## Bootkit

### Nó là gì?

**Bootkit** là Rootkit tấn công **boot sector** hoặc **MBR**.

### Nó làm gì?

- Chiếm quyền trước cả hệ điều hành  
- Rất khó gỡ

### Ví dụ thực tế

**TDL-4 (Alureon)**: Bootkit nguy hiểm nhắm vào Windows.

---

## Backdoor

### Nó là gì?

**Backdoor** là “cửa hậu” bí mật cho hacker vào máy mà không cần mật khẩu.

### Nó làm gì?

- Cho hacker truy cập bất kỳ lúc nào  
- Thường cài qua trojan

### Ví dụ thực tế

Nhiều phần mềm lậu có sẵn backdoor để hacker xâm nhập.

---

## Botnet

### Nó là gì?

**Botnet** biến máy bạn thành “zombie” trong mạng lưới hacker điều khiển.

### Nó làm gì?

- Tấn công DDoS website  
- Gửi spam, đào tiền ảo

### Ví dụ thực tế

**Mirai Botnet (2016)**: Làm sập Twitter, Netflix, Reddit bằng DDoS.

---

## Downloader / Dropper

### Nó là gì?

**Downloader / Dropper** là malware tải và cài malware khác vào máy.

### Nó làm gì?

- Tải ransomware, spyware, trojan  
- Tấn công đa giai đoạn

### Ví dụ thực tế

**Emotet** thường dùng Dropper để cài payload khác.

---

## Fileless Malware

### Nó là gì?

**Fileless Malware** hoạt động mà **không cần file trên ổ cứng**. Nó chạy trực tiếp trong RAM, phần mềm diệt virus khó phát hiện.

### Nó làm gì?

- Trộm dữ liệu  
- Điều khiển máy

### Ví dụ thực tế

**POSHSPY**: Fileless malware dùng PowerShell để hoạt động.

---

## Scareware

### Nó là gì?

**Scareware** dùng chiêu hù dọa để bạn cài phần mềm dởm.

### Nó làm gì?

- Hiện cảnh báo virus giả  
- Dọa mất dữ liệu  
- Dụ mua phần mềm “dỏm” (thường là malware)

### Ví dụ thực tế

Popup giả mạo diệt virus, dụ bạn cài “phần mềm bảo vệ” của chúng.

---

## Keylogger

### Nó là gì?

**Keylogger** ghi lại mọi phím bạn bấm: password, tin nhắn, confession crush.

### Nó làm gì?

- Gửi phím bấm cho hacker  
- Đánh cắp tài khoản, ngân hàng

### Ví dụ thực tế

Chỉ vài dòng Python cũng tạo ra keylogger nguy hiểm.

---

## Malvertising

### Nó là gì?

**Malvertising** không phải loại malware riêng, mà là **chiến thuật phát tán malware qua quảng cáo độc hại**.

### Nó làm gì?

- Phát tán trojan, ransomware qua banner quảng cáo  
- Lây nhiễm khi người dùng click hoặc thậm chí chỉ cần load trang

---

## Conclusion

Thế giới malware **muôn hình vạn trạng**. Để tự bảo vệ:

- [x] Update Windows, phần mềm  
- [x] Không click link lạ  
- [x] Không cài crack lung tung  
- [x] Luôn backup dữ liệu

Hy vọng bài viết giúp bạn nắm tí kiến thức về **các sát thủ vô hình** này để sau này còn biết ai đang phá hoại máy tính của mình nhé.

---
