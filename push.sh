#!/bin/bash

# تنظیمات اولیه
BRANCH="main"
COMMIT_MSG="🚀 Initial commit via SSH"

# بررسی وجود .git
if [ ! -d ".git" ]; then
  echo "📁 Initializing git repository..."
  git init
  git branch -m $BRANCH
fi

# اضافه کردن فایل‌ها
echo "➕ Adding files..."
git add .

# کامیت
echo "📝 Committing..."
git commit -m "$COMMIT_MSG"

# تنظیم ریموت اگر وجود ندارد
REMOTE_URL="git@github.com:dilagh01/metreyar_flutter_web.git"
if ! git remote | grep -q origin; then
  echo "🌐 Setting remote origin to $REMOTE_URL"
  git remote add origin "$REMOTE_URL"
else
  echo "✅ Remote origin already set."
fi

# پوش به گیت‌هاب
echo "📤 Pushing to GitHub..."
git push -u origin "$BRANCH"




