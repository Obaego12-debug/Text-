# Local Development Setup Guide

## ✅ You've Completed These Steps

```bash
git clone https://github.com/Obaego12-debug/Text-.git
cd Text-
npm install
cp .env.example .env
```

Great! Now let's verify everything and start the application.

---

## 🔍 Step 1: Verify Installation

Check that npm packages installed correctly:

```bash
# Check Node version
node --version
# Should be v14.0.0 or higher

# Check npm version
npm --version
# Should be v6.0.0 or higher

# List installed packages
npm list --depth=0
```

---

## ⚙️ Step 2: Configure Environment Variables

Edit the `.env` file with your settings:

```bash
# On macOS/Linux
nano .env

# On Windows
notepad .env
```

**Minimum required settings:**

```env
PORT=3000
NODE_ENV=development
MONGODB_URI=mongodb://localhost:27017/text-app
JWT_SECRET=your-secret-key-change-this
LOG_LEVEL=info
```

**Optional settings (can skip for local dev):**

```env
REDIS_URL=redis://localhost:6379
SMTP_HOST=smtp.gmail.com
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-password
CORS_ORIGIN=http://localhost:3000
```

---

## 🗄️ Step 3: MongoDB Setup (Required for Production Data)

### Option A: Local MongoDB (Recommended for Development)

**macOS:**
```bash
# Install with Homebrew
brew install mongodb-community

# Start MongoDB
brew services start mongodb-community

# Verify it's running
mongosh
# Should connect successfully
```

**Windows:**
```bash
# Download from: https://www.mongodb.com/try/download/community
# Run installer and follow prompts
# MongoDB will start automatically
```

**Linux:**
```bash
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
```

**Verify MongoDB is running:**
```bash
mongosh
# You should see: test>
# Type: exit
```

### Option B: MongoDB Cloud (MongoDB Atlas)

1. Go to https://www.mongodb.com/cloud/atlas
2. Create free account
3. Create cluster
4. Get connection string
5. Update `.env` with `MONGODB_URI`:
```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/text-app
```

---

## 🔴 Step 4: Redis Setup (Optional for Local Dev)

### Option A: Local Redis

**macOS:**
```bash
brew install redis
brew services start redis
```

**Linux:**
```bash
sudo apt-get install -y redis-server
sudo systemctl start redis-server
```

**Verify Redis:**
```bash
redis-cli ping
# Should return: PONG
```

### Option B: Skip Redis (Works fine without it for development)

Just remove or comment out in `.env`:
```env
# REDIS_URL=redis://localhost:6379
```

---

## 🚀 Step 5: Start the Application

### Development Mode (with auto-reload)

```bash
npm run dev
```

You should see:
```
Chat application running on http://localhost:3000
Environment: development
MongoDB: mongodb://localhost:27017/text-app
```

### Production Mode

```bash
npm start
```

---

## 🌐 Step 6: Access Your Application

Open your browser and go to:

```
http://localhost:3000
```

You should see:
- Chat application UI
- Input fields for username and room ID
- Connect button

---

## 📝 Step 7: Test the Application

### Create Your First Account

1. **Enter username**: `testuser1`
2. **Enter room ID**: `general`
3. **Click "Join Room"**

### Open Second Browser Tab

1. Open new tab: `http://localhost:3000`
2. **Enter username**: `testuser2`
3. **Enter room ID**: `general` (same room)
4. **Click "Join Room"**

### Send Messages

1. In first tab, type a message and send
2. Message appears in second tab in real-time
3. Typing indicator shows when other user types

---

## ✅ Troubleshooting

### "Cannot connect to MongoDB"
```bash
# Check if MongoDB is running
mongosh

# If not running, start it:
# macOS: brew services start mongodb-community
# Linux: sudo systemctl start mongod
# Windows: Check Services app
```

### "Port 3000 already in use"
```bash
# Find what's using port 3000
lsof -i :3000

# Kill the process
kill -9 <PID>

# Or use different port
PORT=3001 npm run dev
```

### "npm install failed"
```bash
# Clear npm cache
npm cache clean --force

# Try install again
npm install

# If still fails, delete node_modules
rm -rf node_modules package-lock.json
npm install
```

### "Module not found errors"
```bash
# Make sure you're in correct directory
pwd  # Should show: .../Text-

# Reinstall dependencies
rm -rf node_modules
npm install
```

### Application won't start
```bash
# Check if all services are running:
# 1. MongoDB: mongosh
# 2. Node: npm run dev
# 3. Check .env file is configured

# View full error logs
npm run dev  # Look for error messages
```

---

## 📊 Common Commands

```bash
# Development
npm run dev                    # Start with auto-reload
npm run lint                   # Check code quality
npm test                       # Run tests
npm run seed                   # Seed database

# Production
npm start                      # Start app
npm run build                  # Build (if needed)

# Database
mongosh                        # Connect to MongoDB
redis-cli                      # Connect to Redis

# Docker
docker-compose up              # Start all services
docker-compose down            # Stop all services
```

---

## 🔐 Initial Setup Checklist

- [ ] Clone repository
- [ ] Run `npm install`
- [ ] Copy `.env.example` to `.env`
- [ ] Start MongoDB
- [ ] Configure `.env` if needed
- [ ] Run `npm run dev`
- [ ] Open `http://localhost:3000`
- [ ] Test with 2 browser tabs
- [ ] Send test messages

---

## 📚 Next Steps

Once local development is working:

1. **Read documentation**: See `README.md`
2. **Explore API**: See `API_DOCUMENTATION.md`
3. **Plan deployment**: See `DEPLOYMENT.md`
4. **Deploy to production**: Run `bash scripts/deploy-helper.sh`

---

## 💡 Tips

- Keep `npm run dev` running in one terminal
- Open another terminal for database commands
- Check browser console (F12) for client-side errors
- Check terminal output for server-side errors
- Use different rooms to test multiple conversations
- Try opening multiple browser windows with different usernames

---

## 🆘 Get Help

1. Check **troubleshooting** section above
2. Read **documentation files** in repository
3. Check **GitHub Issues** for common problems
4. Look at **application logs** for error details

---

## ✨ You're Ready!

Once you see messages appearing in real-time, you'll know everything is working correctly!

🎉 **Enjoy your local chat application!**

Next: Deploy globally using `bash scripts/deploy-helper.sh`
