# Taiga Docker

| :exclamation: | We recently announced Taiga plans for the future and they greatly affect how we manage this repository and the current Taiga 6 release. Check it [here](https://blog.taiga.io/announcing_taiganext.html).    |
|---------------|:----|

| :information_source: | If you're already using taiga-docker, follow this [migration guide](https://docs.taiga.io/upgrades-docker-migrate.html) to use the new `.env` based deployment. |
|---------------|:----|

**Note:** You can access the [older docker installation guide](https://docs.taiga.io/setup-production.old.html#setup-prod-with-docker-old) for documentation purposes, intended just for earlier versions of Taiga (prior to ver. 6.6.0)


## Getting Started

This section intends to explain how to get Taiga up and running in a simple two steps, using **docker** and **docker-compose**.

If you don't have docker installed, please follow installation instructions from docker.com: https://docs.docker.com/engine/install/

Additionally, it's necessary to have familiarity with Docker, docker-compose and Docker repositories.

**Note** branch `stable` should be used to deploy Taiga in production and `main` branch for development purposes.

### Start the application

```sh
$ ./launch-all.sh
```

After some instants, when the application is started you can proceed to create the superuser with the following script:

```sh
$ ./taiga-manage.sh createsuperuser
```

The `taiga-manage.sh` script lets launch manage.py commands on the
back instance:

```sh
$ ./taiga-manage.sh [COMMAND]
```

If you're testing it in your own machine, you can access the application in **http://localhost:9000**. If you're deploying in a server, you'll need to configure hosts and nginx as described later.

![Taiga screenshot](imgs/taiga.jpg)

As **EXTRA**: the default `launch-all.sh` script comes with [penpot](https://penpot.app), the open-source solution for design and prototyping. The default access for the penpot application is **http://localhost:9001**

It's developed by the same team behind Taiga. If you want to give it a try, you can go to [penpot's github](https://github.com/penpot/penpot) or the [help center](https://help.penpot.app/technical-guide/configuration/) to review its own configuration variables.

![Penpot screenshot](imgs/penpot.jpg)

And finally if you just want to launch Taiga standalone, you can use the `launch-taiga.sh` script instead of the `launch-all.sh`.

## Documentation

Currently, we have authored three main documentation hubs:

- **[API](https://docs.taiga.io/api.html)**: Our API documentation and reference for developing from Taiga API.
- **[Documentation](https://docs.taiga.io/)**: If you need to install Taiga on your own server, this is the place to find some guides.
- **[Taiga Community](https://community.taiga.io/)**: This page is intended to be the support reference page for the users.

## Bug reports

If you **find a bug** in Taiga you can always report it:

- in [Taiga issues](https://tree.taiga.io/project/taiga/issues). **This is the preferred way**
- in [Github issues](https://github.com/kaleidos-ventures/taiga-docker/issues)
- send us a mail to support@taiga.io if is a bug related to [tree.taiga.io](https://tree.taiga.io)
- send us a mail to security@taiga.io if is a **security bug**

One of our fellow Taiga developers will search, find and hunt it as soon as possible.

Please, before reporting a bug, write down how can we reproduce it, your operating system, your browser and version, and if it's possible, a screenshot. Sometimes it takes less time to fix a bug if the developer knows how to find it.

## Community

If you **need help to setup Taiga**, want to **talk about some cool enhancemnt** or you have **some questions**, please go to [Taiga community](https://community.taiga.io/).

If you want to be up to date about announcements of releases, important changes and so on, you can subscribe to our newsletter (you will find it by scrolling down at [https://taiga.io](https://www.taiga.io/)) and follow [@taigaio](https://twitter.com/taigaio) on Twitter.

## Contribute to Taiga

There are many different ways to contribute to Taiga's platform, from patches, to documentation and UI enhancements, just find the one that best fits with your skills. Check out our detailed [contribution guide](https://community.taiga.io/t/how-can-i-contribute/159#code-patches-enhacements-3).

## Code of Conduct

Help us keep the Taiga Community open and inclusive. Please read and follow our [Code of Conduct](https://github.com/kaleidos-ventures/code-of-conduct/blob/main/CODE_OF_CONDUCT.md).

## License

Every code patch accepted in Taiga codebase is licensed under [MPL 2.0](LICENSE). You must be careful to not include any code that can not be licensed under this license.

Please read carefully [our license](LICENSE) and ask us if you have any questions as well as the [Contribution policy](https://github.com/kaleidos-ventures/taiga-docker/blob/main/CONTRIBUTING.md).

## Configuration

We've exposed the **Basic configuration** settings in Taiga to an `.env` file. We strongly recommend you to change it, or at least review its content, to avoid using the default values.

Both `docker-compose.yml` and `docker-compose-inits.yml` will read from this file to populate their environment variables, so, initially you don't need to change them. Edit these files just in case you require to enable **Additional customization**, or an **Advanced configuration**.

Refer to these sections for further information.

## Basic Configuration

You will find basic **configuration variables** in the `.env` file. As stated before, we encourage you to edit these values, especially those affecting the security.

### Database settings

These vars are used to create the database for Taiga and connect to it.

```bash
POSTGRES_USER=taiga  # user to connect to PostgreSQL
POSTGRES_PASSWORD=taiga  # database user's password
```

### URLs settings

These vars set where your Taiga instance should be served, and the security protocols to use in the communication layer.

```bash
TAIGA_SCHEME=http  # serve Taiga using "http" or "https" (secured) connection
TAIGA_DOMAIN=localhost:9000  # Taiga's base URL
SUBPATH=""  # it'll be appended to the TAIGA_DOMAIN (use either "" or a "/subpath")
WEBSOCKETS_SCHEME=ws  # events connection protocol (use either "ws" or "wss")
```

The default configuration assumes Taiga is being served in a **subdomain**. For example:

```bash
TAIGA_SCHEME=https
TAIGA_DOMAIN=taiga.mycompany.com
SUBPATH=""
WEBSOCKETS_SCHEME=wss
```

If Taiga is being served in a **subpath**, instead of a subdomain, the configuration should be something like this:

```bash
TAIGA_SCHEME=https
TAIGA_DOMAIN=mycompany.com
SUBPATH="/taiga"
WEBSOCKETS_SCHEME=wss
```

### Secret Key settings

This variable allows you to set the secret key in Taiga, used in the cryptographic signing.

```bash
SECRET_KEY="taiga-secret-key"  # Please, change it to an unpredictable value!
```

### Email Settings

By default, emails will be printed in the standard output (`EMAIL_BACKEND=console`). If you have your own SMTP service, change it to `EMAIL_BACKEND=smtp` and configure the rest of these variables with the values supplied by your SMTP provider:

```bash
EMAIL_BACKEND=console  # use an SMTP server or display the emails in the console (either "smtp" or "console")
EMAIL_HOST=smtp.host.example.com  # SMTP server address
EMAIL_PORT=587   # default SMTP port
EMAIL_HOST_USER=user  # user to connect the SMTP server
EMAIL_HOST_PASSWORD=password  # SMTP user's password
EMAIL_DEFAULT_FROM=changeme@example.com  # email address for the automated emails

# EMAIL_USE_TLS/EMAIL_USE_SSL are mutually exclusive (only set one of those to True)
EMAIL_USE_TLS=True  # use TLS (secure) connection with the SMTP server
EMAIL_USE_SSL=False  # use implicit TLS (secure) connection with the SMTP server
```

### Queue manager settings

These variables are used to leave messages in the rabbitmq services.

```bash
RABBITMQ_USER=taiga  # user to connect to RabbitMQ
RABBITMQ_PASS=taiga  # RabbitMQ user's password
RABBITMQ_VHOST=taiga  # RabbitMQ container name
RABBITMQ_ERLANG_COOKIE=secret-erlang-cookie  # unique value shared by any connected instance of RabbitMQ
```

### Attachments settings

You can configure how long the attachments will be accessible by changing the token expiration timer. After that amount of seconds the token will expire, but you can always get a new attachment url with an active token.

```bash
ATTACHMENTS_MAX_AGE=360  # token expiration date (in seconds)
```

### Telemetry Settings

Telemetry anonymous data is collected in order to learn about the use of Taiga and improve the platform based on real scenarios. You may want to enable this to help us shape future Taiga.

```bash
ENABLE_TELEMETRY=True
```

You can opt out by setting this variable to False. By default, it's True.

## Additional customization

All these customization options are by default disabled and require you to edit `docker-compose.yml`.

You should add the corresponding environment variables in the proper services with a valid value in order to enable them. Please, do not modify it unless you know what you’re doing.

### Session cookies in Django Admin

Taiga doesn't use session cookies in its API as it stateless. However, the Django Admin (`/admin/`) uses session cookie for authentication. By default, Taiga is configured to work behind HTTPS. If you're using HTTP (despite the strong recommendations against it), you'll need to configure the following environment variables so you can access the Admin:

Service: `taiga-back`
``` bash
SESSION_COOKIE_SECURE: "False"
CSRF_COOKIE_SECURE: "False"
```

More info about those variables can be found [here](https://docs.djangoproject.com/en/3.1/ref/settings/#csrf-cookie-secure).

### Public registration

If you want to allow a public register, configure this variable to "True". By default it's "False". The value should be the same in `taiga-front` and `taiga-back`.

Service: `taiga-back`

```bash
PUBLIC_REGISTER_ENABLED: "True"
```

Service: `taiga-front`
```bash
PUBLIC_REGISTER_ENABLED: "true"
```

**Important**: Taiga (in its default configuration) disables both Gitlab or Github oauth buttons whenever the public registration option hasn't been activated. To be able to use Github/ Gitlab login/registration, make sure you have public registration activated on your Taiga instance.

### GitHub OAuth login

Used for login with Github.

Follow the [documentation](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app) in Github, when save application Github displays the ID and Secret.

Set variables in docker-compose.yml:

**Note** `ENABLE_GITHUB_AUTH` and `GITHUB_API_CLIENT_ID / GITHUB_CLIENT_ID` should have the same value in `taiga-back` and `taiga-front` services.

Service: `taiga-back`
```bash
ENABLE_GITHUB_AUTH: "True"
GITHUB_API_CLIENT_ID: "github-client-id"
GITHUB_API_CLIENT_SECRET: "github-client-secret"
PUBLIC_REGISTER_ENABLED: "True"
```

Service: `taiga-front`
```bash
ENABLE_GITHUB_AUTH: "true"
GITHUB_CLIENT_ID: "github-client-id"
PUBLIC_REGISTER_ENABLED: "true"
````

### Gitlab OAuth login

Used for login with GitLab.

Follow the [documentation](https://docs.gitlab.com/ee/integration/oauth_provider.html) in Gitlab, when save application GitLab displays the ID and Secret.

Set variables in docker-compose.yml:

**Note** `ENABLE_GITLAB_AUTH`, `GITLAB_API_CLIENT_ID / GITLAB_CLIENT_ID` and `GITLAB_URL` should have the same value in `taiga-back` and `taiga-front` services.

Service: `taiga-back`
```bash
ENABLE_GITLAB_AUTH: "True"
GITLAB_API_CLIENT_ID: "gitlab-client-id"
GITLAB_API_CLIENT_SECRET: "gitlab-client-secret"
GITLAB_URL: "gitlab-url"
PUBLIC_REGISTER_ENABLED: "True"
```

Service: `taiga-front`
```bash
ENABLE_GITLAB_AUTH: "true"
GITLAB_CLIENT_ID: "gitlab-client-id"
GITLAB_URL: "gitlab-url"
PUBLIC_REGISTER_ENABLED: "true"
```

### Slack integration

Enable Slack integration in your Taiga instance. By default, it's "False". Should have the same value as this variable in `taiga-front` and `taiga-back`.

Service: `taiga-back`
```bash
ENABLE_SLACK: "True"
```

Service: `taiga-front`

```
ENABLE_SLACK: "true"
```

### GitHub importer

Service: `taiga-back`
```bash
ENABLE_GITHUB_IMPORTER: "True"
GITHUB_IMPORTER_CLIENT_ID: "client-id-from-github"
GITHUB_IMPORTER_CLIENT_SECRET: "client-secret-from-github"
```

Service: `taiga-front`
```bash
ENABLE_GITHUB_IMPORTER: "true"
```

### Jira Importer

Service: `taiga-back`
```bash
ENABLE_JIRA_IMPORTER: "True"
JIRA_IMPORTER_CONSUMER_KEY: "consumer-key-from-jira"
JIRA_IMPORTER_CERT: "cert-from-jira"
JIRA_IMPORTER_PUB_CERT: "pub-cert-from-jira"
```

Service: `taiga-front`
```bash
ENABLE_JIRA_IMPORTER: "true"
```

### Trello importer

Service: `taiga-back`
```bash
ENABLE_TRELLO_IMPORTER: "True"
TRELLO_IMPORTER_API_KEY: "api-key-from-trello"
TRELLO_IMPORTER_SECRET_KEY: "secret-key-from-trello"
```

Service: `taiga-front`
```bash
ENABLE_TRELLO_IMPORTER: "true"
```

## Advanced configuration

The advanced configuration **will ignore** the environment variables in `docker-compose.yml` or `docker-compose-inits.yml`. Skip this section if you're using env vars.

It requires you to map the configuration files of `taiga-back` and `taiga-front` services to local files in order to unlock further configuration options.

**Map a `config.py` file**

From [taiga-back](https://github.com/kaleidos-ventures/taiga-back) download the file `settings/config.py.prod.example` and rename it:

```bash
mv settings/config.py.prod.example settings/config.py
```

Edit `config.py` with your own configuration:

- Taiga secret key: **it's important** to change it. It must have the same value as the secret key in `taiga-events` and `taiga-protected`
- Taiga urls: configure where Taiga would be served using `TAIGA_URL`, `SITES` and `FORCE_SCRIPT_NAME` (see examples below)
- Connection to PostgreSQL; check `DATABASES` section in the file
- Connection to RabbitMQ for `taiga-events`; check "EVENTS" section in the file
- Connection to RabbitMQ for `taiga-async`; check "TAIGA ASYNC" section in the file
- Credentials for email; check "EMAIL" section in the file
- Enable/disable anonymous telemetry; check "TELEMETRY" section in the file

Example to configure Taiga in **subdomain**:
```python
TAIGA_SITES_SCHEME = "https"
TAIGA_SITES_DOMAIN = "taiga.mycompany.com"
FORCE_SCRIPT_NAME = ""
```

Example to configure Taiga in **subpath**:
```python
TAIGA_SITES_SCHEME = "https"
TAIGA_SITES_DOMAIN = "taiga.mycompany.com"
FORCE_SCRIPT_NAME = "/taiga"
```

Check as well the rest of the configuration if you need to enable some advanced features.

Map the file into `/taiga-back/settings/config.py`. Have in mind that you have to map it both in `docker-compose.yml` and `docker-compose-inits.yml`. You can check the `x-volumes` section in docker-compose.yml with an example.

**Map a `conf.json` file**

From [taiga-front](https://github.com/kaleidos-ventures/taiga-front) download the file `dist/conf.example.json` and rename it:

```bash
mv dist/conf.example.json dist/conf.json
```

Edit it with your own configuration:

- Taiga urls: configure where Taiga would be served using `api`, `eventsUrl` and `baseHref` (see examples below)

Example of `conf.json` to serve Taiga in a **subdomain**:
```json
{
    "api": "https://taiga.mycompany.com/api/v1/",
    "eventsUrl": "wss://taiga.mycompany.com/events",
    "baseHref": "/",
```

Example of `conf.json` to serve Taiga in **subpath**:
```json
{
    "api": "https://mycompany.com/taiga/api/v1/",
    "eventsUrl": "wss://mycompany.com/taiga/events",
    "baseHref": "/taiga/",
```

Check as well the rest of the configuration if you need to enable some advanced features.

Map the file into `/taiga-front/dist/config.py`.

## Configure an admin user

```bash
$ docker-compose up -d

$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-manage createsuperuser
```

## Up and running

Once everything has been installed, launch all the services and check the result:

```bash
$ docker-compose up -d
```

## Configure the proxy

Your host configuration needs to make a proxy to `http://localhost:9000`.

If Taiga is being served in a **subdomain**:
```
  server {
      server_name taiga.mycompany.com;
      
      location / {
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_redirect off;
        proxy_pass http://localhost:9000/;
      }
      
      # Events
      location /events {
        proxy_pass http://localhost:9000/events;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_connect_timeout 7d;
        proxy_send_timeout 7d;
        proxy_read_timeout 7d;
      }
  
      # TLS: Configure your TLS following the best practices inside your company
      # Logs and other configurations
  }
```

If Taiga is being served in a **subpath** instead of a subdomain, the configuration should be something like:
```
server {
  server_name mycompany.com;
  
  location /taiga/ {
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Scheme $scheme;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_redirect off;
    proxy_pass http://localhost:9000/;
  }
  
  # Events
  location /taiga/events {
    proxy_pass http://localhost:9000/events;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_connect_timeout 7d;
    proxy_send_timeout 7d;
    proxy_read_timeout 7d;
  }
  
  # TLS: Configure your TLS following the best practices inside your company
  # Logs and other configurations
}
```

## Change between subpath and subdomain

If you're changing Taiga configuration from default subdomain (https://taiga.mycompany.com) to subpath (http://mycompany.com/subpath) or vice versa, on top of adjusting the configuration as said above, you should consider changing the TAIGA_SECRET_KEY so the refresh works properly for the end user.
