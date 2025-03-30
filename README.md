# Hodlhodl

### Requirements
- Docker
- Docker Compose

### Getting started
```sh
make setup-dev
make up
```

open http://localhost:2300

### Useful commands

```sh
make logs         # Tail app logs
make restart      # Restart all containers
make clean        # Remove volumes and orphans
make db-migrate   # Re-run DB migrations
```
