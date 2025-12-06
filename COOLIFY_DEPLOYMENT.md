# Deploying Taiga on Coolify

This guide explains how to deploy Taiga on Coolify using docker-compose.

## Prerequisites

- A Coolify instance (self-hosted or cloud)
- A domain or subdomain for your Taiga instance
- Access to your DNS settings

## Quick Start

### 1. Prepare the Environment File

Copy the example environment file and customize it:

```bash
cp .env.example .env
```

### 2. Configure Environment Variables

Edit the `.env` file and update the following **required** variables:

```bash
# Set your domain (assigned by Coolify or your custom domain)
TAIGA_DOMAIN=taiga.yourdomain.com

# Set to https for production (required for Coolify)
TAIGA_SCHEME=https
WEBSOCKETS_SCHEME=wss

# Generate a secure secret key (IMPORTANT!)
SECRET_KEY=$(openssl rand -hex 32)

# Set secure database password
POSTGRES_PASSWORD=$(openssl rand -base64 32)

# Set secure RabbitMQ password
RABBITMQ_PASS=$(openssl rand -base64 32)

# Set secure RabbitMQ Erlang cookie
RABBITMQ_ERLANG_COOKIE=$(openssl rand -hex 32)
```

### 3. Optional: Configure Email (SMTP)

If you want to send emails (recommended for production):

```bash
EMAIL_BACKEND=smtp
EMAIL_HOST=smtp.example.com
EMAIL_PORT=587
EMAIL_HOST_USER=your-smtp-user
EMAIL_HOST_PASSWORD=your-smtp-password
EMAIL_DEFAULT_FROM=taiga@yourdomain.com
EMAIL_USE_TLS=True
EMAIL_USE_SSL=False
```

### 4. Deploy on Coolify

1. **Create a new Resource** in Coolify
2. Choose **Docker Compose** as the resource type
3. **Connect your Git repository** or upload the docker-compose.yml
4. **Set Environment Variables** in Coolify:
   - Go to the Environment Variables section
   - Add all variables from your `.env` file
   - Coolify will automatically handle the `PORT` variable
5. **Configure Domain**:
   - In Coolify, set up your domain (e.g., `taiga.yourdomain.com`)
   - Make sure to point your DNS A record to your Coolify server IP
6. **Deploy** the application

### 5. Create Super User

After the first deployment, you need to create an admin user:

1. In Coolify, open the **Terminal** for the `taiga-back` service
2. Run the following command:
   ```bash
   python manage.py createsuperuser
   ```
3. Follow the prompts to create your admin user

## Important Notes

### Domain Configuration

- **Do NOT include the port** in `TAIGA_DOMAIN` when deploying on Coolify
  - ✅ Correct: `TAIGA_DOMAIN=taiga.yourdomain.com`
  - ❌ Wrong: `TAIGA_DOMAIN=taiga.yourdomain.com:9000`

- Coolify handles SSL/TLS automatically, so always use:
  - `TAIGA_SCHEME=https`
  - `WEBSOCKETS_SCHEME=wss`

### Port Configuration

- The `PORT` variable in `.env` defaults to `9000`
- Coolify will automatically override this if needed
- The docker-compose.yml uses `${PORT:-9000}:80` for flexibility

### Security Best Practices

1. **Never use default passwords in production!**
2. Generate random values for:
   - `SECRET_KEY`
   - `POSTGRES_PASSWORD`
   - `RABBITMQ_PASS`
   - `RABBITMQ_ERLANG_COOKIE`
3. Use strong, unique passwords for each variable
4. Keep your `.env` file secure and never commit it to version control

### Data Persistence

All data is stored in Docker volumes:
- `taiga-db-data`: PostgreSQL database
- `taiga-static-data`: Static files
- `taiga-media-data`: User-uploaded media files
- `taiga-async-rabbitmq-data`: RabbitMQ async data
- `taiga-events-rabbitmq-data`: RabbitMQ events data

These volumes will persist across container restarts and redeployments.

## Troubleshooting

### Application won't start

1. Check Coolify logs for errors
2. Verify all required environment variables are set
3. Ensure `TAIGA_DOMAIN` matches your Coolify domain configuration
4. Check that `TAIGA_SCHEME` is set to `https`

### Can't access the application

1. Verify your DNS is pointing to the correct IP
2. Check that Coolify's SSL certificate is properly configured
3. Ensure the `taiga-gateway` service is running

### Email notifications not working

1. Verify `EMAIL_BACKEND=smtp` (not `console`)
2. Check SMTP credentials and settings
3. Test SMTP connection from your server
4. Check `taiga-back` logs for email errors

### WebSockets not working (real-time events)

1. Ensure `WEBSOCKETS_SCHEME=wss` (not `ws`)
2. Verify `TAIGA_DOMAIN` is correct
3. Check that `taiga-events` service is running
4. Check browser console for WebSocket connection errors

## Advanced Configuration

For advanced configuration options (OAuth, importers, etc.), refer to the main [README.md](README.md) file.

## Support

- [Taiga Documentation](https://docs.taiga.io/)
- [Taiga Community](https://community.taiga.io/)
- [GitHub Issues](https://github.com/taigaio/taiga-docker/issues)
- [Coolify Documentation](https://coolify.io/docs)
