COMPOSE = srcs/docker-compose.yml

all: run

run: 
	@echo "Building volume directories ..."
	@sudo mkdir -p /home/mlebard/data/wordpress
	@sudo mkdir -p /home/mlebard/data/mysql
	@echo "Building containers ..."
	@docker compose -f $(COMPOSE) up --build

up: 
	@echo "Building volume directories ..."
	@sudo mkdir -p /home/mlebard/data/wordpress
	@sudo mkdir -p /home/mlebard/data/mysql
	@echo "Building containers ..."
	@docker compose -f $(COMPOSE) up -d --build

up: 
	@echo "Building volume directories ..."
	@sudo mkdir -p /home/mlebard/data/wordpress
	@sudo mkdir -p /home/mlebard/data/mysql
	@echo "Building containers ..."
	@docker compose -f $(COMPOSE) --verbose up

clean: 	
	@echo "Stopping containers ..."
	@docker compose -f $(COMPOSE) down
	@docker stop `docker ps -qa`
	@docker rm `docker ps -qa`
	@echo "Deleting all images ..."
	@docker rm -f `docker images -qa`
	@echo "Deleting all volumes ..."
	@docker volume rm `docker volume ls -q`
	@echo "Deleting all network ..."
	@docker network rm `docker network ls -q`
	@echo "Deleting all data ..."
	@sudo rm -rf /home/mlebard/data/wordpress
	@sudo rm -rf /home/mlebard/data/mysql
	@echo "Deleting all"

