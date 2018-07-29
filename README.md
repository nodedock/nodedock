# Nodedock <a href="https://travis-ci.org/nodedock/nodedock"><img src="https://travis-ci.org/nodedock/nodedock.svg?branch=master" alt="Build status"></a>

Nodedock is a community-driven project to create the best Docker Node development environment.

<p align="center">
<img alt="Node + Docker" src="https://raw.githubusercontent.com/nodedock/nodedock/master/docs/node-docker.png" />
</p>

## Goal

I'm an ex-PHP developer, and I've used to use Laradock and similar solutions a lot. However, there's no close thing in NodeJS ecosystem (or at least I didn't find it). So, I decided to build a solution based on Laradock, but for NodeJS. This is how Nodedock was born.

## Check it out on example project

Just hit in a terminal:

```
cp env-example .env
APP_CODE_PATH_HOST=./examples/simple/ docker-compose up -d node nginx
```

Open http://127.0.0.1/ to get a greeting from an example project :)

You can check the logs using `./logs.sh` command to see what's going on during the project startup.

See other examples [here](./examples)

## Quick Start

You need to have a node project with `package.json` with `start` script definition as `node` container will run `npm start` command after start up.

```
cd $NODE_PROJECT_ROOT
git submodule add https://github.com/nodedock/nodedock.git
cp nodedock/env-example nodedock/.env
cd nodedock/
docker-compose up -d nginx node workspace
docker-compose logs -f
```

The last one is optional.

## Alternative Commands

You can also declare the list of services you'd like to run using `NODEDOCK_SERVICES` variable in `.env` (you can create your own `.env` by copying `env-example` file).

After that, you'll be able to use `start.sh`, `stop.sh`, `restart.sh` and `logs.sh` scripts which are located in the root directory of nodedock.

## Documentation

Available on project's website [nodedock.io](https://nodedock.io)

## Working with Documentation

You'll need [Docsify](https://docsify.js.org/):

```
yarn global add docsify-cli
```

After that, you can view docs by running `docsify serve ./docs` and visiting `http://localhost:3000`

## Based on Laradock

This project is based on awesome [Laradock](https://github.com/laradock/laradock) ([contributors](https://github.com/laradock/laradock/graphs/contributors))

# LICENSE

MIT
