---
title: "Learn Regular Expressions (Regex) Basics"
date: 2025-02-25 20:21:42 +0700
categories: [Notes]
tags: [Regex, Pattern, Search]
pin: false
comments: true
---

**Regular Expressions (Regex)** are powerful tools for pattern matching and text processing.
They're widely used in search, data validation, parsing logs, and more.

---

## What is Regex?

A **regular expression** is a special string that describes a search pattern.
It allows you to match complex text using concise syntax.

```text
abc     # Matches exact 'abc'
\d      # Matches any digit (0–9)
\w      # Matches any word character (a-z, A-Z, 0-9, _)
\s      # Matches any whitespace (space, tab, newline)
.       # Matches any character except newline
```

---

## Quantifiers

```text
a*      # 0 or more of 'a'
a+      # 1 or more of 'a'
a?      # 0 or 1 of 'a'
a{3}    # Exactly 3 of 'a'
a{2,4}  # Between 2 and 4 of 'a'
```

---

## Character Classes

```text
[abc]       # Matches 'a', 'b', or 'c'
[^abc]      # Not 'a', 'b', or 'c'
[a-zA-Z0-9] # Any letter or digit
```

---

## Anchors

```text
^start   # Match at beginning
end$     # Match at end
\bword\b   # Word boundary 
```

---

## Groups and Alternation

```text
(grab|take)   # Matches 'grab' or 'take'
(colou?r)     # 'color' or 'colour'
(\d{3})-(\d{2})-(\d{4})  # Grouped SSN-like pattern
```

---

## Common Use Cases

### Validate an Email

```text
^[\w.-]+@[\w.-]+\.\w+$
```

### Find All URLs

```text
https?:\/\/(www\.)?[\w\-]+(\.[\w\-]+)+
```

### Extract Words

```text
\b\w+\b
```

---

## Try It Live

Use online tools like:

- [regex101.com](https://regex101.com)
- [regexper.com](https://regexper.com)

---

## Summary

Regex might look scary at first, but once you learn its building blocks,
you'll have a tool to quickly search, filter, and extract text like a pro.

---
