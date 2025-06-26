---
title: "Vỡ lòng Regex - Khi bạn muốn làm phù thủy văn bản"
date: 2023-06-02 20:21:42 +0700
categories: [Blog]
tags: [regex]
pin: false
comments: true
published: true
---

**Regex (Regular Expressions)** là một công cụ siêu mạnh để tìm kiếm theo mẫu và xử lý văn bản.  
Bạn có thể dùng nó để tra cứu, kiểm tra dữ liệu đầu vào, trích xuất thông tin... nói chung là rất nhiều thứ hay ho.

---

## Regex là gì?

Regex (biểu thức chính quy) là một chuỗi ký tự đặc biệt, được thiết kế để mô tả **một mẫu** (pattern) trong văn bản.  
Nghe thì "ghê", nhưng nó như ma thuật: viết vài ký tự là bắt được cả đoạn văn.

```text
abc     # Khớp đúng 'abc'
\d      # Số bất kỳ (0–9)
\w      # Ký tự chữ, số hoặc gạch dưới
\s      # Khoảng trắng (space, tab, xuống dòng)
.       # Ký tự bất kỳ (trừ xuống dòng)
```

## Bộ định lượng (quantifiers)

```text
a*      # 0 hoặc nhiều ký tự 'a'
a+      # Ít nhất 1 'a'
a?      # Có hoặc không có 'a'
a{3}    # Chính xác 3 'a'
a{2,4}  # Từ 2 đến 4 'a'
```

## Nhóm ký tự (character classes)

```text
[abc]        # Khớp 'a', 'b' hoặc 'c'
[^abc]       # Bất kỳ ký tự nào trừ 'a', 'b', 'c'
[a-zA-Z0-9]  # Chữ cái hoặc số
```

## Điểm neo (anchors)

```text
^start     # Bắt đầu dòng
end$       # Kết thúc dòng
\bword\b   # Khớp cả từ, không ăn gian nửa chữ
```

## Nhóm và lựa chọn (groups & alternation)

```text
(grab|take)              # 'grab' hoặc 'take'
(colou?r)                # 'color' hay 'colour', dân Anh - Mỹ đều chơi được
(\d{3})-(\d{2})-(\d{4})  # Định dạng giống số CMND kiểu Mỹ
```

## Một số ứng dụng quen thuộc

Kiểm tra email

```text
^[\w.-]+@[\w.-]+\.\w+$
```

Tìm tất cả URL

```text
https?:\/\/(www\.)?[\w\-]+(\.[\w\-]+)+
```

Lấy ra các từ

```text
\b\w+\b
```

## Thử ngay cho nóng

Bạn có thể vọc ngay tại:

- [regex101.com](https://regex101.com/)
- [regexper.com](https://regexper.com/)

## Tổng kết

Regex ban đầu nhìn như ký hiệu ngoài hành tinh, nhưng khi quen rồi thì lại thấy "bén" cực kỳ.  
Chỉ vài ký tự là bạn có thể lọc log, tìm lỗi, xử lý chuỗi văn bản như một phù thủy của dòng lệnh.  
Nên... đừng sợ, cứ luyện dần là "lên trình" nhé!  

--- 