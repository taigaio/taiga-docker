# Taiga Docker

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

As **EXTRA**: the default `launch-all.sh` script comes with [penpot](https://penpot.app), the open-source solution for design and prototyping. The default access for the penpot application is **http://locahost:9001**

It's developed by the same team behind Taiga. If you want to give it a try, you can go to [penpot's github](https://github.com/penpot/penpot) or the [help center](https://help.penpot.app/technical-guide/configuration/) to review its own configuration variables.

![Penpot screenshot](imgs/penpot.jpg)

And finally if you just want to launch Taiga standalone, you can use the `launch-taiga.sh` script instead of the `launch-all.sh`.

## Documentation

Currently, we have authored three main documentation hubs:

- **[API](https://docs.taiga.io/api.html)**: Our API documentation and reference for developing from Taiga API.
- **[Documentation](https://docs.taiga.io/)**: If you need to install Taiga on your own server, this is the place to find some guides.
- **[Taiga Resources](https://resources.taiga.io)**: This page is intended to be the support reference page for the users.

## Bug reports

If you **find a bug** in Taiga you can always report it:

- in [Taiga issues](https://tree.taiga.io/project/taiga/issues). **This is the preferred way**
- in [Github issues](https://github.com/kaleidos-ventures/taiga-docker/issues)
- send us a mail to support@taiga.io if is a bug related to [tree.taiga.io](https://tree.taiga.io)
- send us a mail to security@taiga.io if is a **security bug**

One of our fellow Taiga developers will search, find and hunt it as soon as possible.

Please, before reporting a bug, write down how can we reproduce it, your operating system, your browser and version, and if it's possible, a screenshot. Sometimes it takes less time to fix a bug if the developer knows how to find it.

## Community

If you **need help to setup Taiga**, want to **talk about some cool enhancemnt** or you have **some questions**, please write us to our [mailing list](https://groups.google.com/d/forum/taigaio).

If you want to be up to date about announcements of releases, important changes and so on, you can subscribe to our newsletter (you will find it by scrolling down at [https://taiga.io](https://www.taiga.io/)) and follow [@taigaio](https://twitter.com/taigaio) on Twitter.

## Contribute to Taiga

There are many different ways to contribute to Taiga's platform, from patches, to documentation and UI enhancements, just find the one that best fits with your skills. Check out our detailed [contribution guide](https://resources.taiga.io/extend/how-can-i-contribute/)

## Code of Conduct

Help us keep the Taiga Community open and inclusive. Please read and follow our [Code of Conduct](https://github.com/kaleidos-ventures/code-of-conduct/blob/main/CODE_OF_CONDUCT.md).

## License

Every code patch accepted in Taiga codebase is licensed under [MPL 2.0](LICENSE). You must be careful to not include any code that can not be licensed under this license.

Please read carefully [our license](LICENSE) and ask us if you have any questions as well as the [Contribution policy](https://github.com/kaleidos-ventures/taiga-docker/blob/main/CONTRIBUTING.md).

## Configuration and Customisation with Environment Variables

The docker-compose.yml has some environment variables of **configuration** with default values that we strongly recommend to change. Those variables are needed to run Taiga. Find them in the `docker-compose.yml` and `docker-compose-inits.yml`.

**Important** Don't forget to review environment variables in `docker-compose-inits.yml` as some of them are in both files.

Apart from this configuration, you can have some **customisation** in Taiga, and add features that by default are disabled. Find those variables in the **Customisation** section and add the corresponding environment variables whenever you want to enable them.

## Configuration

### Database configuration

These vars will be used to create the database for Taiga and connect to it.

**Important**: these vars should have the same values in `taiga-back` and `taiga-db`.

**Service: taiga-db**
```
POSTGRES_DB: taiga
POSTGRES_USER: taiga
POSTGRES_PASSWORD: taiga
```

**Service: taiga-back**
```
POSTGRES_DB: taiga
POSTGRES_USER: taiga
POSTGRES_PASSWORD: taiga
```

Additionally, you can also configure `POSTGRES_PORT` in `taiga-back`. Defaults to '5432'.

### Taiga Settings

**Service: taiga-back**

The default configuration assumes Taiga is being served in a **subdomain**:
```
TAIGA_SECRET_KEY: "taiga-back-secret-key"
TAIGA_SITES_SCHEME: "https"
TAIGA_SITES_DOMAIN: "taiga.mycompany.com"
TAIGA_SUBPATH: "/"
```

If Taiga is being served in a **subpath** instead of a subdomain, the configuration should be something like:
```
TAIGA_SECRET_KEY: "taiga-back-secret-key"
TAIGA_SITES_SCHEME: "https"
TAIGA_SITES_DOMAIN: "mycompany.com/taiga"
TAIGA_SUBPATH: "/taiga" # Mind just one slash
```

**Service: taiga-front**

The default configuration assumes Taiga is being served in a **subdomain**:
```
TAIGA_URL: "https://taiga.mycompany.com"
TAIGA_WEBSOCKETS_URL: "wss://taiga.mycompany.com"
TAIGA_SUBPATH: "/"
```

If Taiga is being served in a **subpath** instead of a subdomain, the configuration should be something like:
```
TAIGA_URL: "https://mycompany.com/taiga"
TAIGA_WEBSOCKETS_URL: "wss://mycompany.com/taiga"
TAIGA_SUBPATH: "/taiga/" # Mind both slashes

```
**Service: taiga-events**
```
TAIGA_SECRET_KEY: taiga-back-secret-key
```

**Service: taiga-protected**
```
SECRET_KEY: "taiga-back-secret-key"
```

`TAIGA_SECRET_KEY` is the secret key of Taiga. Should be the same as this var in `taiga-back`, `taiga-events` and `taiga-protected`.
`TAIGA_URL` is where this Taiga instance should be served. It should be the same as `TAIGA_SITES_SCHEME`://`TAIGA_SITES_DOMAIN`.
`TAIGA_WEBSOCKETS_URL` is used to connect to the events. This should have the same value as `TAIGA_SITES_DOMAIN`, ie: wss://taiga.mycompany.com.

### Session Settings

Taiga doesn't use session cookies in its API as it stateless. However, the Django Admin (`/admin/`) uses session cookie for authentication. By default, Taiga is configured to work behind HTTPS. If you're using HTTP (despite de strong recommendations against it), you'll need to configure the following environment variables so you can access the Admin:

**Service: taiga-back**
```
SESSION_COOKIE_SECURE: "False"
CSRF_COOKIE_SECURE: "False"
```

More info about those variables can be found [here](https://docs.djangoproject.com/en/3.1/ref/settings/#csrf-cookie-secure).

### Email Settings

By default, email is configured with the *console* backend, which means that the emails will be shown in the stdout. If you have an smtp service, uncomment the "Email settings" section in `docker-compose.yml` and configure those environment variables:

**Service: taiga-back**
```
EMAIL_BACKEND: "django.core.mail.backends.smtp.EmailBackend"
DEFAULT_FROM_EMAIL: "no-reply@mycompany.com"
EMAIL_HOST: "smtp.host.mycompany.com"
EMAIL_PORT: 587
EMAIL_HOST_USER: "user"
EMAIL_HOST_PASSWORD: "password"
EMAIL_USE_TLS: "True"
EMAIL_USE_SSL: "True"
```

Uncomment `EMAIL_BACKEND` variable, but do not modify unless you know what you're doing.

### Telemetry Settings

Telemetry anonymous data is collected in order to learn about the use of Taiga and improve the platform based on real scenarios.

**Service: taiga-back**
```
ENABLE_TELEMETRY: "True"
```

You can opt out by setting this variable to "False". By default is "True".

### Rabbit settings

These variables are used to leave messages in the rabbitmq services. These variables should be the same as in `taiga-back`, `taiga-async`, `taiga-events`, `taiga-async-rabbitmq` and `taiga-events-rabbitmq`.

**Service: taiga-back**
```
RABBITMQ_USER: taiga
RABBITMQ_PASS: taiga
```

 Two other variables `EVENTS_PUSH_BACKEND_URL` and `CELERY_BROKER_URL` can also be used to set the events push backend URL and celery broker URL.

```
EVENTS_PUSH_BACKEND_URL: "amqp://taiga:taiga@taiga-events-rabbitmq:5672/taiga"
CELERY_BROKER_URL: "amqp://taiga:taiga@taiga-async-rabbitmq:5672/taiga"
```

**Service: taiga-events**
```
RABBITMQ_USER: taiga
RABBITMQ_PASS: taiga
```

**Service: taiga-async-rabbitmq**
```
RABBITMQ_ERLANG_COOKIE: secret-erlang-cookie
RABBITMQ_DEFAULT_USER: taiga
RABBITMQ_DEFAULT_PASS: taiga
RABBITMQ_DEFAULT_VHOST: taiga
```

**Service: taiga-events-rabbitmq**
```
RABBITMQ_ERLANG_COOKIE: secret-erlang-cookie
RABBITMQ_DEFAULT_USER: taiga
RABBITMQ_DEFAULT_PASS: taiga
RABBITMQ_DEFAULT_VHOST: taiga
```

### Taiga protected settings

**Service: taiga-protected**
```
MAX_AGE: 360
```

The attachments will be accesible with a token during MAX_AGE (in seconds). After that, the token will expire.

## Customisation

All these features are disabled by default. You should add the corresponding environment variables with a proper value to enable them.

### Registration Settings

**Service: taiga-back**
```
PUBLIC_REGISTER_ENABLED: "True"
```

**Service: taiga-front**
```
PUBLIC_REGISTER_ENABLED: "true"
```

If you want to allow a public register, configure this variable to "True". By default is "False". Should be the same as this var in `taiga-front` and `taiga-back`.

**Important**: Taiga (in its default configuration) disables both Gitlab or Github oauth buttons whenever the public registration option hasn't been activated. To be able to use Github/ Gitlab login/registration, make sure you have public registration activated on your Taiga instance.

### Slack Settings

**Service: taiga-back**
```
ENABLE_SLACK: "True"
```

**Service: taiga-front**
```
ENABLE_SLACK: "true"
```

Enable Slack integration in your Taiga instance. By default is "False". Should have the same value as this variable in `taiga-front` and `taiga-back`.

### Github settings

Used for login with Github.
Get these in your profile https://github.com/settings/apps or in your organization profile https://github.com/organizations/{ORGANIZATION-SLUG}/settings/applications

**Note** `ENABLE_GITHUB_AUTH` and `GITHUB_CLIENT_ID` should have the same value in `taiga-back` and `taiga-front` services.

```
ENABLE_GITHUB_AUTH: "True"
GITHUB_API_CLIENT_ID: "github-api-client-id"
GITHUB_API_CLIENT_SECRET: "github-api-client-secret"
```

**Service: taiga-front**
```
ENABLE_GITHUB_AUTH: "true"
GITHUB_API_CLIENT_ID: "github-api-client-id"
```

### Gitlab settings

Used for login with GitLab.
Get these in your profile https://{YOUR-GITLAB}/profile/applications or in your organization profile https://{YOUR-GITLAB}/admin/applications

**Note** `ENABLE_GITLAB_AUTH`, `GITLAB_CLIENT_ID` and `GITLAB_URL` should have the same value in `taiga-back` and `taiga-front` services.

**Service: taiga-back**
```
ENABLE_GITLAB_AUTH: "True"
GITLAB_API_CLIENT_ID: "gitlab-api-client-id"
GITLAB_API_CLIENT_SECRET: "gitlab-api-client-secret"
GITLAB_URL: "gitlab-url"
```

**Service: taiga-front**
```
ENABLE_GITLAB_AUTH: "true"
GITLAB_CLIENT_ID: "gitlab-client-id"
GITLAB_URL: "gitlab-url"
```

### Importers

#### Github

**Service: taiga-back**
```
ENABLE_GITHUB_IMPORTER: "True"
GITHUB_IMPORTER_CLIENT_ID: "client-id-from-github"
GITHUB_IMPORTER_CLIENT_SECRET: "client-secret-from-github"
```

**Service: taiga-front**
```
ENABLE_GITHUB_IMPORTER: "true"
```

#### Jira

**Service: taiga-back**
```
ENABLE_JIRA_IMPORTER: "True"
JIRA_IMPORTER_CONSUMER_KEY: "consumer-key-from-jira"
JIRA_IMPORTER_CERT: "cert-from-jira"
JIRA_IMPORTER_PUB_CERT: "pub-cert-from-jira"
```

**Service: taiga-front**
```
ENABLE_JIRA_IMPORTER: "true"
```

#### Trello

**Service: taiga-back**
```
ENABLE_TRELLO_IMPORTER: "True"
TRELLO_IMPORTER_API_KEY: "api-key-from-trello"
TRELLO_IMPORTER_SECRET_KEY: "secret-key-from-trello"
```

**Service: taiga-front**
```
ENABLE_TRELLO_IMPORTER: "true"
```

## Storage

We have 3 named volumes configured: `taiga-static-data` for statics, `taiga-media-data` for medias and `taiga-db-data` for the database.

## Advanced customization (via configuration files)

For a advanced customization, you can use configuration files, mapped to specific directories inside the containers.

### taiga-back

Map a Python configuration file to `/taiga-back/settings/config.py`. You can use [this file](https://raw.githubusercontent.com/kaleidos-ventures/taiga-back/main/docker/config.py) as an example.

**Important**: if you use your own configuration file, don't forget to add contribs to `INSTALLED_APPS` (check the example `config.py`).

### taiga-front

Map a `conf.json`configuration file to `/usr/share/nginx/html/conf.json`. You can use [this file](https://raw.githubusercontent.com/kaleidos-ventures/taiga-front/main/docker/conf.json.template) as an example.
