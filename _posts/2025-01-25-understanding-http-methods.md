---
title: "Understanding HTTP Methods"
date: 2025-01-25 17:35:00 +0700
categories: [Blog, Web]
tags: [http, web, rest, api, method]
pin: false
comments: true
published: true
---

**HTTP Methods** define the action to be performed on a given resource.  
They are the verbs of the web — fundamental in RESTful API design and communication.

---

## GET

- Used to **retrieve** data from a server.
- Should have **no side effects** — safe and idempotent.
- Example: `GET /users` returns a list of users.

---

## POST

- Used to **submit** data to be processed (e.g., create a new resource).
- Typically results in a **new resource** being created.
- Example: `POST /users` with a JSON body to add a new user.

---

## PUT

- Used to **replace** an existing resource entirely.
- Idempotent — calling it multiple times yields the same result.
- Example: `PUT /users/123` to replace user 123’s data.

---

## PATCH

- Used to **partially update** a resource.
- Unlike PUT, it sends only the fields to be updated.
- Example: `PATCH /users/123` with `{ "email": "new@mail.com" }`.

---

## DELETE

- Used to **delete** a resource.
- Idempotent — deleting the same resource multiple times results in the same outcome.
- Example: `DELETE /users/123`.

---

## OPTIONS

- Used to **describe communication options** for a resource.
- Common in **CORS** preflight requests.

---

## HEAD

- Same as GET, but returns **only headers**, not the body.
- Useful to check if a resource exists or inspect metadata.

---

## Summary

Understanding HTTP methods is key to working with APIs and web services effectively.  
They define the contract between client and server, promoting clarity and consistency in system design.

---
