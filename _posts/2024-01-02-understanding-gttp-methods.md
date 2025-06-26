---
title: "Understanding HTTP Methods"
date: 2024-01-02 17:35:00 +0700
categories: [Blog, Web]
tags: [http, web, rest, api, method]
pin: false
comments: true
published: true
---

**HTTP Methods** define the actions to be performed on a specific resource.
They are like the *verbs* of the web — fundamental in designing and communicating through RESTful APIs.

---

## GET

* Used to **retrieve data** from the server.
* Safe and **idempotent** — no side effects.
* Example: `GET /users` returns a list of users.

---

## POST

* Used to **send data** for processing (e.g., to create a new resource).
* Often results in the creation of **a new resource**.
* Example: `POST /users` with a JSON body to add a new user.

---

## PUT

* Used to **completely replace** an existing resource.
* Idempotent — calling it multiple times with the same data gives the same result.
* Example: `PUT /users/123` replaces all information of user 123.

---

## PATCH

* Used to **partially update** a resource.
* Unlike PUT, only sends fields that need to change.
* Example: `PATCH /users/123` with `{ "email": "new@mail.com" }`.

---

## DELETE

* Used to **delete** a resource.
* Idempotent — deleting multiple times yields the same result.
* Example: `DELETE /users/123`.

---

## OPTIONS

* Used to **describe communication options** for a resource.
* Commonly seen in **CORS preflight** requests.

---

## HEAD

* Similar to GET, but only returns the **headers**, not the body.
* Useful for checking resource existence or viewing metadata.

---

## Summary

Understanding HTTP methods is essential when working with APIs and web services.
They define the "contract" between client and server, making the system more consistent and well-designed.

---
