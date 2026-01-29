#!/usr/bin/bash
set -e

# ===============================
# CONFIG
# ===============================
LOG_DIR="$HOME/.telegram-topic-id"
LOG_FILE="$LOG_DIR/history.log"

mkdir -p "$LOG_DIR"

# ===============================
# INPUT TOKEN
# ===============================
BOT_TOKEN="$1"

if [ -z "$BOT_TOKEN" ]; then
  read -rsp "Enter BOT TOKEN: " BOT_TOKEN
  echo
fi

if [ -z "$BOT_TOKEN" ]; then
  echo "ERROR: BOT TOKEN required"
  exit 1
fi

# ===============================
# DEP CHECK
# ===============================
if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq not installed"
  echo "Install with: sudo apt install jq -y"
  exit 1
fi

# ===============================
# FETCH DATA
# ===============================
API_URL="https://api.telegram.org/bot${BOT_TOKEN}/getUpdates"

MSG=$(curl -s "$API_URL" | jq -r '
  .result
  | reverse
  | map(select(.message))
  | .[0].message
')

if [ "$MSG" = "null" ] || [ -z "$MSG" ]; then
  echo "No message found. Send a message in the topic first."
  exit 1
fi

CHAT_ID=$(echo "$MSG" | jq -r '.chat.id')
TOPIC_ID=$(echo "$MSG" | jq -r '.message_thread_id // "NONE"')
TEXT=$(echo "$MSG" | jq -r '.text // ""')
USER=$(echo "$MSG" | jq -r '.from.username // "unknown"')
TIME=$(date "+%Y-%m-%d %H:%M:%S")

# ===============================
# OUTPUT
# ===============================
echo "=============================="
echo " TELEGRAM TOPIC INFO"
echo "=============================="
echo "TIME      : $TIME"
echo "CHAT_ID   : $CHAT_ID"
echo "TOPIC_ID  : $TOPIC_ID"
echo "TEXT      : $TEXT"
echo "FROM      : @$USER"
echo "=============================="

# ===============================
# LOGGING
# ===============================
cat >> "$LOG_FILE" <<EOF
[$TIME]
CHAT_ID=$CHAT_ID
TOPIC_ID=$TOPIC_ID
FROM=@$USER
TEXT=$TEXT
------------------------------
EOF

echo "✔ Logged to: $LOG_FILE"

