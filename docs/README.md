# Introduction

## About

A full NodeJS development environment for Docker.

Includes pre-packaged Docker Images, all pre-configured to provide a wonderful Node development environment.

This project is based on an awesome [Laradock](https://github.com/laradock/laradock) ([contributors](https://github.com/laradock/laradock/graphs/contributors))

## Quick Overview

Let's see how easy it is to start a simple `nginx` and `nodejs` project.

1 - Create a new node.js project, use `yarn init` to create a `package.json` and `yarn add express` to install express.

```
yarn init
yarn add express
```

Create a simple `server.js` file in a same directory afterwards:

```
var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});

app.listen(9000, function () {
  console.log('Example app listening on port 9000!');
});
```

And add a `start` script to `package.json`:

```
"scripts": {
  "start": "node server"
}
```

2 - Clone nodedock in your project directory:

```
git submodule add https://github.com/nodedock/nodedock.git
```

3 - Rename `env-example` to `.env` in nodedock directory:

```
cp nodedock/env-example nodedock/.env
```

4 - Set `NODE_SERVICES` variable within `.env` to a list of services you'd want to run:

```
NODEDOCK_SERVICES=nginx node workspace
```

Note that `workspace` is a container which you'll be ssh'ing into and running watch processes in, so you'd want to set it up here!

5 - Run `./nodedock/start.sh`

6 - Open your browser and visit `http://localhost/`

That's it! Enjoy =)

## Features

* Easy switch between Node versions: 8.x, 9.x, 10.x
* Choose your favorite database engine: MySQL or Postgres
* Run your own combination of software: Memcached, Redis, Beanstalkd
* Every software runs on a separate container: node, nginx
* Easy to customize any container, with simple edit to the Dockerfile.
* All Images extends from an official base Image. (Trusted base Images).
* Pre-configured NGINX to host any code at your root directory.
* Can use Nodedock per project, or single Nodedock for all projects.
* Easy to install/remove software’s in Containers using environment variables.
* Clean and well structured Dockerfiles (Dockerfile).
* Latest version of the Docker Compose file (docker-compose).
* Everything is visible and editable.
* Fast Images Builds.
* More to come every week..

## Supported Software (Images)

In adhering to the separation of concerns principle as promoted by Docker, Nodedock runs each software on its own Container. You can turn On/Off as many instances of as any container without worrying about the configurations, everything works like a charm.

* **Database Engines**: MySQL - MongoDB - PostgreSQL - Postgres-PostGIS.
* **Database Management**: PhpMyAdmin - Adminer - PgAdmin
* **Cache Engines**: Redis - Memcached
* **Web Servers**: NGINX
* **Message Queueing**: Beanstalkd - RabbitMQ
* **Queueing Management**: Beanstalkd Console - RabbitMQ Console
* **Other Tools**: ElasticSearch - Mailhog - MailDev

Nodedock introduces the **Workspace** Image, as a development environment. It contains a rich set of helpful tools, all pre-configured to work and integrate with almost any combination of Containers and tools you may choose.

Workspace Image Tools NPM - Yarn - Git - Node - Gulp - SQLite - Vim

You can choose, which tools to install in your workspace container and other containers, from the .env file.

> If you modify `docker-compose.yml`, `.env` or any `Dockerfile` file, you must re-build your containers, to see those effects in the running instance.

If you can’t find your Software in the list, build it yourself and submit it. Contributions are welcomed :)

## What is Docker?

[Docker](https://www.docker.com/) is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.

<br />

# Getting Started

## Requirements

- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/products/docker/) `>= 18.06`

## Installation

Choose the setup the best suits your needs.

- [A.1) Already have a Node project](#A1)
- [A.2) Don't have a Node project yet](#A2)

<a name="A1"></a>
### A.1) Already have a Node project:

1 - Clone Nodedock on your project root directory:

```
git submodule add https://github.com/Nodedock/nodedock.git
```

Note: If you are not using Git yet for your project, you can use `git clone` instead of `git submodule `.

*To keep track of your Nodedock changes, between your projects and also keep Nodedock updated [check these docs](/documentation/#keep-track-of-your-nodedock-changes)*

Your folder structure should look like this:

```
+ project-a
  + nodedock-a
+ project-b
  + nodedock-b
```

*(It's important to rename the nodedock folders to unique name in each project, if you want to run nodedock per project).*

> **Now jump to the [Usage](#Usage) section.**

<a name="A2"></a>
### A.2) Don't have a Node project yet:

1 - Clone this repository anywhere on your machine:

```
git clone https://github.com/nodedock/nodedock.git
```

Your folder structure should look like this:

```
+ nodedock
+ project-z
```

2 - Edit your web server sites configuration.

We'll need to do step 1 of the [Usage](#Usage) section now to make this happen.

```
cp env-example .env
```

At the top, change the `APPLICATION` variable to your project path.

```
APPLICATION=../project-z/
```

Make sure to replace `project-z` with your project folder name.

> **Now jump to the [Usage](#Usage) section.**


<a name="Usage"></a>
## Usage

**Read Before starting:**

If you are using **Docker Toolbox** (VM), do one of the following:

- Upgrade to Docker [Native](https://www.docker.com/products/docker) for Mac/Windows (Recommended). Check out [Upgrading Nodedock](/documentation/#upgrading-nodedock)

We recommend using a Docker version which is newer than 1.13.

>**Warning:** If you used an older version of Nodedock it's highly recommended to rebuild the containers you need to use [see how you rebuild a container](#Build-Re-build-Containers) in order to prevent as much errors as possible.

1 - Enter the nodedock folder and copy `env-example` to `.env`

```shell
cp env-example .env
```

You can edit the `.env` file to choose which software you want to be installed in your environment. You can always refer to the `docker-compose.yml` file to see how those variables have been used.

Depending on the host's operating system you may need to change the value given to `COMPOSE_FILE`. When you are running Nodedock on Mac OS the correct file separator to use is `:`. When running Nodedock from a Windows environment multiple files must be separated with `;`.

By default the containers that will be created have the current directory name as suffix (e.g. `nodedock_workspace_1`). This can cause mixture of data inside the container volumes if you use nodedock in multiple projects. In this case, either read the guide for [multiple projects](#B) or change the variable `COMPOSE_PROJECT_NAME` to something unique like your project name.

2 - Build the environment and run it using `docker-compose`

In this example we'll see how to run NGINX (web server) and MySQL (database engine) to host a Node Web Scripts:

```
docker-compose up -d nginx mysql
```

**Note**: All the web server containers `nginx`, `apache` ..etc depends on `php-fpm`, which means if you run any of them, they will automatically launch the `php-fpm` container for you, so no need to explicitly specify it in the `up` command. If you have to do so, you may need to run them as follows: `docker-compose up -d nginx php-fpm mysql`.

You can select your own combination of containers from [this list](http://nodedock.io/introduction/#supported-software-images).

*(Please note that sometimes we forget to update the docs, so check the `docker-compose.yml` file to see an updated list of all available containers).*

3 - Enter the Workspace container, to execute commands like (Artisan, Composer, NodeUnit, Gulp, ...)

```
docker-compose exec workspace bash
```

*Alternatively, for Windows PowerShell users: execute the following command to enter any running container:*

```
docker exec -it {workspace-container-id} bash
```

**Note:** You can add `--user=nodedock` to have files created as your host's user. Example:

```
docker-compose exec --user=nodedock workspace bash
```

*You can change the PUID (User id) and PGID (group id) variables from the `.env` file)*

4 - Update your project configuration to use the database host

Open your Node project's `.env` file or whichever configuration file you are reading from, and set the database host `DB_HOST` to `mysql`:

```
DB_HOST=mysql
```

5 - Open your browser and visit your localhost address `http://localhost/`. If you followed the multiple projects setup, you can visit `http://project-1.test/` and `http://project-2.test/`.

<br />

# License

[MIT License](https://github.com/nodedock/nodedock/blob/master/LICENSE) (MIT)
