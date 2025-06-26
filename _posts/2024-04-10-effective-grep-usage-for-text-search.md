---
title: "Effective Grep Usage for Text Search"
date: 2024-04-10 19:15:00 +0700
categories: [Blog]
tags: [grep, cli, regex]
pin: false
comments: true
published: true
---

**Grep** is an incredibly powerful command-line tool for searching text using patterns or regular expressions.
Fast, lightweight, and convenient — grep is an essential companion for sysadmins, developers, or anyone working with text.

---

## What is Grep?

`grep` stands for **Global Regular Expression Print**.
It scans through file content (or input) and prints lines that match the given pattern.

```bash
grep "pattern_to_find" file.txt
```

Grep supports both **basic** and **extended regular expressions**, allowing you to create complex patterns for precise data retrieval.

---

## Basic Usage

```bash
grep error logfile.txt
```

* Prints lines containing "error" in `logfile.txt`.

```bash
grep -i error logfile.txt
```

* Case-insensitive search.

```bash
grep -n error logfile.txt
```

* Displays line numbers with matches.

---

## Using Regular Expressions

```bash
grep "^ERROR" logfile.txt
```

* Lines starting with `ERROR`.

```bash
grep "[0-9]\{3\}-[0-9]\{2\}-[0-9]\{4\}" data.txt
```

* Matches Social Security Number (SSN) patterns like `123-45-6789`.

```bash
grep -E "dog|cat" animals.txt
```

* Use `-E` for extended regex, e.g., lines containing "dog" or "cat".

---

## Recursive Search

```bash
grep -r TODO .
```

* Find all lines with `TODO` from the current and subdirectories.

```bash
grep -r --include="*.py" "import" .
```

* Only search within `.py` files.

---

## Highlight Matches

```bash
grep --color=auto pattern file.txt
```

* Highlights matched patterns — useful when viewing logs or long outputs.

---

## Combine with Pipes

```bash
ps aux | grep java
```

* Find running Java processes.

```bash
dmesg | grep -i usb
```

* Search kernel messages related to USB.

---

## Summary

`grep` may seem simple, but it becomes incredibly powerful once you tap into its full potential.
With regex, you can filter logs, scan data, or debug thousands of lines of code efficiently.

---
