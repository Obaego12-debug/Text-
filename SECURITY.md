# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please email security@textapp.com instead of using the issue tracker.

Please include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

## Security Best Practices

### For Users
1. Use strong, unique passwords
2. Enable two-factor authentication (coming soon)
3. Keep browser and software updated
4. Don't share your authentication tokens
5. Use HTTPS only connections

### For Developers
1. Keep dependencies updated: `npm audit`
2. Review security headers in Helmet.js
3. Validate all user input
4. Use prepared statements for database queries
5. Implement proper error handling
6. Use environment variables for secrets
7. Regular security audits
8. Keep Node.js and npm updated

## Security Features

- HTTPS/TLS encryption
- JWT token authentication
- Password hashing with bcrypt
- Rate limiting
- CORS configuration
- Security headers (Helmet.js)
- Input validation
- XSS protection
- CSRF tokens (coming soon)
- Two-factor authentication (coming soon)

## Compliance

This application follows OWASP Top 10 guidelines and best practices for web security.
