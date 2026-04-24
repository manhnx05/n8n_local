# 🚀 N8N Local Automation Platform

A complete n8n automation workflow setup using Docker and Docker Compose.

## 📌 Overview

This project provides a ready-to-use n8n instance for building, testing, and managing automation workflows locally. n8n is an open-source workflow automation platform with 400+ integrations.

**n8n** makes it easy to link data and automate repetitive tasks, connecting any app or service without writing code.

## 🧰 Tech Stack

- **n8n** - Workflow automation platform
- **Docker** - Containerization
- **Docker Compose** - Container orchestration
- **Node.js** - Runtime environment

## 📂 Project Structure

```
n8n-local/
├── docker-compose.yml      # Docker configuration
├── .env                    # Environment variables
├── .gitignore             # Git ignore rules
├── Makefile               # Useful shortcuts
├── README.md              # This file (comprehensive documentation)
├── workflows/             # Workflow definitions
│   └── example-workflow.json  # Example workflow
└── data/                  # Local data storage
```

## ⚙️ Prerequisites

- **Docker Desktop** (Windows/Mac) or Docker Engine (Linux)
- **Docker Compose** (usually included with Docker Desktop)
- **Git** (for version control)
- **Minimum 2GB RAM** allocated to Docker

## 🚀 Quick Start

### 1. Clone Repository

```bash
git clone <your-repo-url>
cd N8N-Local
```

### 2. Configure Environment (Optional)

Edit `.env` file if needed for production use:

```bash
# Update credentials, timezone, etc.
nano .env  # Mac/Linux
# or edit with your editor on Windows
```

### 3. Start N8N

```bash
# Start in background
docker-compose up -d

# View logs (wait 30-60 seconds for startup)
docker-compose logs -f n8n
```

### 4. Access N8N

Open browser and navigate to: **http://localhost:5678**

### 5. Login

- **Username**: admin
- **Password**: admin

---

## 📝 Common Docker Commands

### Start Services

```bash
docker-compose up -d
```

### Stop Services

```bash
docker-compose down
```

### View Logs (live follow)

```bash
docker-compose logs -f n8n
```

### View Last 50 Logs

```bash
docker-compose logs --tail=50 n8n
```

### Restart Service

```bash
docker-compose restart n8n
```

### Check Container Status

```bash
docker-compose ps
```

### Remove Everything (Data Included)

```bash
docker-compose down -v
```

### Rebuild Container

```bash
docker-compose down
docker-compose up -d --build
```

## 🎯 Using Makefile (Optional)

For convenience, use Makefile shortcuts:

```bash
make help       # Show all commands
make up         # Start N8N
make down       # Stop N8N
make restart    # Restart N8N
make logs       # View logs (live)
make logs-tail  # Last 50 logs
make ps         # Show status
make clean      # Remove containers
make clean-all  # Remove containers + volumes
make backup     # Backup data
make shell      # Access container shell
make health     # Check container health
```

---

## 🔧 Configuration

### Environment Variables (.env)

Key configurations available:

| Variable | Default | Description |
|----------|---------|-------------|
| `N8N_HOST` | localhost | Host address |
| `N8N_PORT` | 5678 | Port number |
| `N8N_PROTOCOL` | http | Protocol (http/https) |
| `NODE_ENV` | production | Environment mode |
| `GENERIC_TIMEZONE` | Asia/Ho_Chi_Minh | Timezone setting |
| `WEBHOOK_URL` | http://localhost:5678/ | Webhook base URL |
| `N8N_BASIC_AUTH_USER` | admin | Admin username |
| `N8N_BASIC_AUTH_PASSWORD` | admin | Admin password |
| `LOG_LEVEL` | info | Logging level |

See `.env` file for all available options.

### Key Configurations for Production

```bash
# Change default credentials
N8N_BASIC_AUTH_USER=your_admin_user
N8N_BASIC_AUTH_PASSWORD=strong_password_here

# Enable SSL/TLS
N8N_PROTOCOL=https
N8N_SSL_KEY=/path/to/key.pem
N8N_SSL_CERT=/path/to/cert.pem

# Configure webhook URL
WEBHOOK_URL=https://your-domain.com/

# Database (optional, for scaling)
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=postgres
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=secure_password
```

---

## 📚 Workflows

### Example Workflow

Located at: `/workflows/example-workflow.json`

This is a basic workflow that:
1. Accepts HTTP requests
2. Transforms data
3. Returns output

### Create New Workflow

1. Open N8N UI at http://localhost:5678
2. Click "New" → "New Workflow"
3. Drag nodes from sidebar
4. Connect nodes together
5. Click "Save"

### Workflow Best Practices

- **Start Simple**: Build workflows incrementally
- **Test Each Node**: Verify output before connecting next node
- **Use Test Mode**: Always test before activating
- **Error Handling**: Add error handlers to critical nodes
- **Documentation**: Add descriptions to complex workflows

### Example Patterns

#### HTTP to Database

1. HTTP Request node (GET/POST)
2. Transform data (Set node)
3. Database node (Save/Update)
4. Email notification (optional)

#### Webhook Integration

```json
Webhook Node:
- Path: /webhook/mywebhook
- Full URL: http://localhost:5678/webhook/mywebhook
- Methods: GET, POST
- Response: Configure custom response
```

#### REST API Integration

```
HTTP Request Node:
- URL: https://api.example.com/endpoint
- Method: GET/POST/PUT/DELETE
- Headers: Add authentication tokens
- Body: JSON data (for POST/PUT)
```

#### Email Integration

```
Email Node:
- Provider: Gmail/Outlook/SMTP
- Configure credentials
- Template: HTML or Plain text
- Recipients: Dynamic or static
```

---

## 🛠️ Development & Testing

### Local Development Setup

Start N8N in development mode:

```bash
# Using docker-compose
docker-compose up -d n8n

# Check logs
docker-compose logs -f n8n
```

### Manual Testing Workflows

1. Create workflow
2. Click "Execute Workflow"
3. Check output in preview panel
4. Verify logs for errors

### Enable Debug Mode

Update `.env`:

```bash
LOG_LEVEL=debug
N8N_EXECUTION_MODE=debug
```

Restart container:

```bash
docker-compose restart n8n
docker-compose logs -f n8n
```

### Inspect Node Data

- Use "Set" node to examine data flow
- Use "Debug" output in preview panel
- Check "Execution History" in UI

### Version Control for Workflows

```bash
# Export workflow from UI as JSON
# Save to workflows/ folder
# Commit to git

git add workflows/
git commit -m "Add/update workflow: workflow-name"
git push origin main
```

### Backup Strategy

Create daily backups:

```bash
# Backup using Docker
docker cp n8n_local:/home/node/.n8n ./backup/n8n_$(date +%Y%m%d)

# Or using volume backup
docker run --rm -v n8n_data:/data -v $(pwd)/backup:/backup \
  busybox tar czf /backup/n8n_backup_$(date +%Y%m%d).tar.gz -C /data .
```

### Database Integration (Optional)

#### Using PostgreSQL

Update `docker-compose.yml`:

```yaml
services:
  postgres:
    image: postgres:14-alpine
    container_name: n8n_postgres
    environment:
      POSTGRES_DB: n8n
      POSTGRES_USER: n8n
      POSTGRES_PASSWORD: n8n_password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

Update `.env`:

```bash
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=postgres
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=n8n_password
```

### Workflow Optimization

1. **Minimize HTTP calls** - Batch requests if possible
2. **Use conditional logic** - Skip unnecessary nodes
3. **Implement delays** - Rate-limit API requests
4. **Cache data** - Reduce repeated API calls

---

## 🐛 Troubleshooting

### Container Issues

#### Container Won't Start

**Error**: `docker-compose up` fails

**Solutions**:

```bash
# 1. Check logs for errors
docker-compose logs n8n

# 2. Verify Docker is running
docker ps

# 3. Remove and restart
docker-compose down
docker-compose up -d

# 4. Check port availability
netstat -ano | findstr :5678  # Windows
lsof -i :5678                 # Mac/Linux

# 5. Force rebuild
docker-compose down -v
docker-compose up -d --build
```

#### Port 5678 Already in Use

**Error**: `bind: address already in use`

**Solutions**:

```bash
# Find process using port
netstat -ano | findstr :5678  # Windows
lsof -i :5678                 # Mac/Linux

# Kill the process
taskkill /PID <PID> /F        # Windows
kill -9 <PID>                 # Mac/Linux

# Or use different port in docker-compose.yml
# Change: "5678:5678" to "5679:5678"
```

#### Container Crashes After Starting

1. Check `.env` file syntax
2. Verify volume permissions
3. Check disk space: `docker system df`
4. Increase Docker memory limit
5. Review logs: `docker-compose logs --tail=100 n8n`

### Network & Connectivity

#### Can't Access http://localhost:5678

**Error**: Connection refused or timeout

**Solutions**:

```bash
# 1. Verify container is running
docker-compose ps

# 2. Check if service is ready (may take 30-60 seconds)
docker-compose logs n8n | grep "listening"

# 3. Test connectivity inside container
docker-compose exec n8n curl http://localhost:5678

# 4. Check firewall settings (Windows)
netsh advfirewall show allprofiles
```

#### Webhooks Not Working

**Error**: External webhooks can't reach N8N

**Solutions**:

```bash
# 1. Update WEBHOOK_URL in .env
WEBHOOK_URL=http://<your-external-ip>:5678/

# 2. Use ngrok for tunneling (development)
ngrok http 5678
# Update .env: WEBHOOK_URL=https://<ngrok-url>/

# 3. Check firewall/NAT settings
# 4. Test webhook manually
curl -X POST http://localhost:5678/webhook/test \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}'
```

### Authentication Issues

#### Login Fails with Default Credentials

**Error**: "Invalid credentials" with admin/admin

**Solutions**:

```bash
# 1. Check credentials in .env
cat .env | grep N8N_BASIC_AUTH

# 2. Reset to defaults and restart
# Edit .env:
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=admin

docker-compose restart n8n

# 3. Clear browser cache and cookies
# Then try again in incognito/private mode
```

#### JWT Token Issues

**Error**: "Unauthorized" or token validation failed

**Solutions**:

```bash
# In .env, ensure JWT is properly configured:
N8N_JWT_AUTH_ACTIVE=true

# Restart container
docker-compose restart n8n

# Test API with token
curl -H "Authorization: Bearer <token>" \
  http://localhost:5678/api/v1/workflows
```

### Data & Volume Issues

#### Data Not Persisting After Restart

**Error**: Workflows/data disappear after container restarts

**Solutions**:

```bash
# 1. Verify volume is mounted
docker inspect n8n_local | grep -A 10 "Mounts"

# 2. Check volume location
docker volume inspect n8n_data

# 3. Verify docker-compose.yml volumes section:
volumes:
  - n8n_data:/home/node/.n8n

# 4. Restart container
docker-compose down
docker-compose up -d
```

#### Volume Permission Denied

**Error**: `Error response from daemon: permission denied`

**Solutions**:

```bash
# 1. Fix permissions
docker-compose exec n8n chown -R node:node /home/node/.n8n

# 2. Or rebuild volume
docker-compose down -v
docker-compose up -d

# 3. Check SELinux (Linux)
getenforce
```

### Workflow Issues

#### Workflow Execution Fails

**Error**: Workflow stops or shows red X

**Solutions**:

1. **Check Node Configuration**:
   - Verify all required fields are filled
   - Test with simpler data

2. **Review Logs**:
   ```bash
   docker-compose logs -f n8n | grep -i error
   ```

3. **Test Individual Nodes**:
   - Select node → Execute Node
   - Check output preview

4. **Common Node Issues**:
   - HTTP Request: Check URL, headers, auth
   - Database: Verify connection string
   - Email: Confirm credentials and SMTP settings

#### API Node Returns 401/403

**Error**: Unauthorized access

**Solutions**:

```bash
# 1. Verify API credentials
# Check .env or node configuration

# 2. Test API manually
curl -X GET https://api.example.com/endpoint \
  -H "Authorization: Bearer <token>"

# 3. Check token expiration
# Regenerate if needed
```

#### Webhook Node Not Triggering

**Error**: Workflow doesn't execute when webhook is called

**Solutions**:

```bash
# 1. Get webhook URL from node
# Copy the full URL from Webhook node

# 2. Test webhook manually
curl -X POST http://localhost:5678/webhook/test \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}'

# 3. Check if workflow is active
# Toggle Active/Inactive switch
```

### Performance Issues

#### N8N Running Slow

**Error**: Workflows execute slowly

**Solutions**:

```bash
# 1. Check resource usage
docker stats n8n_local

# 2. Increase Docker memory allocation
# Docker Desktop Settings → Resources → Memory

# 3. Clear old execution history
# UI → Executions → Delete old records

# 4. Optimize workflows
# - Reduce API calls
# - Add delays between requests
# - Use batch operations
```

#### High Memory Usage

**Error**: Docker/N8N consuming too much memory

**Solutions**:

```bash
# 1. Increase memory limit
# In docker-compose.yml add:
services:
  n8n:
    ...
    mem_limit: 2g

# 2. Check for memory leaks
docker stats --no-stream n8n_local

# 3. Reduce execution retention
# In .env: N8N_EXECUTIONS_DATA_SAVE_ON_ERROR=none
```

### Database Issues

#### PostgreSQL Connection Failed

**Error**: Cannot connect to database

**Solutions**:

```bash
# 1. Verify PostgreSQL is running
docker-compose ps

# 2. Test connection
docker-compose exec postgres psql -U n8n -d n8n -c "\dt"

# 3. Check credentials in .env
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=n8n_password
DB_POSTGRESDB_HOST=postgres

# 4. Restart both services
docker-compose restart postgres n8n
```

### Debugging

#### Enable Debug Mode

```bash
# Update .env
LOG_LEVEL=debug
N8N_EXECUTION_MODE=debug

# Restart
docker-compose restart n8n

# View detailed logs
docker-compose logs -f n8n
```

#### Get Container Shell Access

```bash
# Access shell
docker-compose exec n8n sh

# Inside container
cd /home/node/.n8n
ls -la
cat config.json | head -50
```

#### Emergency Recovery

```bash
# Warning: This deletes all data!
docker-compose down -v
rm -rf data/
docker system prune -a

docker-compose up -d
```

---

## 🔒 Security Considerations

### For Production Use ⚠️

1. **Change default credentials**
   ```bash
   N8N_BASIC_AUTH_USER=your_admin_user
   N8N_BASIC_AUTH_PASSWORD=strong_secure_password
   ```

2. **Use strong passwords**
   - Minimum 12 characters
   - Mix of uppercase, lowercase, numbers, special characters

3. **Enable SSL/TLS**
   - Use reverse proxy (Nginx, Apache)
   - Get certificate from Let's Encrypt

4. **Use environment variables**
   - Never hardcode secrets in workflows
   - Store sensitive data in `.env`
   - Never commit `.env` to git

5. **Restrict network access**
   - Use firewall rules
   - Whitelist IP addresses
   - Limit webhook access

6. **Regular backups**
   - Daily automated backups
   - Test restore procedures
   - Store off-site

7. **Keep N8N updated**
   - Regularly update image
   - Check for security patches
   - Monitor releases

### Security Checklist

- [ ] `.env` is in `.gitignore`
- [ ] Changed default admin credentials
- [ ] Enabled HTTPS/SSL
- [ ] Set up regular backups
- [ ] Configured firewall rules
- [ ] Reviewed workflow permissions
- [ ] Rotated API keys/tokens
- [ ] Monitored access logs

---

## 💡 Tips & Best Practices

### Workflow Development

- Use `.env` for sensitive data (not committed to git)
- Export workflows regularly for backup
- Test workflows in test mode before activation
- Monitor execution logs for errors
- Use error handling nodes in complex workflows
- Document workflows with descriptions
- Use meaningful node names

### Docker Management

- Use `docker-compose ps` to check status
- Always backup before major changes
- Keep Docker and images updated
- Monitor disk space regularly
- Clean up old containers: `docker system prune`

### Network & Webhooks

- Test webhooks before deploying
- Use ngrok for local webhook testing
- Implement rate limiting in workflows
- Add request validation/authentication
- Monitor webhook execution logs

### Performance

- Batch API requests when possible
- Use delays for rate-limited APIs
- Cache frequently accessed data
- Minimize nested loops
- Optimize database queries

### Backup & Recovery

```bash
# Create backup
docker cp n8n_local:/home/node/.n8n ./backup/n8n_backup_$(date +%s)

# Then troubleshoot safely
docker-compose down
# ... make changes ...
docker-compose up -d

# Restore if needed
docker cp ./backup/n8n_backup_XXX/. n8n_local:/home/node/.n8n
docker-compose restart n8n
```

---

## 📌 Important Notes

- **Default Port**: 5678 (ensure it's not in use)
- **Data Persistence**: Uses Docker volume `n8n_data`
- **Backup**: Regularly backup `n8n_data` volume
- **Health Check**: Container includes health check (30s interval)
- **Network**: Uses isolated bridge network
- **Startup Time**: May take 30-60 seconds on first startup
- **Default Timezone**: Asia/Ho_Chi_Minh (configurable in `.env`)

---

## 📖 Useful Resources & Links

### Official Documentation

- [N8N Documentation](https://docs.n8n.io/)
- [N8N Workflow Examples](https://n8n.io/workflows/)
- [N8N Node Reference](https://docs.n8n.io/nodes/nodes-library.html)
- [N8N Expression Language](https://docs.n8n.io/code/expressions/overview.html)
- [N8N API](https://docs.n8n.io/api/overview.html)
- [N8N CLI Commands](https://docs.n8n.io/reference/cli-commands.html)

### Community & Support

- [N8N Community Forum](https://community.n8n.io/)
- [N8N Slack Channel](https://n8n.io/slack)
- [GitHub Issues](https://github.com/n8n-io/n8n/issues)

### Docker & Containers

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
- [Docker Hub - N8N Image](https://hub.docker.com/r/n8nio/n8n)

### Other Tools

- [ngrok - Expose local server](https://ngrok.com/)
- [Postman - API Testing](https://www.postman.com/)

---

## ✅ Verification Checklist

Before going to production:

- [ ] Docker is installed and running
- [ ] Port 5678 is available
- [ ] `.env` file exists and is correct
- [ ] `docker-compose.yml` is valid (`docker-compose config`)
- [ ] Volumes are properly mounted
- [ ] N8N container is healthy
- [ ] Can access http://localhost:5678
- [ ] Can login with credentials
- [ ] Workflows are visible and working
- [ ] Backups are configured
- [ ] Security settings are applied
- [ ] Firewall rules are configured

---

## 🤝 Contributing

Feel free to:
- Modify workflows for your needs
- Create custom nodes
- Contribute improvements
- Share workflow examples

## 📄 License

This project uses n8n under its Community License.
For commercial use, see [n8n Pricing](https://n8n.io/pricing/)

---

## 📞 Need Help?

1. Check **Troubleshooting** section above
2. Review [N8N Documentation](https://docs.n8n.io/)
3. Ask on [N8N Community](https://community.n8n.io/)
4. Open [GitHub Issue](https://github.com/n8n-io/n8n/issues)

---

**Last Updated**: April 2024  
**N8N Version**: Latest (check `docker-compose.yml`)  
**Status**: ✅ Production Ready
