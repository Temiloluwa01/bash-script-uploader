# 📦 Project Uploader

A simple and interactive Bash script to upload a **File or Folder** to a local `uploads/` folder with optional **remote upload to AWS S3 or Azure Blob Storages**.

---

## 🛠 Features

- Accepts any file or folder as input
- Automatically compresses directories
- Copies files to `uploads/` folder with timestamped archive name
- Logs every upload in a `log.txt` file
- Optionally uploads to:
  - 🌩️ AWS S3
  - ☁️ Azure Blob Storage

---

## 🧰 Requirements

- **Bash Shell**
- Optional (for remote upload):
  - AWS CLI (for S3 uploads)
  - Azure CLI (for Azure Blob uploads)

---

## 🚀 How to Use

```bash
chmod +x project1.sh
./project1.sh <file-or-folder-name>
```

You’ll be guided step-by-step:
- If it’s a folder, it will be compressed.
- If it’s a file, you’ll be asked for confirmation.
- After local upload, you’ll be asked if you want to upload to AWS or Azure.

---

## 📂 Example

```bash
./project1.sh myfolder
```

```
✅ input provided: myfolder, checking what type of input you uploaded.
📁 Directory 'myfolder' exists.
📁 Directory 'myfolder' compressed to 'myfolder_2025-05-19_14-22-10.tar.gz'.
✅ 'myfolder' upload successful and Log added to log.txt.
Do you want to upload to a remote storage ?? (y/n):
```

---

## 📚 Logs

Each upload is recorded in a `log.txt` file with the timestamp, type (file/folder), and name.

---

## 🌐 Remote Upload Support

### ✅ AWS S3

You'll need:
- AWS CLI installed and configured (`aws configure`)
- Your S3 bucket name

### ✅ Azure Blob

You'll need:
- Azure CLI installed
- Container name, Storage account name, and Storage account key

---

## 💡 Author

Temi — Cloud Infrastructure Engineer & Bash Enthusiast 

---

## 📄 License

This project is licensed under the MIT License.