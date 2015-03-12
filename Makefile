docker_compose?=1.1.0

up: build rm
	./scripts/docker-compose up --no-build

build: scripts/docker-compose
	./scripts/docker-compose build

start:
	./scripts/docker-compose up --no-build --no-recreate

stop:
	./scripts/docker-compose stop

logs:
	./scripts/docker-compose logs

rm:
	./scripts/docker-compose rm --force

clean: rm

scripts/docker-compose:
	curl -L https://github.com/docker/compose/releases/download/$(docker_compose)/docker-compose-`uname -s`-`uname -m` \
		> scripts/docker-compose
	chmod 755 scripts/docker-compose
