# Introduction

## About

A full NodeJS development environment for Docker.

Includes pre-packaged Docker Images, all pre-configured to provide a wonderful PHP development environment.

This project is based on an awesome [Laradock](https://github.com/laradock/laradock) ([contributors](https://github.com/laradock/laradock/graphs/contributors))

## Quick Overview

Let's see how easy it is to start a simple `nginx` and `nodejs` project.

1. Create a new node.js project, use `yarn init` to create a `package.json` and `yarn add express` to install express.

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

2. Clone nodedock in your project directory:

    ```
    git submodule add https://github.com/nodedock/nodedock.git
    ```

3. Rename `env-example` to `.env` in nodedock directory:

    ```
    cp nodedock/env-example nodedock/.env
    ```

4. Set `NODE_SERVICES` variable within `.env` to a list of services you'd want to run:

    ```
    NODEDOCK_SERVICES=nginx node workspace
    ```

    Note that `workspace` is a container which you'll be ssh'ing into and running watch processes in, so you'd want to set it up here!

5. Run `./nodedock/start.sh`

6. Open your browser and visit `http://localhost/`

    That's it! Enjoy =)

## Features

* Easy switch between Node versions: 8.x, 9.x, 10.x
* Choose your favorite database engine: MySQL or Postgres
* Run your own combination of software: Memcached, Redis, Beanstalkd
* Every software runs on a separate container: node, nginx
* Easy to customize any container, with simple edit to the Dockerfile.
* All Images extends from an official base Image. (Trusted base Images).
* Pre-configured NGINX to host any code at your root directory.
* Can use Nodedock per project, or single Laradock for all projects.
* Easy to install/remove software’s in Containers using environment variables.
* Clean and well structured Dockerfiles (Dockerfile).
* Latest version of the Docker Compose file (docker-compose).
* Everything is visible and editable.
* Fast Images Builds.
* More to come every week..

## Supported Software (Images)

In adhering to the separation of concerns principle as promoted by Docker, Laradock runs each software on its own Container. You can turn On/Off as many instances of as any container without worrying about the configurations, everything works like a charm.

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




