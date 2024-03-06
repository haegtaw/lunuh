#!/bin/bash
#Все переменные и константы начинающиеся с CI_ это глобальные переменные gitlab-runner
STAGE_TYPE=$1
BOT_TOKEN="6857377300:AAGJ6C16svKvXiipxbnBTTG8xbrZG8mzZVs"
CHAT_ID="67249102"

sleep 5

if [ "$CI_JOB_STATUS" == "success" ]; then
  MESSAGE="✅ Стадия $STAGE_TYPE 👉$CI_JOB_NAME👈 успешно завершена ✅ $CI_PROJECT_URL/pipelines"
else
  MESSAGE="🚫 Стадия $STAGE_TYPE 👉$CI_JOB_NAME👈 завершилась с ошибкой! 🚫 $CI_PROJECT_URL/pipelines"
fi

curl -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$MESSAGE"
