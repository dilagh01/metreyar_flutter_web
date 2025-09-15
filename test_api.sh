#!/bin/bash

echo "🧪 تست اتصال به API متره یار..."

BASE_URL="https://metreyar.onrender.com"

# تست سلامت سرور
echo "✅ تست سلامت سرور:"
curl -s -X GET "$BASE_URL/health" | jq . || curl -s -X GET "$BASE_URL/health"

# تست materials endpoint
echo ""
echo "📦 تست مواد و مصالح:"
curl -s -X GET "$BASE_URL/api/v1/materials" | jq '. | length' || curl -s -X GET "$BASE_URL/api/v1/materials"

# تست estimations endpoint  
echo ""
echo "📊 تست برآوردها:"
curl -s -X GET "$BASE_URL/api/v1/estimations" | jq '. | length' || curl -s -X GET "$BASE_URL/api/v1/estimations"

# تست projects endpoint
echo ""
echo "🏗️ تست پروژه‌ها:"
curl -s -X GET "$BASE_URL/api/v1/projects" | jq '. | length' || curl -s -X GET "$BASE_URL/api/v1/projects"

echo ""
echo "🎉 تست کامل شد!"
