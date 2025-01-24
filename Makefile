up:
	docker compose --env-file=sk.env up -d

down:
	docker compose --env-file=sk.env down --remove-orphans

down-clear:
	docker compose --env-file=sk.env down -v --remove-orphans

build:
	docker compose --env-file=sk.env build --pull

rm-dangling:
	docker image prune -f

restart: down-clear up
