---
title: "OverTheWire: Bandit Walkthrough (Level 0 – 19)"
date: 2024-05-25 17:35:00 +0700
categories: [CTF]
tags: [overthewire, bandit, ctf, write-ups, linux, privilege escalation, bash scripting]
pin: false
comments: false
published: true
---

Đây là bài note của mình cho các challenge từ Level 0 - 19 trong [OverTheWire: Bandit](https://overthewire.org/wargames/bandit/).


## Connection Information

Dùng lệnh sau để kết nối đến Bandit server:

```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

> Thay `bandit0` với username của từng level (e.g., `bandit1`, `bandit2`, ...) và dùng password nhận được từ level trước đó để login nhé.

---

## Level 0

**Objective**  

Tìm password nằm trong file tên là `readme` trong thư mục home (`~`).

**Analysis**

- Sau khi login, bạn sẽ ở thư mục /home/bandit0
- Gõ `ls` để xem các file hiện có

**Solution**

```bash
ls
cat readme
```

---

## Level 1

**Objective**  

Tìm password trong file có tên là `-`, đây là một tên đặc biệt vì dấu `-` thường được hiểu là stdin trong Unix.

**Analysis**

- Nếu bạn dùng `cat -`, nó sẽ không hiểu là file tên `-` mà hiểu là bạn nhập từ bàn phím.
- Cần rõ ràng chỉ định tên file bằng cách dùng `./-`

**Solution**

```bash
ls
cat ./-
```

---

## Level 2

**Objective**  

File chứa password có tên là `spaces in this filename`.

**Analysis**

- Tên file chứa dấu cách, nên cần đặt trong dấu nháy hoặc escape khoảng trắng.

**Solution**

```bash
cat "spaces in this filename"
# hoặc dùng escape
cat spaces\ in\ this\ filename
```

---

## Level 3

**Objective**  

Tìm file ẩn trong thư mục hiện tại.

**Analysis**

- File ẩn trong Unix bắt đầu bằng dấu `.` nên `ls` bình thường sẽ không hiển thị.
- Cần dùng `ls -la` để hiển thị tất cả file.

**Solution**

```bash
ls -la
cat .hidden
```

---

## Level 4

**Objective**  

Có nhiều file đặc biệt trong thư mục `inhere`, cần tìm file chứa password.

**Analysis**

- Dùng `ls -l` để xem danh sách file và quyền truy cập.
- Dùng `cat` để đọc từng file, hoặc lọc file readable.

**Solution**

```bash
cd inhere
ls -la
file ./-file07
cat ./-file07
```

---

## Level 5

**Objective**  

Có nhiều file trong thư mục `inhere`, chỉ một file chứa **ASCII text**.

**Analysis**

- Dùng lệnh `file` để xác định loại nội dung trong file.
- Chỉ đọc file nào là ASCII text.

**Solution**

```bash
cd inhere
for file in *; do
  if file "$file" | grep -q "ASCII text"; then
    cat "$file"
  fi
done
```

---

## Level 6

**Objective**  

Trong nhiều thư mục con, có một file thỏa 4 điều kiện:

- Loại file thông thường (`-type f`)
- Kích thước chính xác `1033 bytes`
- Có thể đọc được (`-readable`)
- Có thể thực thi (`-executable`)

**Analysis**

- Trong thư mục home của `bandit6`, có rất nhiều thư mục con (kiểu như `./maybehere07`, `./maybehere33`, ...)
- Chúng ta cần quét đệ quy toàn bộ cây thư mục để tìm file thỏa điều kiện.
- Lệnh `find` là công cụ phù hợp nhất vì nó cho phép kết hợp nhiều điều kiện tìm kiếm.
- 
**Solution**

```bash
cd /home/bandit6
find . -type f -size 1033c -readable -executable -exec cat {} \;
```

---

## Level 7

**Objective**  

Tìm dòng có từ khóa `millionth`.

**Analysis**

- Dữ liệu nằm trong `data.txt`, mỗi dòng có 1 entry
- Dòng chứa từ `millionth` là dòng chứa password

**Solution**

```bash
grep millionth data.txt
```

---

## Level 8

**Objective**  

Tìm dòng duy nhất xuất hiện một lần trong `data.txt`.

**Analysis**

- Dùng `sort` rồi `uniq -u` để lọc dòng không bị lặp.

**Solution**

```bash
sort data.txt | uniq -u
```

---

## Level 9

**Objective**  

Tìm dòng có đúng 32 ký tự, là password.

**Analysis**

- Dùng `strings` để lọc ký tự in được
- Dùng `grep` với regex đúng 32 ký tự

**Solution**

```bash
strings data.txt | grep -E '^.{32}$'
```

---

## Level 10

**Objective**  

Dữ liệu bị mã hóa bằng **base64**.

**Analysis**

- Dùng `base64 -d` để giải mã

**Solution**

```bash
cat data.txt | base64 -d
```

---

## Level 11

**Objective**  

Chuỗi password bị mã hóa nhiều lớp:  
hex → gzip → bzip2 → tar → ...

**Analysis**

- Dùng `xxd -r` để chuyển từ hex sang binary
- Dùng `file` để xác định loại file rồi giải nén

**Solution**

```bash
xxd -r data.txt > data
file data
mv data data.gz
gunzip data.gz
file data
bzip2 -d data
tar -xf data
...
cat final_file
```

> Nếu file bạn gặp không giống mình, bạn vẫn có thể tự tra cứu và xử lý giống như mình nhé.

---

## Level 12

**Objective**  

Có một file chứa SSH private key để SSH sang level tiếp theo.

**Analysis**

- Đặt permission thích hợp
- Dùng `ssh -i` để đăng nhập bằng key

**Solution**

```bash
chmod 600 sshkey.private
ssh -i sshkey.private bandit14@localhost -p 2220
```

---

## Level 13

**Objective**  

Gửi password hiện tại đến cổng 30000 thông qua TCP.

**Analysis**

- Dùng `nc` (netcat) để gửi dữ liệu

**Solution**

```bash
cat /etc/bandit_pass/bandit13 | nc localhost 30000
```

---

## Level 14

**Objective**  

Tương tự level trước, nhưng giao tiếp qua SSL (port 30001).

**Analysis**

- Dùng `openssl s_client` để thiết lập kết nối TLS

**Solution**

```bash
openssl s_client -connect localhost:30001
# Sau khi kết nối, paste password vào
```

---

## Level 15

**Objective**  

So sánh hai file: `passwords.old` và `passwords.new` để tìm sự thay đổi.

**Analysis**

- Sử dụng `diff` để tìm dòng bị thay đổi

**Solution**

```bash
diff passwords.old passwords.new
```

---

## Level 16

**Objective**  

Dò tìm cổng TCP đang mở, và gửi password để nhận phản hồi.

**Analysis**

- Có một service ẩn đang lắng nghe (listen) tại một trong các cổng từ **31000 đến 32000**.
- Khi bạn gửi password hiện tại vào đúng cổng, chương trình phía server sẽ trả về password cho `bandit17`.
- Bạn không biết cổng nào đúng, nên cần thử tuần tự từng cổng bằng script.
- Dùng `nc` để gửi dữ liệu và nhận phản hồi từ mỗi cổng.

**Solution**

```bash
for port in {31000..32000}; do
  echo "Trying port $port..."
  echo <password> | nc localhost $port
done
```


---

## Level 17

**Objective**  

Password ẩn trong lịch sử dòng lệnh `.bash_history`.

**Analysis**

- File nằm ở home của người dùng

**Solution**

```bash
cat ~/.bash_history
```

---

## Level 18

**Objective**  

Shell bị giới hạn, cần thoát hoặc dùng trick để đọc password.

**Analysis**

- Một số lệnh như `cat` bị cấm
- Dùng trick như `more`, `less`, `head`, `strings`

**Solution**

```bash
more password
```

---

## Level 19

**Objective**  

Tìm password trong khi shell hiện tại được thiết lập để tự động thoát ngay lập tức khi đăng nhập.

**Analysis**

- Khi login vào `bandit19`, bạn sẽ thấy thông báo như: `Byebye!` và bị kick ra ngay lập tức.
- Lý do là shell mặc định của user này (`/usr/bin/quit`) sẽ tự động thoát ngay khi được chạy.
- Để bypass, ta cần đổi shell không tương tác, ví dụ:
  - Chạy lệnh từ xa bằng SSH (`ssh bandit19@... <command>`)
  - Hoặc sử dụng tùy chọn `-t` và `-T` của SSH để disable pseudo-tty.

**Solution**

Chạy lệnh cat trực tiếp từ dòng lệnh SSH

```bash
ssh bandit19@bandit.labs.overthewire.org -p 2220 cat /etc/bandit_pass/bandit19
```

> Cách này giúp bạn chạy một lệnh duy nhất mà không cần vào interactive shell, do đó tránh bị kick.

---

## Conclusion

Vậy là mình vừa hoàn thành 20 level đầu tiên của `Bandit`. Đây là chặng đường giúp mình làm quen với Linux command line, hiểu thêm về file permission, encoding, pipe, redirect, cũng như trải nghiệm các công cụ như `find`, `nc`, `openssl`, `tar`, `gzip`, ...

Từ level 20 trở đi, thử thách sẽ thiên về tự động hóa, scripting và một chút về mạng. Mình sẽ tiếp tục học dần, vừa làm vừa rút kinh nghiệm.  
Khi nào rảnh thì mình sẽ viết tiếp bài sau =)))  


---