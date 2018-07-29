## Nodemon App

### Usage

You need to install dependencies, per example you can do it running `yarn` locally or `yarn` within a `workspace` container.

```bash
cd nodedock/
cp env-example .env
APP_CODE_PATH_HOST=./examples/nodemon/ docker-compose up -d node nginx
```

By going to `127.0.0.1` in your browser you should see "Hello World"

Once modifying server.js and refreshing a page, you should immediately see an updated result.
