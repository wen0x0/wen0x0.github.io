---
title: "Nhập môn Git một cách chill"
date: 2023-02-05 20:21:42 +0700
categories: [Blog]
tags: [git, version control]
pin: false
comments: true
published: true
---

**Git** là một công cụ quản lý phiên bản cực kỳ mạnh mẽ, giúp bạn theo dõi từng dòng code thay đổi và dễ dàng làm việc nhóm.  
Dù mới bắt đầu học code hay đã "lăn lộn" nhiều dự án, biết dùng Git luôn là một điểm cộng lớn.

---

## Vì sao nên dùng Git?

- Lưu lại lịch sử mọi thay đổi trong dự án của bạn.
- Làm việc nhóm mượt mà, ai code phần nào cũng rõ ràng.
- Nếu lỡ tay làm hư gì đó? Có thể quay về phiên bản trước rất dễ dàng.

---

## Cài đặt Git

Bạn cài Git từ [trang chủ chính thức](https://git-scm.com/downloads), sau đó kiểm tra thử bằng lệnh sau:

```bash
git --version
```

Nếu thấy hiện ra phiên bản là ổn rồi nhé!

---

## Những lệnh cơ bản

```bash
git init        # Tạo một Git repo mới
git status      # Xem tình hình hiện tại
git add .       # Đưa tất cả thay đổi vào vùng chờ commit
git commit -m "Lời nhắn yêu thương"  # Lưu lại thay đổi với một thông điệp
git log         # Xem lịch sử commit
git diff        # So sánh sự khác biệt giữa các thay đổi
```

---

## Làm việc với Git từ xa

```bash
git remote add origin https://github.com/user/repo.git
git push -u origin main
git pull origin main
```

Với GitHub hoặc GitLab, bạn có thể lưu code trên mây và làm việc nhóm rất tiện.

---

## Quản lý nhánh (branch)

```bash
git branch                    # Xem danh sách các nhánh
git checkout -b new-feature   # Tạo và chuyển sang nhánh mới
git merge new-feature         # Gộp nhánh vào nhánh hiện tại
```

Mỗi nhánh như một không gian thử nghiệm riêng – thoải mái sáng tạo mà không sợ ảnh hưởng ai.

---

## Dùng .gitignore cho gọn gàng

Tạo file `.gitignore` để Git bỏ qua những file không cần thiết:

```text
node_modules/
.env
*.log
```

Gọn gàng, sạch sẽ, nhẹ repo!

---

## Tổng kết nhẹ

Git không khó đâu, chỉ là bạn chưa quen thôi.  
Làm chủ Git sẽ giúp bạn tự tin hơn khi làm dự án, nhất là làm việc nhóm.  
Học Git cũng là một bước để trở thành developer "xịn xò" hơn mỗi ngày.

---
