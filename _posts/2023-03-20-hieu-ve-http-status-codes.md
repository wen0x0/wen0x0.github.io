---
title: "Hiểu về HTTP Status Codes"
date: 2023-03-20 19:35:00 +0700
categories: [Blog, Web]
tags: [http, web, status code, rest]
pin: false
comments: true
published: true
---

**HTTP Status Codes** là những mã trạng thái chuẩn mà server trả về khi client gửi yêu cầu.  
Chúng giúp ta biết được server đã xử lý yêu cầu ra sao – thành công, lỗi, hay cần điều hướng.

---

## 1xx: Thông tin

- `100 Continue`: Server đã nhận header, client cứ tiếp tục gửi body đi.
- `101 Switching Protocols`: Server đồng ý đổi giao thức (ví dụ: chuyển sang WebSocket).

---

## 2xx: Thành công

- `200 OK`: Mọi thứ ổn, yêu cầu thành công.
- `201 Created`: Tài nguyên mới đã được tạo ra.
- `204 No Content`: Thành công nhưng không trả dữ liệu gì về.

---

## 3xx: Chuyển hướng

- `301 Moved Permanently`: Tài nguyên đã chuyển sang địa chỉ mới vĩnh viễn.
- `302 Found`: Chuyển hướng tạm thời.
- `304 Not Modified`: Dữ liệu không thay đổi, dùng bản cũ (cache) đi.

---

## 4xx: Lỗi phía client

- `400 Bad Request`: Cú pháp request sai, server không hiểu nổi.
- `401 Unauthorized`: Cần đăng nhập/ủy quyền mới được tiếp tục.
- `403 Forbidden`: Server hiểu rồi nhưng không cho truy cập.
- `404 Not Found`: Không tìm thấy tài nguyên.

---

## 5xx: Lỗi phía server

- `500 Internal Server Error`: Server gặp lỗi không rõ ràng.
- `502 Bad Gateway`: Server trung gian nhận phản hồi lỗi từ upstream.
- `503 Service Unavailable`: Server đang quá tải hoặc bảo trì, chưa xử lý được.

---

## Tổng kết nhẹ

Biết các mã trạng thái HTTP sẽ giúp bạn debug nhanh hơn, viết API đúng hơn,  
và hiểu rõ cách client và server đang "nói chuyện" với nhau như thế nào.  
Lập trình web chuyên nghiệp thì không thể thiếu chúng đâu!

---
