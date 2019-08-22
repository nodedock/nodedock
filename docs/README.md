# Nodedock.io - Docker NodeJS development environment

# Introduction

[https://github.com/nodedock/nodedock](https://github.com/nodedock/nodedock)

## About

A full NodeJS development environment for Docker.

<p align="center">
![Node + Docker](https://raw.githubusercontent.com/nodedock/nodedock/master/docs/node-docker.png)
</p>

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

**Note**: All the web server containers `nginx` ..etc depends on `node`, which means if you run any of them, they will automatically launch the `node` container for you, so no need to explicitly specify it in the `up` command. If you have to do so, you may need to run them as follows: `docker-compose up -d nginx node mysql`.

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

# Documentation

## List current running Containers

```
docker ps
```

You can also use the following command if you want to see only this project containers:

```
docker-compose ps
```

## Close all running Containers

```
docker-compose stop
```

To stop single container do:

```
docker-compose stop {container-name}
```

## Delete all existing Containers

```
docker-compose down
```

## Enter a Container (run commands in a running Container)

1 - First list the current running containers with `docker ps`

2 - Enter any container using:

```
docker-compose exec {container-name} bash
```

*Example: enter MySQL container*

```
docker-compose exec mysql bash
```

*Example: enter to MySQL prompt within MySQL container*

```
docker-compose exec mysql mysql -u homestead -psecret
```

3 - To exit a container, type `exit`.

## Edit default container configuration

Open the `docker-compose.yml` and change anything you want.

Examples:

Change MySQL Database Name:

```
    environment:
        MYSQL_DATABASE: nodedock
    ...
```

Change Redis default port to 1111:

```
    ports:
        - "1111:6379"
    ...
```

## Edit a Docker Image

1 - Find the `Dockerfile` of the image you want to edit,

example for `mysql` it will be `mysql/Dockerfile`.

2 - Edit the file the way you want.

3 - Re-build the container:

```
docker-compose build mysql
```

More info on Containers rebuilding [here](#Build-Re-build-Containers).

## Build/Re-build Containers

If you do any change to any `Dockerfile` make sure you run this command, for the changes to take effect:

```
docker-compose build
```
Optionally you can specify which container to rebuild (instead of rebuilding all the containers):

```
docker-compose build {container-name}
```

You might use the `--no-cache` option if you want full rebuilding (`docker-compose build --no-cache {container-name}`).

## Add more Software (Docker Images)

To add an image (software), just edit the `docker-compose.yml` and add your container details, to do so you need to be familiar with the [docker compose file syntax](https://docs.docker.com/compose/compose-file/).

## View the Log files

The NGINX Log file is stored in the `logs/nginx` directory.

However to view the logs of all the other containers (MySQL, Node,...) you can run this:

```
docker-compose logs {container-name}
```

```
docker-compose logs -f {container-name}
```

More [options](https://docs.docker.com/compose/reference/logs/)

## Prepare Nodedock for Production

It's recommended for production to create a custom `docker-compose.yml` file. For that reason, Nodedock is shipped with `production-docker-compose.yml` which should contain only the containers you are planning to run on production (usage example: `docker-compose -f production-docker-compose.yml up -d nginx mysql redis ...`).

Note: The Database (MySQL/MariaDB/...) ports should not be forwarded on production, because Docker will automatically publish the port on the host, which is quite insecure, unless specifically told not to. So make sure to remove these lines:

```
ports:
    - "3306:3306"
```

To learn more about how Docker publishes ports, please read [this excellent post on the subject](https://fralef.me/docker-and-iptables.html).

## Use Redis

1 - First make sure you run the Redis Container (`redis`) with the `docker-compose up` command.

```
docker-compose up -d redis
```

> To execute redis commands, enter the redis container first `docker-compose exec redis bash` then enter the `redis-cli`.

2 - In your app, set redis host to `redis`

## Use Mongo

1 - First install `mongo` in the Workspace and the Node Containers:
<br>
a) open the `.env` file
<br>
b) search for the `WORKSPACE_INSTALL_MONGO` argument under the Workspace Container
<br>
c) set it to `true`
<br>
d) search for the `NODE_INSTALL_MONGO` argument under the Node Container
<br>
e) set it to `true`

2 - Re-build the containers `docker-compose build workspace node`

3 - Run the MongoDB Container (`mongo`) with the `docker-compose up` command.

```
docker-compose up -d mongo
```

4 - Open your project's `.env` file or whatever you use for configuration and update the following variables:

- set the `DB_HOST` to your `mongo`.
- set the `DB_PORT` to `27017`.
- set the `DB_DATABASE` to `database`.

## Use PhpMyAdmin

1 - Run the phpMyAdmin Container (`phpmyadmin`) with the `docker-compose up` command. Example:

```
# use with mysql
docker-compose up -d mysql phpmyadmin
```

*Note: To use with MariaDB, open `.env` and set `PMA_DB_ENGINE=mysql`*

2 - Open your browser and visit the localhost on port **8080**:  `http://localhost:8080`

## Use Adminer

1 - Run the Adminer Container (`adminer`) with the `docker-compose up` command. Example:

```
docker-compose up -d adminer
```

2 - Open your browser and visit the localhost on port **8080**:  `http://localhost:8080`

**Note:** We've locked Adminer to version 4.3.0 as at the time of writing [it contained a major bug](https://sourceforge.net/p/adminer/bugs-and-features/548/) preventing PostgreSQL users from logging in. If that bug is fixed (or if you're not using PostgreSQL) feel free to set Adminer to the latest version within [the Dockerfile](https://github.com/nodedock/nodedock/blob/master/adminer/Dockerfile#L1): `FROM adminer:latest`

## Use PgAdmin

1 - Run the pgAdmin Container (`pgadmin`) with the `docker-compose up` command. Example:

```
docker-compose up -d postgres pgadmin
```

2 - Open your browser and visit the localhost on port **5050**:  `http://localhost:5050`

## Use Beanstalkd

1 - Run the Beanstalkd Container:

```
docker-compose up -d beanstalkd
```

2 - Configure your app to connect to that container.

a. first set `beanstalkd` as default queue driver
b. set the queue host to beanstalkd : `QUEUE_HOST=beanstalkd`

*beanstalkd is now available on default port `11300`.*

Optionally you can use the Beanstalkd Console Container to manage your Queues from a web interface.

1 - Run the Beanstalkd Console Container:

```
docker-compose up -d beanstalkd-console
```

2 - Open your browser and visit `http://localhost:2080/`

_Note: You can customize the port on which beanstalkd console is listening by changing `BEANSTALKD_CONSOLE_HOST_PORT` in `.env`. The default value is *2080*._

3 - Add the server

- Host: beanstalkd
- Port: 11300

4 - Done.

## Use ElasticSearch

1 - Run the ElasticSearch Container (`elasticsearch`) with the `docker-compose up` command:

```bash
docker-compose up -d elasticsearch
```

2 - Open your browser and visit the localhost on port **9200**:  `http://localhost:9200`

> The default username is `elastic` and the default password is `changeme`.

### Install ElasticSearch Plugin

1 - Install an ElasticSearch plugin.

```bash
docker-compose exec elasticsearch /usr/share/elasticsearch/bin/plugin install {plugin-name}
```

2 - Restart elasticsearch container

```bash
docker-compose restart elasticsearch
```

# Miscellaneous

## Change the timezone

To change the timezone for the `workspace` container, modify the `TZ` build argument in the Docker Compose file to one in the [TZ database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

For example, if I want the timezone to be `New York`:

```
    workspace:
        build:
            context: ./workspace
            args:
                - TZ=America/New_York
    ...
```

## Adding cron jobs

You can add your cron jobs to `workspace/crontab/root`.

```
* * * * * root echo "Every Minute" > /var/log/cron.log 2>&1
```

Make sure you [change the timezone](#Change-the-timezone) if you don't want to use the default (UTC).

If you are on Windows, verify that the line endings for this file are LF only, otherwise the cron jobs will silently fail.

## Access workspace via ssh

You can access the `workspace` container through `localhost:2222` by setting the `INSTALL_WORKSPACE_SSH` build argument to `true`.

To change the default forwarded port for ssh:

```
    workspace:
		ports:
			- "2222:22" # Edit this line
    ...
```

Then login using:

```
ssh -o PasswordAuthentication=no    \
    -o StrictHostKeyChecking=no     \
    -o UserKnownHostsFile=/dev/null \
    -p 2222                         \
    -i workspace/insecure_id_rsa    \
    nodedock@localhost
```

To login as root, replace nodedock@locahost with root@localhost.

## Change the (MySQL) Version

By default **MySQL 8.0** is running.

MySQL 8.0 is a development release.  You may prefer to use the latest stable version, or an even older release.  If you wish, you can change the MySQL image that is used.

Open up your .env file and set the `MYSQL_VERSION` variable to the version you would like to install.

```
MYSQL_VERSION=5.7
```

Available versions are: 5.5, 5.6, 5.7, 8.0, or latest.  See https://store.docker.com/images/mysql for more information.

## MySQL access from host

You can forward the MySQL/MariaDB port to your host by making sure these lines are added to the `mysql` or `mariadb` section of the `docker-compose.yml` or in your [environment specific Compose](https://docs.docker.com/compose/extends/) file.

```
ports:
    - "3306:3306"
```

## MySQL root access

The default username and password for the root MySQL user are `root` and `root `.

1 - Enter the MySQL container: `docker-compose exec mysql bash`.

2 - Enter mysql: `mysql -uroot -proot` for non root access use `mysql -uhomestead -psecret`.

3 - See all users: `SELECT User FROM mysql.user;`

4 - Run any commands `show databases`, `show tables`, `select * from.....`.

## Create Multiple Databases (MySQL)

Create `createdb.sql` from `mysql/docker-entrypoint-initdb.d/createdb.sql.example` in `mysql/docker-entrypoint-initdb.d/*` and add your SQL syntax as follow:

```sql
CREATE DATABASE IF NOT EXISTS `your_db_1` COLLATE 'utf8_general_ci' ;
GRANT ALL ON `your_db_1`.* TO 'mysql_user'@'%' ;
```

## Change MySQL port

Modify the `mysql/my.cnf` file to set your port number, `1234` is used as an example.

```
[mysqld]
port=1234
```

If you need <a href="#MySQL-access-from-host">MySQL access from your host</a>, do not forget to change the internal port number (`"3306:3306"` -> `"3306:1234"`) in the docker-compose configuration file.

## Use custom Domain (instead of the Docker IP)

Assuming your custom domain is `node.test`

1 - Open your `/etc/hosts` file and map your localhost address `127.0.0.1` to the `node.test` domain, by adding the following:

```bash
127.0.0.1    node.test
```

2 - Open your browser and visit `{http://node.test}`


Optionally you can define the server name in the NGINX configuration file, like this:

```
server_name node.test;
```

## Common Terminal Aliases

When you start your docker container, Nodedock will copy the `aliases.sh` file located in the `nodedock/workspace` directory and add sourcing to the container `~/.bashrc` file.

You are free to modify the `aliases.sh` as you see fit, adding your own aliases (or function macros) to suit your requirements.

## Keep track of your Nodedock changes

1. Fork the Nodedock repository.
2. Use that fork as a submodule.
3. Commit all your changes to your fork.
4. Pull new stuff from the main repository from time to time.

## Improve speed on MacOS

Docker on the Mac [is slow](https://github.com/docker/for-mac/issues/77), at the time of writing. Especially for larger projects, this can be a problem. The problem is [older than March 2016](https://forums.docker.com/t/file-access-in-mounted-volumes-extremely-slow-cpu-bound/8076) - as it's a such a long-running issue, we're including it in the docs here.

So since sharing code into Docker containers with osxfs have very poor performance compared to Linux. Likely there are some workarounds:

### Workaround A: using dinghy

[Dinghy](https://github.com/codekitchen/dinghy) creates its own VM using docker-machine, it will not modify your existing docker-machine VMs.

Quick Setup giude, (we recommend you check their docs)

1) `brew tap codekitchen/dinghy`

2) `brew install dinghy`

3) `dinghy create --provider virtualbox` (must have virtualbox installed, but they support other providers if you prefer)

4) after the above command is done it will display some env variables, copy them to the bash profile or zsh or.. (this will instruct docker to use the server running inside the VM)

5) `docker-compose up ...`

### Workaround B: using d4m-nfs

You can use the d4m-nfs solution in 2 ways, the first is by using the built-in Nodedock integration, and the second is using the tool separately. Below is show case of both methods:

### B.1: using the built in d4m-nfs integration

In simple terms, docker-sync creates a docker container with a copy of all the application files that can be accessed very quickly from the other containers.
On the other hand, docker-sync runs a process on the host machine that continuously tracks and updates files changes from the host to this intermediate container.

Out of the box, it comes pre-configured for OS X, but using it on Windows is very easy to set-up by modifying the `DOCKER_SYNC_STRATEGY` on the `.env`

#### Usage

Nodedock comes with `sync.sh`, an optional bash script, that automates installing, running and stopping docker-sync.  Note that to run the bash script you may need to change the permissions `chmod 755 sync.sh`

1) Configure your Nodedock environment as you would normally do and test your application to make sure that your sites are running correctly.

2) Make sure to set `DOCKER_SYNC_STRATEGY` on the `.env`. Read the [syncing strategies](https://github.com/EugenMayer/docker-sync/wiki/8.-Strategies) for details.
```
# osx: 'native_osx' (default)
# windows: 'unison'
# linux: docker-sync not required

DOCKER_SYNC_STRATEGY=native_osx
```

3) set `APP_CODE_PATH_CONTAINER=/var/www` to `APP_CODE_PATH_CONTAINER=/var/www:nocopy` in the .env file

4) Install the docker-sync gem on the host-machine:
```bash
./sync.sh install
```
5) Start docker-sync and the Nodedock environment.
Specify the services you want to run, as you would normally do with `docker-compose up`
```bash
./sync.sh up nginx mysql
```
Please note that the first time docker-sync runs, it will copy all the files to the intermediate container and that may take a very long time (15min+).
6) To stop the environment and docker-sync do:
```bash
./sync.sh down
```

#### Setting up Aliases (optional)

You may create bash profile aliases to avoid having to remember and type these commands for everyday development.
Add the following lines to your `~/.bash_profile`:

```bash
alias devup="cd /PATH_TO_NODEDOCK/nodedock; ./sync.sh up nginx mysql" #add your services
alias devbash="cd /PATH_TO_NODEDOCK/nodedock; ./sync.sh bash"
alias devdown="cd /PATH_TO_NODEDOCK/nodedock; ./sync.sh down"
```

Now from any location on your machine, you can simply run `devup`, `devbash` and `devdown`.

#### Additional Commands

Opening bash on the workspace container (to run artisan for example):

```
./sync.sh bash
```

Manually triggering the synchronization of the files:

```
./sync.sh sync
```

Removing and cleaning up the files and the docker-sync container. Use only if you want to rebuild or remove docker-sync completely. The files on the host will be kept untouched.

```
./sync.sh clean
```


#### Additional Notes

- You may run nodedock with or without docker-sync at any time using with the same `.env` and `docker-compose.yml`, because the configuration is overridden automatically when docker-sync is used.
- You may inspect the `sync.sh` script to learn each of the commands and even add custom ones.
- If a container cannot access the files on docker-sync, you may need to set a user on the Dockerfile of that container with an id of 1000 (this is the UID that nginx and node have configured on nodedock). Alternatively, you may change the permissions to 777, but this is **not** recommended.

Visit the [docker-sync documentation](https://github.com/EugenMayer/docker-sync/wiki) for more details.

### B.2: using the d4m-nfs tool

[D4m-nfs](https://github.com/IFSight/d4m-nfs) automatically mount NFS volume instead of osxfs one.

1) Update the Docker [File Sharing] preferences:

Click on the Docker Icon > Preferences > (remove everything form the list except `/tmp`).

2) Restart Docker.

3) Clone the [d4m-nfs](https://github.com/IFSight/d4m-nfs) repository to your `home` directory.

```bash
git clone https://github.com/IFSight/d4m-nfs ~/d4m-nfs
```

4) Create (or edit) the file `~/d4m-nfs/etc/d4m-nfs-mounts.txt`, and write the following configuration in it:

```txt
/Users:/Users
```

5) Create (or edit) the file `/etc/exports`, make sure it exists and is empty. (There may be collisions if you come from Vagrant or if you already executed the `d4m-nfs.sh` script before).


6) Run the `d4m-nfs.sh` script (might need Sudo):

```bash
~/d4m-nfs/d4m-nfs.sh
```

That's it! Run your containers.. Example:

```bash
docker-compose up ...
```

*Note: If you faced any errors, try restarting Docker, and make sure you have no spaces in the `d4m-nfs-mounts.txt` file, and your `/etc/exports` file is clear.*

## Puppeteer support

If you are going to use puppeteer you have to set `PUPPETEER_SUPPORT=true` into `.env`. In case you have built (started) containers before you decided to use puppeteer, you should rebuild them first: 
```bash
docker-compose build --no-cache workspace node
```
then start everything regular way

# Common Problems

*Here's a list of the common problems you might face, and the possible solutions.*

## I see "Welcome to nginx" instead of the Node App!

Use `http://127.0.0.1` instead of `http://localhost` in your browser.

## I see an error message containing `address already in use` or `port is already allocated`

Make sure the ports for the services that you are trying to run (22, 80, 443, 3306, etc.) are not being used already by other programs on the host, such as a built in `nginx`/`apache`/`httpd` service or other development tools you have installed.

## I get NGINX error 404 Not Found on Windows.

1. Go to docker Settings on your Windows machine.
2. Click on the `Shared Drives` tab and check the drive that contains your project files.
3. Enter your windows username and password.
4. Go to the `reset` tab and click restart docker.

## The time in my services does not match the current time

1. Make sure you've [changed the timezone](#Change-the-timezone).
2. Stop and rebuild the containers (`docker-compose up -d --build <services>`)

## I get stuck when building nginx on `fetch http://mirrors.aliyun.com/alpine/v3.5/main/x86_64/APKINDEX.tar.gz`

As stated on [#749](https://github.com/laradock/laradock/issues/749#issuecomment-293296687), removing the line `RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories` from `nginx/Dockerfile` solves the problem.

## Custom composer repo packagist url and npm registry url

In China, the origin source of composer and npm is very slow. You can add `WORKSPACE_NPM_REGISTRY` and `WORKSPACE_COMPOSER_REPO_PACKAGIST` config in `.env` to use your custom source.

Example:
```bash
WORKSPACE_NPM_REGISTRY=https://registry.npm.taobao.org
```

## I get `Module build failed: Error: write EPIPE` while compiling react application

When you run `npm build` or `yarn dev` building a react application using webpack with elixir you may receive a `Error: write EPIPE` while processing .jpg images.

This is caused of an outdated library for processing **.jpg files** in ubuntu 16.04.

To fix the problem you can follow those steps

1 - Open the `.env`.

2 - Search for `WORKSPACE_INSTALL_LIBPNG` or add the key if missing.

3 - Set the value to true:

```dotenv
WORKSPACE_INSTALL_LIBPNG=true
```

4 - Finally rebuild the workspace image

```bash
docker-compose build workspace
```

# License

[MIT License](https://github.com/nodedock/nodedock/blob/master/LICENSE) (MIT)
