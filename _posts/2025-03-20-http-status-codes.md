---
title: "Understanding HTTP Status Codes"
date: 2025-03-20 19:35:00 +0700
categories: [Blog, Web Programming]
tags: [HTTP, Web, StatusCode, REST]
pin: false
comments: true
---

**HTTP Status Codes** are standard response codes given by web servers on the Internet.  
They help identify the result of a client's request to the server.

---

## 1xx: Informational

- `100 Continue`: The server has received the request headers and the client should proceed to send the body.
- `101 Switching Protocols`: Server is switching protocols (e.g., upgrading to WebSocket).

---

## 2xx: Success

- `200 OK`: The request succeeded.
- `201 Created`: Resource created successfully.
- `204 No Content`: Successful request but no content returned.

---

## 3xx: Redirection

- `301 Moved Permanently`: Resource moved to a new URL.
- `302 Found`: Temporary redirection.
- `304 Not Modified`: Cached version is up-to-date.

---

## 4xx: Client Errors

- `400 Bad Request`: The server could not understand the request.
- `401 Unauthorized`: Authentication is required.
- `403 Forbidden`: Server refuses to fulfill the request.
- `404 Not Found`: The resource does not exist.

---

## 5xx: Server Errors

- `500 Internal Server Error`: Generic server error.
- `502 Bad Gateway`: Received an invalid response from the upstream server.
- `503 Service Unavailable`: The server is not ready to handle the request.

---

## Summary

Understanding HTTP status codes is essential for debugging, writing APIs, and building reliable web applications.  
They form the communication layer between client and server.

---
