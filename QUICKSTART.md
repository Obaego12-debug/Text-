# Quick Start Guide

## 🎯 3-Minute Quick Start

### Local Development

```bash
# 1. Clone and setup
git clone https://github.com/Obaego12-debug/Text-.git
cd Text-
npm install

# 2. Setup environment
cp .env.example .env

# 3. Start development server
npm run dev

# 4. Open browser
open http://localhost:3000
```

### Docker Development

```bash
# One command start
docker-compose up

# Access at http://localhost:3000
```

---

## 🚀 Deploy in 5 Minutes

### Easiest: Heroku

```bash
# Install Heroku CLI
brew install heroku

# Login and deploy
heroku login
bash scripts/deploy-heroku.sh

# Done! Your app is live
```

**Cost**: Free tier available, then ~$5-50/month

### Easy: Railway

```bash
# Install Railway CLI
npm install -g @railway/cli

# Deploy
bash scripts/deploy-railway.sh

# Done! Your app is live
```

**Cost**: ~$5/month (credit-based)

### Medium: DigitalOcean

```bash
# Install doctl CLI
# Deploy
bash scripts/deploy-digitalocean.sh

# Follow the prompts
```

**Cost**: ~$5-20/month

### Advanced: Docker Compose (Self-Hosted)

```bash
# On your VPS/Server
docker-compose -f docker-compose.prod.yml up -d

# Done!
```

**Cost**: Depends on your hosting ($2-50+/month)

---

## 📱 Access Your App

Once deployed:

```
Frontend: https://yourdomain.com
API Docs: https://yourdomain.com/api/docs
Health: https://yourdomain.com/api/health
WebSocket: wss://yourdomain.com/socket.io
```

---

## ⚙️ Configuration

Edit `.env` file with these key settings:

```env
# Server
PORT=3000
NODE_ENV=production

# Database
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/text-app

# Security
JWT_SECRET=your-super-secret-key

# Domain
CORS_ORIGIN=https://yourdomain.com
API_URL=https://yourdomain.com

# Email (optional)
SMTP_HOST=smtp.gmail.com
SMTP_USER=your@gmail.com
SMTP_PASS=app-password
```

---

## 🔍 Common Commands

```bash
# Development
npm run dev          # Start with auto-reload
npm run seed         # Seed database
npm test             # Run tests
npm run lint         # Check code quality

# Production
npm start            # Start app
npm run build        # Build (if needed)

# Docker
docker-compose up              # Start all services
docker-compose down            # Stop all services
docker-compose logs -f app     # View logs
docker-compose exec app bash   # SSH into container

# Database
mongosh              # Connect to MongoDB
redis-cli           # Connect to Redis
```

---

## 🆘 Troubleshooting

### "Connection refused"
```bash
# Check if MongoDB is running
mongosh
# Check if Redis is running
redis-cli ping
```

### "Port already in use"
```bash
# Kill process on port 3000
lsof -i :3000
kill -9 <PID>
```

### "Database connection failed"
```bash
# Update .env with correct MONGODB_URI
# Make sure MongoDB is running
# Check network connectivity
```

### "High memory usage"
```bash
# Check for memory leaks
node --inspect src/server.js
# Open chrome://inspect
```

---

## 📊 Monitoring Your App

### View Logs
```bash
# Docker
docker-compose logs -f app

# Heroku
heroku logs --tail

# DigitalOcean SSH
ssh root@your-ip
tail -f /var/log/text-app/app.log
```

### Check Health
```bash
curl https://yourdomain.com/api/health

# Response:
# {
#   "status": "OK",
#   "uptime": 12345.67,
#   "environment": "production"
# }
```

### View Statistics
```bash
curl https://yourdomain.com/api/stats \
  -H "Authorization: Bearer your-token"
```

---

## 🔐 Security Setup

### 1. Generate JWT Secret
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
# Copy output to JWT_SECRET in .env
```

### 2. Setup SSL/TLS
```bash
# Using Let's Encrypt (free)
sudo apt-get install certbot
sudo certbot certonly --standalone -d yourdomain.com

# Copy certificates to certs/ directory
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem certs/
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem certs/
```

### 3. Configure Firewall
```bash
# Allow HTTP/HTTPS only
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

---

## 📈 Scaling Your App

### Vertical Scaling (Bigger Server)
- Increase server resources (CPU/RAM)
- Upgrade database plan
- Already configured in Nginx

### Horizontal Scaling (Multiple Servers)
- Deploy multiple instances behind load balancer
- Use Redis for shared session storage
- Configure sticky sessions for Socket.io
- Setup database replication

---

## 📚 Next Steps

1. **Read Full Documentation**: See `README.md`
2. **API Reference**: See `API_DOCUMENTATION.md`
3. **Deployment Details**: See `DEPLOYMENT.md`
4. **Troubleshooting**: See `DEPLOYMENT_CHECKLIST.md`
5. **Security**: See `SECURITY.md`

---

## 🎉 You're Ready!

Your chat app is now:
- ✅ Deployed globally
- ✅ Secured with SSL/TLS
- ✅ Monitored and logged
- ✅ Ready for millions of users
- ✅ Backed up automatically

**Start chatting!** 🚀

---

## 💬 Need Help?

- 📧 Email: support@textapp.com
- 🐛 Issues: GitHub Issues
- 💻 Discussions: GitHub Discussions
- 📖 Docs: See documentation files

