x#!/bin/bash

# ⚙️ متغیرها را تغییر بده
GITHUB_USERNAME="dilagh01"
REPO_NAME="metreyar_flutter_web"
TOKEN="<YOUR_TOKEN>" # توکن دائمی جایگزین کن

# 📂 اگر پروژه Git نیست، init کن
if [ ! -d ".git" ]; then
  git init
fi

# 🌳 تغییر نام شاخه (در صورت نیاز)
git branch -M main

# 🔗 افزودن ریموت با توکن
git remote remove origin 2> /dev/null
git remote add origin https://${GITHUB_USERNAME}:${TOKEN}@github.com/${GITHUB_USERNAME}/${REPO_NAME}.git

# 📦 افزودن همه فایل‌ها و کامیت
git add .
git commit -m "🚀 Initial commit with Flutter project"

# ⬆️ پوش به ریپوی اصلی
git push -u origin main
