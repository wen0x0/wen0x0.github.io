---
title: "Understanding HTTP Status Codes"
date: 2024-03-20 19:35:00 +0700
categories: [Blog, Web]
tags: [http, web, status code, rest]
pin: false
comments: true
published: true
---

**HTTP Status Codes** are standard codes returned by the server when a client sends a request.
They help us understand how the server handled the request — whether it was successful, an error occurred, or redirection is needed.

---

## 1xx: Informational

* `100 Continue`: The server has received the headers; the client should proceed to send the body.
* `101 Switching Protocols`: The server agrees to switch protocols (e.g., upgrading to WebSocket).

---

## 2xx: Success

* `200 OK`: Everything is fine, the request was successful.
* `201 Created`: A new resource has been created.
* `204 No Content`: Successful but no data is returned.

---

## 3xx: Redirection

* `301 Moved Permanently`: The resource has permanently moved to a new URL.
* `302 Found`: Temporary redirection.
* `304 Not Modified`: The data hasn’t changed, use the cached version.

---

## 4xx: Client Errors

* `400 Bad Request`: The request syntax is invalid; the server can't process it.
* `401 Unauthorized`: Authentication is required to proceed.
* `403 Forbidden`: The server understands but refuses to authorize.
* `404 Not Found`: The resource could not be found.

---

## 5xx: Server Errors

* `500 Internal Server Error`: The server encountered an unexpected condition.
* `502 Bad Gateway`: A proxy server received an invalid response from an upstream server.
* `503 Service Unavailable`: The server is overloaded or under maintenance and can't handle the request now.

---

## Quick Summary

Knowing HTTP status codes will help you debug faster, write better APIs,
and understand how the client and server are "communicating".
If you’re serious about web development, they’re essential!

---
