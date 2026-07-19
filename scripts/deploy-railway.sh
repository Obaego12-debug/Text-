#!/bin/bash

# Railway.app Deployment Script

echo "🚂 Railway.app Deployment"
echo "=========================="
echo ""

echo "Prerequisites:"
echo "1. Railway.app account (https://railway.app)"
echo "2. Railway CLI installed"
echo ""

# Install Railway CLI if needed
if ! command -v railway &> /dev/null; then
    echo "Installing Railway CLI..."
    npm install -g @railway/cli
fi

echo ""
echo "🔐 Logging into Railway..."
railway login

echo ""
echo "Creating new project..."
railway init

echo ""
echo "🚀 Deploying application..."

# Deploy
railway up

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📊 View your app:"
echo "   railway status"
echo ""
echo "📖 Logs:"
echo "   railway logs"
echo ""
echo "⚙️  Configure environment variables:"
echo "   railway variables"
echo ""
