#!/bin/bash

# DigitalOcean Deployment Script

echo "🌊 DigitalOcean Deployment Guide"
echo "=================================="
echo ""

echo "Prerequisites:"
echo "1. DigitalOcean account (https://www.digitalocean.com)"
echo "2. SSH key setup"
echo "3. doctl CLI installed"
echo ""

read -p "Do you have doctl installed? (y/n): " has_doctl

if [ "$has_doctl" != "y" ]; then
    echo ""
    echo "Installing doctl..."
    cd ~
    wget https://github.com/digitalocean/doctl/releases/download/v1.94.0/doctl-1.94.0-linux-x64.tar.gz
    tar xf ~/doctl-1.94.0-linux-x64.tar.gz
    sudo mv ~/doctl /usr/local/bin
fi

echo ""
echo "🔐 Authenticating with DigitalOcean..."
doctl auth init

echo ""
read -p "Enter your app name: " app_name
read -p "Choose region (nyc1/sfo2/lon1/sgp1/fra1): " region

if [ -z "$region" ]; then
    region="nyc1"
fi

echo ""
echo "Creating droplet: $app_name in $region..."
echo ""

# Create droplet
doctl compute droplet create $app_name \
    --region $region \
    --image ubuntu-22-04-x64 \
    --size s-1vcpu-1gb \
    --enable-monitoring \
    --format ID,Name,PublicIPv4,Status \
    --no-header

echo ""
echo "⏳ Waiting for droplet to initialize..."
sleep 30

# Get droplet IP
droplet_ip=$(doctl compute droplet list --format Name,PublicIPv4 --no-header | grep $app_name | awk '{print $2}')

echo "✅ Droplet created: $droplet_ip"
echo ""

echo "🔧 Setting up the droplet..."
echo ""

cat > setup-droplet.sh << 'EOF'
#!/bin/bash

# Update system
apt-get update
apt-get upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs

# Install MongoDB
apt-get install -y mongodb-mongod

# Install Redis
apt-get install -y redis-server

# Install Nginx
apt-get install -y nginx

# Install PM2
npm install -g pm2

# Install Git
apt-get install -y git

# Create app directory
mkdir -p /var/www/text-app
cd /var/www/text-app

# Clone repository
git clone https://github.com/Obaego12-debug/Text-.git .

# Install dependencies
npm ci --only=production

# Copy .env.example to .env
cp .env.example .env

echo "✅ Droplet setup complete!"
echo "📍 Next steps:"
echo "1. SSH into: ssh root@$1"
echo "2. Configure .env: nano /var/www/text-app/.env"
echo "3. Start app: pm2 start src/server.js --name text-app"
echo "4. Setup Nginx reverse proxy"
echo "5. Enable SSL with Let's Encrypt"
EOF

chmod +x setup-droplet.sh

# Copy setup script to droplet
scp -o StrictHostKeyChecking=no setup-droplet.sh root@$droplet_ip:/root/

# Run setup on droplet
ssh -o StrictHostKeyChecking=no root@$droplet_ip 'bash /root/setup-droplet.sh'

echo ""
echo "✅ Droplet setup complete!"
echo ""
echo "📍 Your droplet IP: $droplet_ip"
echo ""
echo "🔐 SSH Access:"
echo "   ssh root@$droplet_ip"
echo ""
echo "📂 App Directory:"
echo "   /var/www/text-app"
echo ""
echo "🚀 Next Steps:"
echo "1. Connect: ssh root@$droplet_ip"
echo "2. Edit config: nano /var/www/text-app/.env"
echo "3. Start app: cd /var/www/text-app && npm start"
echo "4. Setup Nginx reverse proxy"
echo "5. Configure domain DNS pointing to $droplet_ip"
echo "6. Setup SSL with Let's Encrypt"
echo ""
