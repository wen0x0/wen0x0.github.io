---
title: "Mastering Grep for Efficient Text Search"
date: 2025-03-10 19:15:00 +0700
categories: [Blog]
tags: [Grep, CLI, Search, Regex]
pin: false
comments: true
---

**Grep** is a command-line tool used to search for text using patterns or regular expressions.  
It’s fast, powerful, and an essential tool for developers and system administrators.

---

## What is `grep`?

`grep` stands for **Global Regular Expression Print**.  
It scans files or input streams and prints lines that match a given pattern.

```bash
grep "pattern" file.txt
```

It supports both **basic** and **extended regular expressions**, enabling complex text searches.

---

## Basic Usage

```bash
grep error logfile.txt
```

- Prints all lines containing "error" from `logfile.txt`.

```bash
grep -i error logfile.txt
```

- Case-insensitive search for "error".

```bash
grep -n error logfile.txt
```

- Show line numbers of matches.

---

## Using Regular Expressions

```bash
grep "^ERROR" logfile.txt
```

- Lines starting with `ERROR`.

```bash
grep "[0-9]\{3\}-[0-9]\{2\}-[0-9]\{4\}" data.txt
```

- Match SSN-like pattern (e.g., 123-45-6789).

```bash
grep -E "dog|cat" animals.txt
```

- Use `-E` for extended regex (matches "dog" or "cat").

---

## Search Recursively

```bash
grep -r TODO .
```

- Find all TODO comments recursively from the current directory.

```bash
grep -r --include="*.py" "import" .
```

- Only search inside `.py` files.

---

## Highlight Matches

```bash
grep --color=auto pattern file.txt
```

- Highlights the matched pattern in color.

---

## Combine with Pipes

```bash
ps aux | grep java
```

- Find Java processes.

```bash
dmesg | grep -i usb
```

- Look for USB-related kernel messages.

---

## Summary

`grep` is a simple yet powerful utility. When paired with regular expressions,  
it becomes an indispensable tool for quick text processing, debugging logs, or finding patterns across codebases.

---

Happy grepping!
