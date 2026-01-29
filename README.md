# Telegram Topic ID Finder (Local CLI)

Tool CLI lokal berbasis Bash untuk mengambil **chat_id** dan **topic_id (message_thread_id)** dari grup Telegram yang menggunakan **Forum / Topics**.

Dirancang agar aman, mudah dipakai, dan portable ke berbagai perangkat (laptop, server, NAS, ARM box) tanpa Python dan tanpa pip.

---

## ✨ Features

- Input BOT TOKEN secara interaktif
- Token dimasking menggunakan `*`
- Bisa paste token
- Output bersih dan rapi
- History / log otomatis
- Pure Bash (`curl + jq`)
- Aman untuk repository public

---

## 📦 Requirements

- bash  
- curl  
- jq  

Install di Ubuntu / Debian:

```bash
sudo apt update
sudo apt install -y curl jq
```

---

## 📥 Download

```bash
curl -O https://raw.githubusercontent.com/WaeTechDesign/telegram-topic-id/master/telegram-topic-id.sh
chmod +x telegram-topic-id.sh
```

## 🚀 Usage

Jalankan secara lokal:

```bash
./telegram-topic-id.sh
```

Script akan meminta BOT TOKEN secara interaktif:

```markdown
Enter BOT TOKEN: ********************
```

## 📤 Output Example
```yaml
==============================
 TELEGRAM TOPIC INFO
==============================
TIME      : 2026-01-29 22:15:04
CHAT_ID   : -1001234567890
TOPIC_ID  : 15
TEXT      : test
FROM      : @username
==============================
✔ Logged to: /home/user/.telegram-topic-id/history.log

```

## 📝 History / Log

Setiap eksekusi akan otomatis disimpan ke:

```bash
~/.telegram-topic-id/history.log
```

Lihat log:

```bash
cat ~/.telegram-topic-id/history.log
```

Live monitoring: 

```bash
tail -f ~/.telegram-topic-id/history.log
```

Bersihkan log: 

```bash
> ~/.telegram-topic-id/history.log
```
