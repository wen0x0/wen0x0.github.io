#!/bin/bash

today=$(date +%F)

git add .

git commit -m "New Post $today"

git push origin main
