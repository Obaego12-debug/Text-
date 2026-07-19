# Deployment Checklist

## Pre-Deployment

- [ ] Create `.env` file with all production values
- [ ] Generate strong JWT_SECRET (use: `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"`)
- [ ] Setup MongoDB (cloud or self-hosted)
- [ ] Setup Redis (optional but recommended)
- [ ] Domain name configured
- [ ] SSL certificates ready (or Let's Encrypt setup)
- [ ] Database backups configured
- [ ] Email credentials for SMTP configured
- [ ] Monitoring and alerting setup

## Deployment

### Option 1: Docker Compose (Recommended)
- [ ] Install Docker and Docker Compose
- [ ] Run: `docker-compose -f docker-compose.prod.yml up -d`
- [ ] Check logs: `docker-compose logs -f app`
- [ ] Setup SSL certificates in `./certs/` directory
- [ ] Configure domain DNS to point to server

### Option 2: Heroku
- [ ] Install Heroku CLI
- [ ] Run: `bash scripts/deploy-heroku.sh`
- [ ] Configure environment variables
- [ ] Add MongoDB addon
- [ ] Deploy: `git push heroku main`

### Option 3: DigitalOcean
- [ ] Install doctl CLI
- [ ] Run: `bash scripts/deploy-digitalocean.sh`
- [ ] SSH into droplet
- [ ] Configure `.env`
- [ ] Setup PM2 for process management
- [ ] Configure Nginx reverse proxy
- [ ] Setup SSL with Let's Encrypt

### Option 4: AWS
- [ ] Setup AWS account
- [ ] Install AWS CLI
- [ ] Run: `bash scripts/deploy-aws.sh`
- [ ] Create RDS MongoDB instance
- [ ] Create ElastiCache Redis cluster
- [ ] Create ECS cluster and service
- [ ] Setup Application Load Balancer
- [ ] Configure Route 53 DNS

### Option 5: Railway.app
- [ ] Create Railway account
- [ ] Install Railway CLI
- [ ] Run: `bash scripts/deploy-railway.sh`
- [ ] Configure environment variables
- [ ] Deploy

## Post-Deployment

### Security
- [ ] Enable HTTPS/SSL
- [ ] Configure firewall rules
- [ ] Setup WAF (if using AWS/Cloudflare)
- [ ] Enable rate limiting
- [ ] Review security headers
- [ ] Test XSS protection
- [ ] Test SQL injection prevention

### Monitoring
- [ ] Setup error tracking (Sentry)
- [ ] Configure logging (CloudWatch/Datadog)
- [ ] Setup performance monitoring
- [ ] Create dashboards
- [ ] Setup alerts for:
  - [ ] High error rate
  - [ ] High latency
  - [ ] High memory usage
  - [ ] Database connection failures
  - [ ] Disk space warnings

### Database
- [ ] Verify MongoDB connection
- [ ] Test Redis connection
- [ ] Setup automated backups
- [ ] Test backup restore
- [ ] Enable database encryption
- [ ] Configure connection pooling

### Performance
- [ ] Enable caching headers
- [ ] Setup CDN for static files
- [ ] Enable database query indexing
- [ ] Monitor response times
- [ ] Load test the application
- [ ] Optimize database queries

### Documentation
- [ ] Document deployment procedure
- [ ] Document environment variables
- [ ] Create runbook for common issues
- [ ] Document backup/restore procedures
- [ ] Document scaling procedures

### Backup & Recovery
- [ ] Setup automated daily backups
- [ ] Test backup restore process
- [ ] Document recovery procedures
- [ ] Store backups in multiple locations
- [ ] Document RTO and RPO

## Ongoing Maintenance

### Weekly
- [ ] Review error logs
- [ ] Monitor performance metrics
- [ ] Check disk space
- [ ] Verify backups completed

### Monthly
- [ ] Update dependencies: `npm update`
- [ ] Review security patches: `npm audit`
- [ ] Analyze user analytics
- [ ] Performance optimization review
- [ ] Database cleanup/optimization

### Quarterly
- [ ] Security audit
- [ ] Load testing
- [ ] Disaster recovery drill
- [ ] Architecture review
- [ ] Cost optimization review

## Scaling Considerations

### Horizontal Scaling
- [ ] Setup load balancer
- [ ] Configure sticky sessions for Socket.io
- [ ] Setup shared session storage (Redis)
- [ ] Configure multiple app instances
- [ ] Load test with scaling

### Vertical Scaling
- [ ] Monitor CPU usage
- [ ] Monitor memory usage
- [ ] Increase instance size if needed
- [ ] Monitor before/after impact

## Support & Help

- **Heroku Issues**: See `DEPLOYMENT.md`
- **Database Issues**: Check MongoDB logs
- **Performance**: Review Nginx access logs
- **Application Errors**: Check app logs
- **Documentation**: See `API_DOCUMENTATION.md`

---

✅ When all items are checked, your app is ready for production!
