.PHONY: setup db-create db-migrate up up-app down restart logs clean wait-for-db assets-compile

setup: down clean up-db wait-for-db db-create db-migrate assets-compile

setup-dev: build-nc down clean up-db wait-for-db db-create db-migrate assets-compile

build:
	docker-compose build

build-nc:
	docker-compose build --no-cache

up:
	docker-compose up -d

up-app:
	docker-compose up -d app

down:
	docker-compose down

restart:
	docker-compose down
	docker-compose up -d

wait-for-db:
	@echo "🔄 Waiting for PostgreSQL to be ready..."
	docker-compose exec db bash -c 'until pg_isready -U postgres; do echo "⏳ Waiting..."; sleep 1; done'
	@echo "✅ PostgreSQL is ready."

db-create:
	docker-compose exec db psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'hodlhodl_development'" | grep -q 1 || docker-compose exec db psql -U postgres -c 'CREATE DATABASE hodlhodl_development;'
	docker-compose exec db psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'hodlhodl_test'" | grep -q 1 || docker-compose exec db psql -U postgres -c 'CREATE DATABASE hodlhodl_test;'

db-migrate:
	docker-compose run --rm app bundle exec hanami db migrate

assets-compile:
	docker-compose up -d app
	docker-compose exec app bundle exec hanami assets compile	

logs:
	docker-compose logs -f app

clean:
	docker-compose down -v --remove-orphans

up-db:
	docker-compose up -d db

up-db-app:
	docker-compose up -d db app
