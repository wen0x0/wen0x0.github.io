+++
title = "Docker – Nền tảng container hóa ứng dụng hiện đại"
description = "Tìm hiểu về Docker, cách hoạt động, lợi ích và các khái niệm cơ bản để bắt đầu với containerization"
date = 2025-10-17
draft = false
[taxonomies]
categories = ["Notes"]
tags = ["docker", "container", "devops"]
[extra]
lang = "vi"
toc = false
comment = false
copy = true
outdate_alert = false
outdate_alert_days = 120
math = false
mermaid = false
featured = false
reaction = false
+++

## Docker là gì?

Docker là một nền tảng mã nguồn mở cho phép bạn đóng gói ứng dụng và tất cả các phụ thuộc của nó vào một container – một đơn vị tiêu chuẩn hóa có thể chạy ở bất cứ đâu. Thay vì phải cấu hình từng máy chủ riêng biệt, Docker cho phép bạn tạo ra một image chứa toàn bộ môi trường cần thiết, sau đó chạy nó trên bất kỳ hệ thống nào có Docker cài đặt.

## Tại sao nên dùng Docker?

**Tính nhất quán**: Docker đảm bảo ứng dụng của bạn chạy giống hệt nhau trên máy tính cá nhân, server phát triển, và production. Điều này loại bỏ vấn đề "chạy tốt trên máy tôi nhưng không chạy trên server".

**Hiệu quả tài nguyên**: Container chia sẻ kernel của hệ điều hành, do đó nhẹ hơn nhiều so với máy ảo truyền thống. Bạn có thể chạy hàng chục container trên cùng một máy mà không tốn nhiều tài nguyên.

**Mở rộng dễ dàng**: Nhờ tính chuẩn hóa, việc mở rộng ứng dụng trở nên đơn giản. Bạn có thể khởi chạy thêm container khi cần mà không lo về cấu hình.

**Tách biệt**: Mỗi container chạy độc lập với các container khác, giúp tăng bảo mật và tránh xung đột phụ thuộc.

## Các khái niệm cơ bản

**Image**: Đây là blueprint hoặc khuôn mẫu của ứng dụng. Image chứa tất cả mã, runtime, thư viện, và cấu hình cần thiết để chạy ứng dụng. Bạn có thể tạo image từ một file Dockerfile hoặc tải từ Docker Hub.

**Container**: Là một thể hiện đang chạy của image. Nếu image là lớp học thì container là học sinh cụ thể – mỗi container có trạng thái riêng, file system riêng, và bộ nhớ riêng.

**Dockerfile**: Một tập tin văn bản chứa các lệnh để xây dựng image. Nó định nghĩa base image, cài đặt các gói cần thiết, sao chép mã ứng dụng, và đặt các biến môi trường.

**Docker Hub**: Kho lưu trữ công cộng nơi bạn có thể tìm, tải xuống, và chia sẻ image với cộng đồng.

## Quy trình làm việc cơ bản

Quy trình Docker thường bắt đầu bằng việc viết Dockerfile mô tả cách xây dựng image. Sau đó, bạn chạy lệnh `docker build` để tạo image từ Dockerfile. Tiếp theo, dùng `docker run` để khởi chạy container từ image. Container sẽ chạy ứng dụng của bạn, và bạn có thể xem log, truy cập ứng dụng qua cổng được ánh xạ, hoặc kết nối vào container để debug.

## Ví dụ Dockerfile đơn giản

Dưới đây là một ví dụ Dockerfile cho ứng dụng Node.js:

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
```

Dockerfile này bắt đầu với image Node.js, đặt thư mục làm việc, cài đặt dependencies, sao chép mã ứng dụng, và chỉ định lệnh chạy.

## Những lợi ích trong phát triển

Với Docker Compose, bạn có thể định nghĩa toàn bộ ngăn xếp ứng dụng của mình – bao gồm web server, database, cache – trong một tập tin `docker-compose.yml`. Sau đó, một lệnh duy nhất sẽ khởi chạy tất cả các service. Điều này rất hữu ích cho phát triển cục bộ vì nó tái tạo môi trường production một cách chính xác.

## Kết luận

Docker đã trở thành một công cụ thiết yếu trong vòng đời phát triển ứng dụng hiện đại. Nó giải quyết vấn đề tính nhất quán giữa các môi trường, cải thiện hiệu quả tài nguyên, và cho phép các đội phát triển làm việc một cách hiệu quả hơn. Cho dù bạn là developer mới bắt đầu hay kinh nghiệm, việc hiểu Docker sẽ là một kỹ năng quý báu cho sự nghiệp của bạn.
