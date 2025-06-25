---
title: "Tìm hiểu về các phương thức HTTP"
date: 2023-01-02 17:35:00 +0700
categories: [Blog, Web]
tags: [http, web, rest, api, method]
pin: false
comments: true
published: true
---

**Các phương thức HTTP (HTTP Methods)** định nghĩa hành động cần thực hiện trên một tài nguyên cụ thể.  
Chúng được ví như các động từ của web — đóng vai trò nền tảng trong thiết kế và giao tiếp của API RESTful.

---

## GET

- Dùng để **lấy dữ liệu** từ máy chủ.
- Không gây **tác dụng phụ** — an toàn và có tính idempotent.
- Ví dụ: `GET /users` trả về danh sách người dùng.

---

## POST

- Dùng để **gửi dữ liệu** cần xử lý (ví dụ: tạo một tài nguyên mới).
- Thường dẫn đến việc tạo ra **một tài nguyên mới**.
- Ví dụ: `POST /users` với body dạng JSON để thêm người dùng mới.

---

## PUT

- Dùng để **thay thế hoàn toàn** một tài nguyên đã tồn tại.
- Có tính idempotent — gọi nhiều lần với cùng dữ liệu sẽ cho kết quả như nhau.
- Ví dụ: `PUT /users/123` để ghi đè toàn bộ thông tin người dùng 123.

---

## PATCH

- Dùng để **cập nhật một phần** thông tin của tài nguyên.
- Khác với PUT, nó chỉ gửi các trường cần thay đổi.
- Ví dụ: `PATCH /users/123` với `{ "email": "new@mail.com" }`.

---

## DELETE

- Dùng để **xóa** một tài nguyên.
- Có tính idempotent — gọi xóa nhiều lần cũng cho kết quả như nhau.
- Ví dụ: `DELETE /users/123`.

---

## OPTIONS

- Dùng để **mô tả các tùy chọn giao tiếp** cho một tài nguyên.
- Phổ biến trong các yêu cầu **CORS preflight**.

---

## HEAD

- Giống như GET, nhưng chỉ trả về **header**, không có phần nội dung (body).
- Hữu ích để kiểm tra sự tồn tại của tài nguyên hoặc xem metadata.

---

## Tóm tắt

Việc hiểu rõ các phương thức HTTP là điều thiết yếu khi làm việc với API và dịch vụ web.  
Chúng định nghĩa "hợp đồng" giữa client và server, giúp hệ thống rõ ràng và đồng nhất hơn trong thiết kế.

---
