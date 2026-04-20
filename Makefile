.PHONY: db-up db-down db-reset db-seed

db-up:
	docker-compose up -d postgres

db-down:
	docker-compose down

db-reset:
	docker-compose down -v
	docker-compose up -d postgres

db-seed:
	mix run priv/repo/seeds.exs
