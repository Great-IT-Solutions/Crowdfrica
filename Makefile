COMPONENTS := app db
UP_COMPONENT = app


up:
	docker-compose up -d
	docker-compose ps

down:
	docker-compose stop

ps:
	docker-compose ps

build:
	docker-compose build

logs: $(addsuffix .logs,$(COMPONENTS))

tests: up
	docker-compose run $(UP_COMPONENT) bundle exec rspec

restart:
	docker-compose restart


define make-goal

$1.logs:
	docker-compose logs -f $1

$1.bash:
	docker-compose run $1 bash

endef

$(foreach component,$(COMPONENTS),$(eval $(call make-goal, $(component))))
#############################

purge:
	docker rm -v $$(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $$(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null

db.repl:
	docker-compose run $(UP_COMPONENT) rails db

db.migrate:
	docker-compose run $(UP_COMPONENT) rails db:migrate

db.setup:
	docker-compose run $(UP_COMPONENT) bundle exec rails db:setup