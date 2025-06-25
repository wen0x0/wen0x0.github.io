#!/bin/bash

# === 1. Get the Write-up Title from arguments ===
TITLE="$*"

if [ -z "$TITLE" ]; then
  echo "Write-up Title is required!"
  echo "Usage: ./new_writeup.sh \"Write-up Title\""
  exit 1
fi

# === 2. Format title into a filename-friendly slug (lowercase, hyphenated) ===
SLUG=$(echo "$TITLE" | iconv -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')

# === 3. Get current date and time ===
DATE=$(date +"%Y-%m-%d")
DATETIME=$(date +"%Y-%m-%d %H:%M:%S %z")

# === 4. Compose file name and path ===
FILENAME="_posts/$DATE-$SLUG.md"

# === 5. Generate front matter and content ===
cat > "$FILENAME" <<EOF
---
title: "$TITLE · "
date: $DATETIME
categories: [CTF]
tags: [write-ups]
pin: false
comments: false
published: false
---

## Challenge Info

- **Name**:   
- **Category**: 
- **Platform**:   
- **Resource**:
- **Description**:  
  **

- **Hints**:  
  - **  


---

## Recon & Initial Analysis

...

---

## Step-by-step Solution

...

---

## Notes & Tips

...

---

## References

- ...
EOF

echo "New write-up created at: $POST_FILE"
