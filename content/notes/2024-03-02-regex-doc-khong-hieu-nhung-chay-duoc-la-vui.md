+++
title = "Regular Expression là gì?"
description = ""
date = 2024-03-02
draft = false
[taxonomies]
categories = ["Notes"]
tags = ["regex"]
[extra]
lang = "vi"
toc = true
comment = false
copy = true
outdate_alert = false
outdate_alert_days = 120
math = false
mermaid = false
featured = false
reaction = false
+++


> "Some people, when confronted with a problem, think 'I know, I'll use regular expressions.' Now they have two problems." - Jamie Zawinski

Chào mừng các bạn đến với thế giới kỳ diệu của Regular Expressions (Regex) - nơi mà một dòng code có thể khiến bạn cảm thấy như thiên tài trong 5 phút, rồi sau đó muốn đập đầu vào tường trong 5 tiếng tiếp theo.

## Regex Là Gì? Tại Sao Chúng Ta Cần Nó?

Regular Expression, hay gọi tắt là Regex (đọc là "REG-ex", không phải "re-GEKS" như một số bạn vẫn đọc), là một chuỗi ký tự đặc biệt được sử dụng để tìm kiếm và xử lý văn bản. Nó giống như một chiếc dao Swiss Army - vô cùng hữu ích nhưng cũng rất dễ tự cắn tay mình.

Tại sao chúng ta cần Regex? Bởi vì đôi khi bạn cần tìm tất cả email trong một đống text, hoặc validate số điện thoại, hoặc đơn giản là muốn khoe với đồng nghiệp rằng bạn có thể viết được những dòng code trông như mật mã CIA.

## Cú Pháp Cơ Bản - Bảng Chữ Cái Của Quỷ Dữ

### Ký Tự Literal (Literal Characters)

Đây là phần dễ nhất. Nếu bạn muốn tìm chữ "hello", bạn chỉ cần viết:

```
hello
```

Easy peasy, lemon squeezy! Nhưng đừng vội mừng, chúng ta mới chỉ bắt đầu thôi.

### Metacharacters - Những Ký Tự Đặc Biệt

Đây là lúc mọi thứ bắt đầu trở nên... thú vị:

- `.` - Match bất kỳ ký tự nào (trừ newline). Nó như một wildcard trong game bài.
- `*` - Match 0 hoặc nhiều ký tự trước đó. Giống như người yêu cũ, có thể có hoặc không.
- `+` - Match 1 hoặc nhiều ký tự trước đó. Ít nhất phải có một cái.
- `?` - Match 0 hoặc 1 ký tự trước đó. Có hay không cũng được.
- `^` - Bắt đầu của chuỗi. Như lời mở đầu trong một bài thuyết trình.
- `$` - Kết thúc của chuỗi. Như lời kết trong một bài thuyết trình.

### Character Classes - Hội Những Ký Tự Đặc Biệt

```
[abc]     # Match a, b, hoặc c
[a-z]     # Match bất kỳ chữ thường nào
[A-Z]     # Match bất kỳ chữ hoa nào
[0-9]     # Match bất kỳ số nào
[^abc]    # Match bất kỳ ký tự nào NGOẠI TRỪ a, b, c
```

### Predefined Character Classes - Những Shortcut Cứu Mạng

```
\d        # Digit [0-9] - Số
\w        # Word character [a-zA-Z0-9_] - Ký tự từ
\s        # Whitespace - Khoảng trắng
\D        # Không phải số
\W        # Không phải ký tự từ
\S        # Không phải khoảng trắng
```

## Quantifiers - Những Kẻ Đếm Số

Quantifiers cho phép bạn chỉ định bao nhiều lần một pattern xuất hiện:

```
{n}       # Chính xác n lần
{n,}      # Ít nhất n lần
{n,m}     # Từ n đến m lần
```

Ví dụ:
```
\d{3}     # Chính xác 3 số (như 123)
\d{3,5}   # Từ 3 đến 5 số (như 123, 1234, hoặc 12345)
\d{3,}    # Ít nhất 3 số (như 123, 1234, 12345, ...)
```

## Groups và Capturing - Nghệ Thuật Bắt Bằng Chứng

Parentheses `()` tạo ra groups, cho phép bạn:

1. Nhóm các phần của pattern lại với nhau
2. Capture (bắt) nội dung để sử dụng sau này

```
(abc)+                   # Match "abc", "abcabc", "abcabcabc", ...
(\d{3})-(\d{3})-(\d{4})  # Match số điện thoại US format và capture các phần
```

### Non-capturing Groups

Đôi khi bạn muốn nhóm nhưng không muốn capture:

```
(?:abc)+        # Nhóm "abc" nhưng không capture
```

## Alternation - Sự Lựa Chọn

Dấu `|` hoạt động như "OR":

```
cat|dog         # Match "cat" hoặc "dog"
(jpg|png|gif)   # Match các định dạng ảnh
```

## Lookahead và Lookbehind - Nhìn Trước Nhìn Sau

Đây là phần high-level, dành cho những ai muốn flexing:

```
(?=...)     # Positive lookahead - Có cái gì đó phía sau
(?!...)     # Negative lookahead - Không có cái gì đó phía sau
(?<=...)    # Positive lookbehind - Có cái gì đó phía trước
(?<!...)    # Negative lookbehind - Không có cài gì đó phía trước
```

## Những Pattern Thực Tế - Từ Lý Thuyết Đến Thực Hành

### Validate Email (Cơ Bản)

```
^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
```

*Lưu ý: Đây chỉ là version cơ bản. Email validation thực sự phức tạp hơn nhiều và có thể khiến bạn mất ngủ.*

### Số Điện Thoại Việt Nam

```
^(0|\+84)(3|5|7|8|9)\d{8}$
```

### Tìm URL

```
https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)
```

### Validate Mật Khẩu Mạnh

```
^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$
```

Regex này yêu cầu:
- Ít nhất 1 chữ thường
- Ít nhất 1 chữ hoa  
- Ít nhất 1 số
- Ít nhất 1 ký tự đặc biệt
- Tối thiểu 8 ký tự

## Flags - Những Modifier Hữu Ích

Flags thay đổi cách regex hoạt động:

- `i` - Case insensitive (không phân biệt hoa thường)
- `g` - Global (tìm tất cả matches, không chỉ cái đầu tiên)
- `m` - Multiline (^ và $ match đầu/cuối mỗi dòng)
- `s` - Dotall (. match cả newline)

Ví dụ trong JavaScript:
```javascript
const regex = /hello/gi;  // Global và case insensitive
```

## Debugging Regex - Khi Mọi Thứ Đổ Vỡ

Regex debugging là một nghệ thuật. Dưới đây là một số tips:

### Sử dụng Online Tools

- [Regex101.com](https://regex101.com) - Tốt nhất, có explain từng phần
- [RegExr.com](https://regexr.com) - Đẹp và dễ sử dụng
- [RegexPal.com](https://regexpal.com) - Đơn giản và nhanh

### Break It Down

Đừng viết một regex dài 50 ký tự trong một lần. Bắt đầu đơn giản rồi từ từ thêm vào:

```
# Bước 1: Match email cơ bản
\w+@\w+

# Bước 2: Thêm domain extension
\w+@\w+\.\w+

# Bước 3: Cho phép dấu chấm trong username
[\w.]+@\w+\.\w+

# Tiếp tục...
```

### Comment Your Regex

Trong một số ngôn ngữ, bạn có thể comment regex:

```
(?x)            # Enable verbose mode
^               # Start of string
[\w._%+-]+      # Username part
@               # At symbol
[\w.-]+         # Domain name
\.              # Dot
[A-Z]{2,}       # Top level domain
$               # End of string
```

## Performance - Khi Regex Chạy Chậm Như Rùa

Regex có thể rất chậm nếu không được viết cẩn thận:

### Catastrophic Backtracking

Tránh những pattern như này:
```
(a+)+b          # ĐỪng làm thế này!
```

### Sử dụng Non-greedy Quantifiers

```
.*?             # Non-greedy, dừng sớm nhất có thể
.*              # Greedy, match càng nhiều càng tốt
```

### Anchor Your Patterns

```
^pattern$       # Tốt
pattern         # Không tốt
```

## Những Lỗi Thường Gặp - Hall of Shame

### Quên Escape Metacharacters

```
# Sai
3.14

# Đúng  
3\.14
```

### Không Sử Dụng Raw Strings (trong Python)

```python
# Sai
pattern = "\d+"

# Đúng
pattern = r"\d+"
```

### Nghĩ Regex Là Silver Bullet

Không phải mọi thứ đều cần regex. Đôi khi `string.contains()` đã đủ rồi.

## Regex Trong Các Ngôn Ngữ Khác Nhau

### JavaScript
```javascript
const pattern = /\d+/g;
const text = "I have 5 apples and 3 oranges";
const numbers = text.match(pattern); // ['5', '3']
```

### Python
```python
import re

pattern = r'\d+'
text = "I have 5 apples and 3 oranges"
numbers = re.findall(pattern, text)  # ['5', '3']
```

### Java
```java
Pattern pattern = Pattern.compile("\\d+");
Matcher matcher = pattern.matcher("I have 5 apples and 3 oranges");
while (matcher.find()) {
    System.out.println(matcher.group());
}
```

### PHP
```php
$pattern = '/\d+/';
$text = "I have 5 apples and 3 oranges";
preg_match_all($pattern, $text, $matches);
print_r($matches[0]); // Array(['5', '3'])
```

## Best Practices - Làm Sao Để Không Bị Đồng Nghiệp Ghét

### Tên Biến Có Ý Nghĩa

```javascript
// Tệ
const p = /\d{3}-\d{3}-\d{4}/;

// Tốt
const phoneNumberPattern = /\d{3}-\d{3}-\d{4}/;
```

### Comment Cho Regex Phức Tạp

```javascript
const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
// Matches standard email format: username@domain.tld
```

### Validate Input Trước Khi Regex

```javascript
if (typeof input !== 'string' || input.length === 0) {
    return false;
}
return emailPattern.test(input);
```

### Sử dụng Compiled Regex Cho Performance

```python
# Tệ - compile mỗi lần
for item in items:
    if re.match(r'\d+', item):
        # do something

# Tốt - compile một lần
pattern = re.compile(r'\d+')
for item in items:
    if pattern.match(item):
        # do something
```

## Kết Luận

Regex là một công cụ mạnh mẽ, nhưng hãy nhớ:

1. **Đơn giản là tốt nhất** - Nếu có thể làm bằng string methods thông thường, hãy làm vậy
2. **Có thể đọc được quan trọng hơn ngắn gọn** - Đồng nghiệp tương lai (bao gồm chính bạn) sẽ cảm ơn
3. **Test thoroughly** - Regex có thể có những edge cases bất ngờ
4. **Biết khi nào nên dừng** - Đừng cố gắng giải quyết mọi thứ bằng regex

---

*P.S: Nếu bạn có thể đọc hiểu regex này  
`^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$`  
mà không cần tra Google, thì chúc mừng - bạn đã officially trở thành regex ninja!*

---
