+++
title = "Git – Hệ thống quản lý phiên bản phân tán mạnh mẽ"
description = "Git – Hệ thống quản lý phiên bản phân tán mạnh mẽ"
date = 2024-02-05
draft = false
[taxonomies]
categories = ["Notes"]
tags = ["git", "version control"]
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

Git là một hệ thống quản lý phiên bản phân tán (Distributed Version Control System) được phát triển bởi Linus Torvalds vào năm 2005. Đây là công cụ không thể thiếu trong quá trình phát triển phần mềm hiện đại, giúp các developer theo dõi, quản lý và cộng tác hiệu quả trên các dự án.

## Tại sao Git lại quan trọng?

Git giải quyết nhiều vấn đề phổ biến trong việc phát triển phần mềm:

**Theo dõi thay đổi**: Git ghi lại mọi thay đổi trong code của bạn, cho phép bạn xem ai đã thay đổi gì, khi nào và tại sao.

**Sao lưu và khôi phục**: Mọi phiên bản của code đều được lưu trữ, bạn có thể dễ dàng quay lại phiên bản trước đó nếu cần.

**Cộng tác nhóm**: Nhiều người có thể làm việc trên cùng một dự án mà không lo xung đột hoặc mất dữ liệu.

**Phân nhánh**: Tạo các nhánh để phát triển tính năng mới mà không ảnh hưởng đến code chính.

## Các khái niệm cơ bản

### Repository (Repo)

Repository là nơi Git lưu trữ tất cả dữ liệu về dự án của bạn, bao gồm files, lịch sử thay đổi, và metadata. Có hai loại repository:

- **Local Repository**: Nằm trên máy tính của bạn
- **Remote Repository**: Nằm trên server (như GitHub, GitLab)

### Working Directory, Staging Area và Git Directory

Git hoạt động với ba khu vực chính:

1. **Working Directory**: Nơi bạn làm việc với files
2. **Staging Area**: Nơi chuẩn bị các thay đổi trước khi commit
3. **Git Directory**: Nơi Git lưu trữ metadata và object database

### Commit

Commit là một snapshot của dự án tại một thời điểm cụ thể. Mỗi commit có:
- Một hash ID duy nhất
- Thông điệp mô tả thay đổi
- Thông tin về tác giả và thời gian
- Tham chiếu đến commit cha

### Branch (Nhánh)

Branch cho phép bạn tách ra khỏi dòng phát triển chính để làm việc trên các tính năng mới mà không ảnh hưởng đến code chính.

## Cài đặt Git

### Trên Windows
```bash
# Tải xuống từ https://git-scm.com/download/win
# Hoặc sử dụng Chocolatey
choco install git

# Hoặc sử dụng winget
winget install Git.Git
```

### Trên macOS
```bash
# Sử dụng Homebrew
brew install git

# Hoặc sử dụng MacPorts
sudo port install git
```

### Trên Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install git
```

### Cấu hình ban đầu
```bash
git config --global user.name "Tên của bạn"
git config --global user.email "email@example.com"
git config --global init.defaultBranch main
```

## Các lệnh Git cơ bản

### Khởi tạo và sao chép repository

```bash
# Khởi tạo repository mới
git init

# Sao chép repository từ remote
git clone https://github.com/username/repository.git

# Sao chép với tên thư mục khác
git clone https://github.com/username/repository.git my-project
```

### Làm việc với files

```bash
# Xem trạng thái repository
git status

# Thêm files vào staging area
git add filename.txt
git add .  # Thêm tất cả files

# Xem sự khác biệt
git diff  # So sánh working directory với staging area
git diff --staged  # So sánh staging area với commit cuối

# Commit thay đổi
git commit -m "Thông điệp commit"
git commit -am "Add và commit trong một lệnh"
```

### Xem lịch sử

```bash
# Xem lịch sử commit
git log
git log --oneline  # Hiển thị ngắn gọn
git log --graph    # Hiển thị dạng đồ thị
git log --author="Tên tác giả"  # Lọc theo tác giả

# Xem thay đổi trong commit cụ thể
git show commit-hash
```

### Làm việc với remote repository

```bash
# Thêm remote repository
git remote add origin https://github.com/username/repository.git

# Xem danh sách remote
git remote -v

# Đẩy code lên remote
git push origin main
git push -u origin main  # Đặt upstream branch

# Kéo code từ remote
git pull origin main
git fetch origin  # Chỉ tải về, không merge
```

## Làm việc với Branches

### Tạo và chuyển đổi branch

```bash
# Xem danh sách branch
git branch
git branch -a  # Bao gồm remote branches

# Tạo branch mới
git branch feature-login

# Chuyển sang branch khác
git checkout feature-login

# Tạo và chuyển sang branch mới
git checkout -b feature-registration

# Sử dụng git switch (Git 2.23+)
git switch feature-login
git switch -c feature-new-feature
```

### Merge và Rebase

```bash
# Merge branch vào branch hiện tại
git merge feature-login

# Rebase branch hiện tại lên branch khác
git rebase main

# Xóa branch
git branch -d feature-login     # Xóa branch đã merge
git branch -D feature-login     # Xóa branch chưa merge
```

## Xử lý xung đột (Conflicts)

Khi merge hoặc rebase, đôi khi xảy ra xung đột. Git sẽ đánh dấu các file có xung đột:

```
<<<<<<< HEAD
Code từ branch hiện tại
=======
Code từ branch khác
>>>>>>> feature-branch
```

Để giải quyết:
1. Mở file và chỉnh sửa thủ công
2. Xóa các dấu hiệu xung đột (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Add file đã sửa: `git add filename`
4. Commit: `git commit -m "Resolve conflict"`

## Các lệnh hữu ích khác

### Stash - Lưu tạm thời thay đổi

```bash
# Lưu thay đổi vào stash
git stash
git stash push -m "Work in progress"

# Xem danh sách stash
git stash list

# Áp dụng stash
git stash apply
git stash pop  # Apply và xóa khỏi stash

# Xóa stash
git stash drop
git stash clear  # Xóa tất cả stash
```

### Reset và Revert

```bash
# Reset về commit trước (nguy hiểm!)
git reset --hard HEAD~1

# Revert commit (an toàn hơn)
git revert commit-hash

# Reset file về trạng thái của commit cuối
git checkout -- filename
git restore filename  # Git 2.23+
```

### Tag

```bash
# Tạo tag
git tag v1.0.0
git tag -a v1.0.0 -m "Version 1.0.0"

# Đẩy tag lên remote
git push origin v1.0.0
git push origin --tags

# Xem danh sách tag
git tag
```

## Workflow phổ biến

### Git Flow

Git Flow là một workflow phổ biến với các branch:
- `main/master`: Code production
- `develop`: Code development
- `feature/*`: Các tính năng mới
- `release/*`: Chuẩn bị release
- `hotfix/*`: Sửa lỗi khẩn cấp

### GitHub Flow

Workflow đơn giản hơn:
1. Tạo branch từ `main`
2. Thêm commits
3. Mở Pull Request
4. Thảo luận và review
5. Merge vào `main`

## Best Practices

### Commit Messages

Viết commit message rõ ràng và có ý nghĩa:

```
feat: add user authentication
fix: resolve login validation bug
docs: update README installation guide
refactor: optimize database queries
```

### Gitignore

Tạo file `.gitignore` để loại trừ files không cần thiết:

```gitignore
# Dependencies
node_modules/
*.log

# Build outputs
dist/
build/

# Environment files
.env
.env.local

# IDE files
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db
```

### Atomic Commits

Mỗi commit nên thực hiện một thay đổi logic duy nhất. Điều này giúp:
- Dễ review code
- Dễ debug khi có lỗi
- Dễ revert nếu cần

## Troubleshooting phổ biến

### Undo commit cuối cùng

```bash
# Giữ lại thay đổi trong working directory
git reset --soft HEAD~1

# Bỏ thay đổi hoàn toàn
git reset --hard HEAD~1
```

### Thay đổi commit message cuối

```bash
git commit --amend -m "New commit message"
```

### Khôi phục file đã xóa

```bash
git checkout HEAD -- filename
git restore filename
```

## Kết luận

Git là công cụ mạnh mẽ và linh hoạt, tuy nhiên cần thời gian để thành thạo. Hãy bắt đầu với các lệnh cơ bản và dần dần khám phá các tính năng nâng cao. Việc thực hành thường xuyên và hiểu rõ workflow của team sẽ giúp bạn sử dụng Git hiệu quả hơn.

Nhớ rằng Git không chỉ là công cụ lưu trữ code mà còn là hệ thống ghi lại lịch sử phát triển dự án. Hãy tận dụng sức mạnh này để xây dựng các dự án chất lượng và cộng tác hiệu quả với team.

---
