#!/bin/bash

# توکن رو اینجا بزار (توکن شما)
TOKEN="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"

# آدرس ریموت با توکن
REPO="https://${TOKEN}@github.com/dilagh01/metreyar_flutter_web.git"

# تنظیم ریموت با توکن
git remote set-url origin $REPO

# اضافه کردن همه فایل‌ها
git add .

# کامیت با پیام دلخواه
git commit -m "🚀 Commit from push.sh script"

# پوش به برنچ main
git push -u origin main
