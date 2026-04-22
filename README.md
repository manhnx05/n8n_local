## 📌 Overview
This project sets up n8n using Docker to build and manage automation workflows.

## 🧰 Tech Stack
- n8n
- Docker / Docker Compose

## ⚙️ Setup

### 1. Clone repo
git clone <your-repo-url>
cd <repo>

### 2. Run with Docker
docker-compose up -d

### 3. Access n8n
http://localhost:5678

## 🔐 Default Login
- User: admin
- Password: admin

## 📂 Project Structure
.
├── docker-compose.yml
├── .env
└── workflows/

## 💡 Features
- Easy deployment with Docker
- Persistent data
- Custom workflows support

## 📌 Notes
- Make sure port 5678 is not in use
- Update .env for production use
