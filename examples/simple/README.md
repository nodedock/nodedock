## Simple App

### Usage

```bash
cd nodedock/
cp env-example .env
APP_CODE_PATH_HOST=./examples/simple/ docker-compose up -d node nginx
```

By going to `127.0.0.1` in your browser you should see "Hello World"
