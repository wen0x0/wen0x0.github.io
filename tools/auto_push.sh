#!/bin/bash

today=$(date +%F)

git add .

git commit -m "New Update $today"

git push origin main
