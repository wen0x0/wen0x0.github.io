---
title: "A Chill Introduction to Git"
date: 2023-02-05 20:21:42 +0700
categories: [Blog]
tags: [git, version control]
pin: false
comments: true
published: true
---

**Git** is a powerful version control tool that helps you track every line of code change and makes team collaboration much easier.
Whether you're just starting out or have been through many projects, knowing Git is always a big plus.

---

## Why use Git?

* Keep a history of all changes in your project.
* Smooth team collaboration — it's clear who coded what.
* Messed something up? Easily roll back to a previous version.

---

## Installing Git

Download Git from the [official website](https://git-scm.com/downloads), then verify the installation with this command:

```bash
git --version
```

If a version number shows up, you're good to go!

---

## Basic Commands

```bash
git init        # Initialize a new Git repository
git status      # Check the current state
git add .       # Stage all changes for commit
git commit -m "A lovely commit message"  # Save changes with a message
git log         # View commit history
git diff        # Show differences between changes
```

---

## Working with Remote Git

```bash
git remote add origin https://github.com/user/repo.git
git push -u origin main
git pull origin main
```

With GitHub or GitLab, you can store your code in the cloud and collaborate easily.

---

## Branch Management

```bash
git branch                    # List branches
git checkout -b new-feature   # Create and switch to a new branch
git merge new-feature         # Merge the branch into the current one
```

Each branch is like a private playground — experiment freely without affecting others.

---

## Use .gitignore to Stay Neat

Create a `.gitignore` file so Git skips unnecessary files:

```text
node_modules/
.env
*.log
```

Clean, organized, and lightweight repo!

---

## Quick Summary

Git isn’t hard — you’re just not familiar yet.
Mastering Git will boost your confidence in projects, especially in team settings.
Learning Git is a solid step toward becoming a more professional developer every day.

---
