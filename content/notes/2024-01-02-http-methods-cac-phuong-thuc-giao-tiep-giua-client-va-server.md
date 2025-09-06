+++
title = "Các phương thức HTTP"
description = "Tìm hiểu chi tiết về các HTTP Methods - GET, POST, PUT, PATCH, DELETE và cách sử dụng chúng trong RESTful APIs"
date = 2024-01-02
draft = false
[taxonomies]
categories = ["Notes"]
tags = ["http", "web", "api", "rest"]
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

HTTP (HyperText Transfer Protocol) là giao thức nền tảng của World Wide Web, định nghĩa cách thức client (trình duyệt web, ứng dụng mobile) và server (máy chủ web) giao tiếp với nhau. Trong bài viết này, chúng ta sẽ tìm hiểu chi tiết về các HTTP Methods - những "động từ" mô tả hành động mà client muốn thực hiện với tài nguyên trên server.

## HTTP Method là gì?

HTTP Method (hay còn gọi là HTTP Verb) là một phần quan trọng trong HTTP request, cho biết loại hành động mà client muốn thực hiện với tài nguyên được chỉ định. Mỗi method có ý nghĩa và cách hoạt động riêng biệt, giúp tạo ra một hệ thống giao tiếp chuẩn và dễ hiểu.

Khi bạn nhập một URL vào trình duyệt và nhấn Enter, trình duyệt sẽ gửi một HTTP request với method GET đến server. Khi bạn điền form đăng ký tài khoản và nhấn "Đăng ký", trình duyệt thường gửi POST request.

## Cấu trúc của HTTP Request

Trước khi đi sâu vào các methods, hãy xem cấu trúc cơ bản của một HTTP request:

```
GET /api/users/123 HTTP/1.1
Host: example.com
User-Agent: Mozilla/5.0
Accept: application/json
Authorization: Bearer token123
```

Trong đó:
- **GET** là HTTP method
- **/api/users/123** là đường dẫn đến tài nguyên
- **HTTP/1.1** là phiên bản HTTP
- Các dòng tiếp theo là headers chứa thông tin bổ sung

## Các HTTP Methods chính

### 1. GET - Lấy dữ liệu

**Mục đích**: Yêu cầu lấy dữ liệu từ server mà không thay đổi gì trên server.

**Đặc điểm**:
- **Safe**: Không thay đổi trạng thái server
- **Idempotent**: Gọi nhiều lần cho kết quả giống nhau
- **Cacheable**: Có thể được cache để tăng hiệu suất
- Dữ liệu được gửi qua URL parameters (query string)

**Ví dụ thực tế**:
```
GET /api/users HTTP/1.1
Host: example.com

# Lấy danh sách người dùng với bộ lọc
GET /api/products?category=electronics&price_max=500 HTTP/1.1
Host: shop.com

# Lấy thông tin chi tiết một sản phẩm
GET /api/products/123 HTTP/1.1
Host: shop.com
```

**Khi nào sử dụng**:
- Lấy danh sách dữ liệu (sản phẩm, bài viết, người dùng)
- Xem chi tiết một mục cụ thể
- Tìm kiếm và lọc dữ liệu
- Tải trang web

**Response thành công**: 200 OK

### 2. POST - Tạo mới dữ liệu

**Mục đích**: Gửi dữ liệu đến server để tạo tài nguyên mới hoặc thực hiện một hành động.

**Đặc điểm**:
- **Not Safe**: Có thể thay đổi trạng thái server
- **Not Idempotent**: Gọi nhiều lần có thể tạo ra kết quả khác nhau
- **Not Cacheable**: Thường không được cache
- Dữ liệu được gửi trong request body

**Ví dụ thực tế**:
```
POST /api/users HTTP/1.1
Host: example.com
Content-Type: application/json

{
  "name": "Nguyễn Văn A",
  "email": "nguyenvana@example.com",
  "password": "securepassword123"
}
```

```
POST /api/orders HTTP/1.1
Host: shop.com
Content-Type: application/json

{
  "user_id": 123,
  "items": [
    {"product_id": 456, "quantity": 2},
    {"product_id": 789, "quantity": 1}
  ],
  "shipping_address": "123 Đường ABC, Quận 1, TP.HCM"
}
```

**Khi nào sử dụng**:
- Đăng ký tài khoản mới
- Tạo bài viết, sản phẩm mới
- Gửi form liên hệ
- Xử lý thanh toán
- Upload file

**Response thành công**: 201 Created hoặc 200 OK

### 3. PUT - Cập nhật toàn bộ dữ liệu

**Mục đích**: Thay thế hoàn toàn một tài nguyên hoặc tạo mới nếu không tồn tại.

**Đặc điểm**:
- **Not Safe**: Thay đổi trạng thái server
- **Idempotent**: Gọi nhiều lần cho kết quả giống nhau
- **Not Cacheable**: Không được cache
- Thay thế toàn bộ tài nguyên

**Ví dụ thực tế**:
```
PUT /api/users/123 HTTP/1.1
Host: example.com
Content-Type: application/json

{
  "id": 123,
  "name": "Nguyễn Văn B",
  "email": "nguyenvanb@example.com",
  "phone": "0901234567",
  "address": "456 Đường XYZ, Quận 2, TP.HCM"
}
```

**Khi nào sử dụng**:
- Cập nhật thông tin hồ sơ người dùng
- Thay đổi cấu hình hệ thống
- Cập nhật toàn bộ thông tin sản phẩm

**Response thành công**: 200 OK hoặc 204 No Content

### 4. PATCH - Cập nhật một phần dữ liệu

**Mục đích**: Cập nhật một phần của tài nguyên, chỉ những trường được chỉ định.

**Đặc điểm**:
- **Not Safe**: Thay đổi trạng thái server
- **Not Idempotent**: Có thể không idempotent tùy thuộc vào implementation
- **Not Cacheable**: Không được cache
- Chỉ cập nhật các trường được gửi

**Ví dụ thực tế**:
```
PATCH /api/users/123 HTTP/1.1
Host: example.com
Content-Type: application/json

{
  "phone": "0987654321"
}
```

```
PATCH /api/products/456 HTTP/1.1
Host: shop.com
Content-Type: application/json

{
  "price": 299000,
  "stock": 15
}
```

**Khi nào sử dụng**:
- Cập nhật một vài trường thông tin
- Thay đổi trạng thái (active/inactive)
- Cập nhật số lượng tồn kho

**Response thành công**: 200 OK hoặc 204 No Content

### 5. DELETE - Xóa dữ liệu

**Mục đích**: Xóa tài nguyên được chỉ định trên server.

**Đặc điểm**:
- **Not Safe**: Thay đổi trạng thái server
- **Idempotent**: Xóa nhiều lần không tạo ra hiệu ứng phụ
- **Not Cacheable**: Không được cache

**Ví dụ thực tế**:
```
DELETE /api/users/123 HTTP/1.1
Host: example.com
Authorization: Bearer token123
```

```
DELETE /api/posts/456 HTTP/1.1
Host: blog.com
Authorization: Bearer token123
```

**Khi nào sử dụng**:
- Xóa tài khoản người dùng
- Xóa bài viết, sản phẩm
- Hủy đơn hàng
- Xóa file upload

**Response thành công**: 200 OK, 202 Accepted, hoặc 204 No Content

### 6. HEAD - Lấy metadata

**Mục đích**: Giống GET nhưng chỉ trả về headers, không có response body.

**Đặc điểm**:
- **Safe**: Không thay đổi trạng thái server
- **Idempotent**: Gọi nhiều lần cho kết quả giống nhau
- **Cacheable**: Có thể được cache
- Không có response body

**Ví dụ thực tế**:
```
HEAD /api/users/123 HTTP/1.1
Host: example.com
```

**Khi nào sử dụng**:
- Kiểm tra tài nguyên có tồn tại không
- Lấy thông tin về size file trước khi download
- Kiểm tra Last-Modified để caching

### 7. OPTIONS - Lấy thông tin về các methods được hỗ trợ

**Mục đích**: Truy vấn các HTTP methods được hỗ trợ cho một tài nguyên.

**Đặc điểm**:
- **Safe**: Không thay đổi trạng thái server
- **Idempotent**: Gọi nhiều lần cho kết quả giống nhau
- Quan trọng cho CORS (Cross-Origin Resource Sharing)

**Ví dụ thực tế**:
```
OPTIONS /api/users HTTP/1.1
Host: example.com
Origin: https://myapp.com
```

**Response**:
```
HTTP/1.1 200 OK
Allow: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Origin: https://myapp.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE
```

**Khi nào sử dụng**:
- CORS preflight requests
- API discovery
- Kiểm tra quyền truy cập

## RESTful API và HTTP Methods

REST (Representational State Transfer) là một kiến trúc phổ biến cho việc thiết kế web services, sử dụng HTTP methods một cách có ý nghĩa:

### CRUD Operations với REST

```
# Create (Tạo mới)
POST /api/products
{
  "name": "iPhone 15",
  "price": 25000000,
  "category": "smartphone"
}

# Read (Đọc)
GET /api/products          # Lấy danh sách
GET /api/products/123      # Lấy chi tiết

# Update (Cập nhật)
PUT /api/products/123      # Cập nhật toàn bộ
PATCH /api/products/123    # Cập nhật một phần

# Delete (Xóa)
DELETE /api/products/123
```

### RESTful URL Design

```
# Collection và Resource
GET /api/users             # Lấy danh sách users
GET /api/users/123         # Lấy user có ID 123
POST /api/users            # Tạo user mới
PUT /api/users/123         # Cập nhật user 123
DELETE /api/users/123      # Xóa user 123

# Nested Resources
GET /api/users/123/orders      # Lấy đơn hàng của user 123
POST /api/users/123/orders     # Tạo đơn hàng cho user 123
```

## HTTP Status Codes kèm theo Methods

### GET Responses
- **200 OK**: Thành công
- **404 Not Found**: Không tìm thấy tài nguyên
- **304 Not Modified**: Dữ liệu chưa thay đổi (cache)

### POST Responses
- **201 Created**: Tạo thành công
- **400 Bad Request**: Dữ liệu đầu vào không hợp lệ
- **409 Conflict**: Tài nguyên đã tồn tại

### PUT/PATCH Responses
- **200 OK**: Cập nhật thành công
- **204 No Content**: Cập nhật thành công, không trả về dữ liệu
- **404 Not Found**: Không tìm thấy tài nguyên cần cập nhật

### DELETE Responses
- **200 OK**: Xóa thành công
- **204 No Content**: Xóa thành công, không trả về dữ liệu
- **404 Not Found**: Không tìm thấy tài nguyên cần xóa

## Best Practices khi sử dụng HTTP Methods

### 1. Sử dụng đúng method cho đúng mục đích

```
# Sai: Sử dụng GET để xóa dữ liệu
GET /api/users/delete/123

# Đúng: Sử dụng DELETE
DELETE /api/users/123
```

### 2. Idempotency trong thiết kế API

```
# PUT nên idempotent
PUT /api/users/123
{
  "name": "Nguyễn Văn A",
  "email": "nguyenvana@example.com"
}
# Gọi nhiều lần không tạo ra side effects
```

### 3. Sử dụng PATCH cho partial updates

```
# Không hiệu quả: Gửi toàn bộ object
PUT /api/users/123
{
  "id": 123,
  "name": "Old Name",
  "email": "new.email@example.com",  # Chỉ thay đổi email
  "phone": "0901234567",
  "address": "Old Address"
}

# Hiệu quả: Chỉ gửi trường cần thay đổi
PATCH /api/users/123
{
  "email": "new.email@example.com"
}
```

### 4. Content-Type headers

```
# JSON data
POST /api/users HTTP/1.1
Content-Type: application/json

{
  "name": "Test User"
}

# Form data
POST /api/upload HTTP/1.1
Content-Type: multipart/form-data

# URL encoded
POST /api/login HTTP/1.1
Content-Type: application/x-www-form-urlencoded

username=testuser&password=123456
```

### 5. Authentication và Authorization

```
# Bearer token
GET /api/private-data HTTP/1.1
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Basic auth
GET /api/admin HTTP/1.1
Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=

# API Key
GET /api/data HTTP/1.1
X-API-Key: abc123def456ghi789
```

## Các lỗi thường gặp

### 1. Sử dụng GET cho các hành động thay đổi dữ liệu

```
# Nguy hiểm: Search engines có thể crawl và xóa dữ liệu
GET /admin/delete-user?id=123

# An toàn
DELETE /admin/users/123
```

### 2. Không handle idempotency đúng cách

```
# PUT không idempotent
PUT /api/users/123/increment-score
# Gọi nhiều lần sẽ tăng score nhiều lần

# PUT idempotent
PUT /api/users/123/score
{
  "score": 100
}
```

### 3. Trả về status code không phù hợp

```javascript
// Sai: Trả về 200 khi không tìm thấy
app.get('/api/users/:id', (req, res) => {
  const user = findUser(req.params.id);
  if (!user) {
    return res.status(200).json({ message: 'User not found' });
  }
  res.json(user);
});

// Đúng: Trả về 404
app.get('/api/users/:id', (req, res) => {
  const user = findUser(req.params.id);
  if (!user) {
    return res.status(404).json({ error: 'User not found' });
  }
  res.json(user);
});
```

## Testing HTTP Methods

### Sử dụng cURL

```bash
# GET request
curl -X GET "https://api.example.com/users"

# POST request
curl -X POST "https://api.example.com/users" \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com"}'

# PUT request
curl -X PUT "https://api.example.com/users/123" \
  -H "Content-Type: application/json" \
  -d '{"name":"Updated Name","email":"updated@example.com"}'

# DELETE request
curl -X DELETE "https://api.example.com/users/123" \
  -H "Authorization: Bearer token123"
```

### Sử dụng Postman

Postman là công cụ GUI phổ biến để test APIs:

1. Tạo collection cho API
2. Thêm requests với các methods khác nhau
3. Thiết lập headers và body
4. Sử dụng variables và environments
5. Viết tests tự động

### Sử dụng JavaScript Fetch API

```javascript
// GET request
const getUsers = async () => {
  const response = await fetch('/api/users');
  const users = await response.json();
  return users;
};

// POST request
const createUser = async (userData) => {
  const response = await fetch('/api/users', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(userData)
  });
  return response.json();
};

// PUT request
const updateUser = async (id, userData) => {
  const response = await fetch(`/api/users/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(userData)
  });
  return response.json();
};

// DELETE request
const deleteUser = async (id) => {
  const response = await fetch(`/api/users/${id}`, {
    method: 'DELETE'
  });
  return response.ok;
};
```

## Bảo mật với HTTP Methods

### 1. Validation và Sanitization

```javascript
// Kiểm tra dữ liệu đầu vào
app.post('/api/users', (req, res) => {
  const { name, email, password } = req.body;
  
  // Validation
  if (!name || name.length < 2) {
    return res.status(400).json({ error: 'Tên phải có ít nhất 2 ký tự' });
  }
  
  if (!isValidEmail(email)) {
    return res.status(400).json({ error: 'Email không hợp lệ' });
  }
  
  if (password.length < 8) {
    return res.status(400).json({ error: 'Mật khẩu phải có ít nhất 8 ký tự' });
  }
  
  // Sanitization
  const sanitizedData = {
    name: sanitize(name),
    email: sanitize(email),
    password: hashPassword(password)
  };
  
  // Tạo user...
});
```

### 2. Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

// Giới hạn POST requests
const postLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 phút
  max: 10, // Tối đa 10 requests
  message: 'Quá nhiều yêu cầu tạo mới, vui lòng thử lại sau'
});

app.post('/api/users', postLimiter, (req, res) => {
  // Xử lý tạo user
});
```

### 3. CORS Configuration

```javascript
const cors = require('cors');

app.use(cors({
  origin: ['https://myapp.com', 'https://admin.myapp.com'],
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true
}));
```

## Performance Optimization

### 1. Caching cho GET requests

```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 300 }); // Cache 5 phút

app.get('/api/users', (req, res) => {
  const cacheKey = 'users_list';
  const cachedData = cache.get(cacheKey);
  
  if (cachedData) {
    return res.json(cachedData);
  }
  
  const users = getUsersFromDatabase();
  cache.set(cacheKey, users);
  res.json(users);
});
```

### 2. Pagination cho GET requests

```javascript
app.get('/api/users', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  
  const users = getUsersFromDatabase(limit, offset);
  const total = getTotalUsersCount();
  
  res.json({
    data: users,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit)
    }
  });
});
```

### 3. Compression

```javascript
const compression = require('compression');

app.use(compression({
  filter: (req, res) => {
    if (req.headers['x-no-compression']) {
      return false;
    }
    return compression.filter(req, res);
  }
}));
```

## Kết luận

HTTP Methods là nền tảng của giao tiếp web hiện đại. Hiểu rõ từng method và cách sử dụng chúng đúng cách sẽ giúp bạn:

**Xây dựng APIs chất lượng**: RESTful, dễ hiểu và maintainable

**Tối ưu performance**: Sử dụng caching hiệu quả, giảm tải server

**Đảm bảo bảo mật**: Proper validation, authorization và rate limiting

**Tăng trải nghiệm người dùng**: Responses nhanh, error handling tốt

**Dễ dàng debugging**: Clear semantics giúp troubleshooting dễ dàng hơn

Hãy luôn nhớ các nguyên tắc cơ bản: GET để lấy dữ liệu, POST để tạo mới, PUT/PATCH để cập nhật, DELETE để xóa. Kết hợp với việc sử dụng đúng status codes và headers, bạn sẽ tạo ra những APIs professional và robust.

Trong thực tế, việc thiết kế API tốt không chỉ dừng lại ở việc chọn đúng HTTP method mà còn bao gồm nhiều yếu tố khác như authentication, error handling, documentation, và monitoring. Tuy nhiên, nắm vững HTTP Methods là bước đầu tiên và quan trọng nhất trong hành trình này.

---
