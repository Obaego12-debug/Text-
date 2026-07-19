#!/bin/bash

# Heroku Deployment Script

echo "Installing Heroku CLI if not already installed..."

if ! command -v heroku &> /dev/null; then
    echo "Installing Heroku CLI..."
    curl https://cli-assets.heroku.com/install.sh | sh
fi

echo "👤 Logging into Heroku..."
heroku login

echo ""
read -p "Enter your Heroku app name: " app_name

if [ -z "$app_name" ]; then
    echo "❌ App name cannot be empty"
    exit 1
fi

echo ""
echo "Creating Heroku app: $app_name"
heroku create $app_name --region us || echo "⚠️  App may already exist"

echo ""
echo "🔐 Setting up environment variables..."
echo ""

# Add buildpack
heroku buildpacks:set heroku/nodejs -a $app_name

# Get user inputs
read -p "Enter MongoDB URI (or skip for now): " mongo_uri
if [ ! -z "$mongo_uri" ]; then
    heroku config:set MONGODB_URI="$mongo_uri" -a $app_name
fi

read -p "Enter JWT Secret (will generate one if empty): " jwt_secret
if [ -z "$jwt_secret" ]; then
    jwt_secret=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
    echo "Generated JWT Secret: $jwt_secret"
fi
heroku config:set JWT_SECRET="$jwt_secret" -a $app_name

read -p "Enter your domain (or skip): " domain
if [ ! -z "$domain" ]; then
    heroku config:set CORS_ORIGIN="https://$domain" -a $app_name
    heroku config:set API_URL="https://$domain" -a $app_name
fi

heroku config:set NODE_ENV="production" -a $app_name
heroku config:set LOG_LEVEL="info" -a $app_name

echo ""
echo "📦 Adding MongoDB addon (free tier)..."
heroku addons:create mongolab:sandbox -a $app_name || echo "⚠️  Add-on might already exist or need upgrade"

echo ""
echo "🚀 Deploying application..."
git push heroku main

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📍 Your app is available at: https://$app_name.herokuapp.com"
echo ""
echo "📊 View logs:"
echo "   heroku logs --tail -a $app_name"
echo ""
echo "🔧 Scale dynos:"
echo "   heroku ps:scale web=1 -a $app_name"
echo ""
echo "💻 Visit your app:"
echo "   heroku open -a $app_name"
echo ""
