.PHONY: help up down restart logs clean backup ps

# Default target
help:
	@echo "╔════════════════════════════════════════════╗"
	@echo "║   N8N Local - Docker Management Commands   ║"
	@echo "╠════════════════════════════════════════════╣"
	@echo "║ up          - Start N8N container          ║"
	@echo "║ down        - Stop N8N container           ║"
	@echo "║ restart     - Restart N8N container        ║"
	@echo "║ logs        - View N8N logs (live)         ║"
	@echo "║ logs-tail   - View last 50 log lines       ║"
	@echo "║ ps          - Show container status        ║"
	@echo "║ clean       - Remove containers            ║"
	@echo "║ clean-all   - Remove containers + volumes  ║"
	@echo "║ backup      - Backup N8N data              ║"
	@echo "║ build       - Build/rebuild container      ║"
	@echo "║ shell       - Access container shell       ║"
	@echo "║ health      - Check container health       ║"
	@echo "║ help        - Show this help message        ║"
	@echo "╚════════════════════════════════════════════╝"

# Start services
up:
	@echo "🚀 Starting N8N..."
	docker-compose up -d
	@echo "✅ N8N started on http://localhost:5678"

# Stop services
down:
	@echo "🛑 Stopping N8N..."
	docker-compose down
	@echo "✅ N8N stopped"

# Restart services
restart:
	@echo "🔄 Restarting N8N..."
	docker-compose restart n8n
	@echo "✅ N8N restarted"

# View logs
logs:
	docker-compose logs -f n8n

# View last 50 logs
logs-tail:
	docker-compose logs -f --tail=50 n8n

# Show process status
ps:
	docker-compose ps

# Clean containers
clean:
	@echo "🧹 Cleaning containers..."
	docker-compose down
	@echo "✅ Containers removed"

# Clean everything including volumes
clean-all:
	@echo "⚠️  Cleaning containers and volumes..."
	docker-compose down -v
	@echo "✅ All cleaned (data deleted)"

# Build/rebuild
build:
	@echo "🔨 Building container..."
	docker-compose build --no-cache
	@echo "✅ Build complete"

# Backup data
backup:
	@echo "💾 Backing up N8N data..."
	@mkdir -p backup
	docker cp n8n_local:/home/node/.n8n ./backup/n8n_backup_$(shell date +%Y%m%d_%H%M%S)
	@echo "✅ Backup completed to ./backup/"

# Access container shell
shell:
	docker-compose exec n8n sh

# Check health
health:
	@echo "🏥 Checking N8N health..."
	@docker-compose exec -T n8n curl -s http://localhost:5678/healthz || echo "⚠️  Service not responding"

# Install N8N CLI (optional)
install-cli:
	npm install -g n8n

# List workflows
list-workflows:
	@echo "📋 Available workflows:"
	@ls -la workflows/

.DEFAULT_GOAL := help
