#!/bin/bash

# Text Chat App - Quick Deployment Helper
# This script helps you deploy to different platforms

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║   Text Chat App - Deployment Helper                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Function to check requirements
check_requirements() {
    local command=$1
    if ! command -v $command &> /dev/null; then
        echo "❌ $command is not installed"
        return 1
    fi
    echo "✅ $command is installed"
    return 0
}

# Check environment setup
echo "📋 Checking requirements..."
echo ""

check_requirements "node" || exit 1
check_requirements "npm" || exit 1
check_requirements "git" || exit 1

echo ""
echo "✅ All requirements met!"
echo ""

# Menu
echo "🚀 Choose deployment platform:"
echo ""
echo "1) Heroku (Easiest - Free tier available)"
echo "2) DigitalOcean (Affordable - ~$5/month)"
echo "3) AWS (Scalable - Pay as you go)"
echo "4) Railway.app (Modern - Simple)"
echo "5) Docker Compose (Local/Self-hosted)"
echo "6) Setup Development Environment"
echo ""

read -p "Select option (1-6): " choice

case $choice in
    1)
        echo ""
        echo "📦 Heroku Deployment"
        echo "================================================"
        bash scripts/deploy-heroku.sh
        ;;
    2)
        echo ""
        echo "💧 DigitalOcean Deployment"
        echo "================================================"
        bash scripts/deploy-digitalocean.sh
        ;;
    3)
        echo ""
        echo "🚀 AWS Deployment"
        echo "================================================"
        bash scripts/deploy-aws.sh
        ;;
    4)
        echo ""
        echo "🚂 Railway.app Deployment"
        echo "================================================"
        bash scripts/deploy-railway.sh
        ;;
    5)
        echo ""
        echo "🐳 Docker Compose Setup"
        echo "================================================"
        docker-compose up -d
        echo "✅ Application is running!"
        echo "📍 Access at: http://localhost:3000"
        ;;
    6)
        echo ""
        echo "🔧 Development Environment Setup"
        echo "================================================"
        npm install
        cp .env.example .env
        echo "✅ Setup complete!"
        echo "Run: npm run dev"
        ;;
    *)
        echo "❌ Invalid option"
        exit 1
        ;;
esac

echo ""
echo "✨ Deployment helper completed!"
echo ""
