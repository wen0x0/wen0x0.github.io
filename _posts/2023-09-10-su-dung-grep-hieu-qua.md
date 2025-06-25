---
title: "Sử dụng grep hiệu quả để tìm kiếm văn bản"
date: 2023-09-10 19:15:00 +0700
categories: [Blog]
tags: [grep, cli, regex]
pin: false
comments: true
published: true
---

**Grep** là một công cụ dòng lệnh cực kỳ mạnh mẽ, giúp bạn tìm kiếm văn bản theo mẫu hoặc biểu thức chính quy.  
Nhanh, gọn, tiện lợi — grep là người bạn không thể thiếu của dân sysadmin, developer hay bất kỳ ai làm việc với text.

---

## Grep là gì?

`grep` viết tắt của **Global Regular Expression Print**.  
Nó quét qua nội dung file (hoặc đầu vào) và in ra những dòng khớp với mẫu tìm kiếm.

```bash
grep "mau_can_tim" file.txt
```

Grep hỗ trợ cả **biểu thức chính quy cơ bản** và **nâng cao**, nên bạn có thể viết các mẫu rất phức tạp để tìm dữ liệu chính xác.

---

## Cách dùng cơ bản

```bash
grep error logfile.txt
```

- In ra các dòng có chứa từ "error" trong `logfile.txt`.

```bash
grep -i error logfile.txt
```

- Tìm kiếm không phân biệt hoa thường.

```bash
grep -n error logfile.txt
```

- Hiển thị số dòng chứa từ cần tìm.

---

## Dùng với biểu thức chính quy

```bash
grep "^ERROR" logfile.txt
```

- Các dòng bắt đầu bằng `ERROR`.

```bash
grep "[0-9]\{3\}-[0-9]\{2\}-[0-9]\{4\}" data.txt
```

- Tìm các chuỗi giống định dạng số an sinh xã hội (SSN) như `123-45-6789`.

```bash
grep -E "dog|cat" animals.txt
```

- Dùng `-E` để bật regex nâng cao, ví dụ tìm dòng chứa "dog" hoặc "cat".

---

## Tìm kiếm đệ quy

```bash
grep -r TODO .
```

- Tìm tất cả các dòng có `TODO` từ thư mục hiện tại và tất cả các thư mục con.

```bash
grep -r --include="*.py" "import" .
```

- Chỉ tìm trong các file `.py`.

---

## Tô màu phần khớp

```bash
grep --color=auto pattern file.txt
```

- Làm nổi bật phần khớp với mẫu — giúp dễ nhìn hơn khi xem log hay output dài.

---

## Kết hợp với pipe

```bash
ps aux | grep java
```

- Tìm các tiến trình Java đang chạy.

```bash
dmesg | grep -i usb
```

- Tìm các thông báo kernel liên quan đến USB.

---

## Tổng kết

`grep` tưởng đơn giản nhưng lại cực kỳ mạnh nếu bạn tận dụng được hết khả năng của nó.  
Kết hợp với regex, bạn có thể lọc log, quét dữ liệu, hay tìm lỗi trong hàng ngàn dòng code một cách dễ dàng.

---
