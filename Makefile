COMPOSE = srcs/docker-compose.yml

all: run

run: 
	@echo "Building volume directories ..."
	@sudo mkdir -p ~/data/wordpress
	@sudo mkdir -p ~/data/mysql
	@echo "Building containers ..."
	@docker compose -f $(COMPOSE) --verbose up --build

up: 
	@echo "Building volume directories ..."
	@sudo mkdir -p /home/mlebard/data/wordpress
	@sudo mkdir -p /home/mlebard/data/mysql
	@echo "Building containers ..."
	@docker compose -f $(COMPOSE) up -d --build

#up: 
#	@echo "Building volume directories ..."
#	@sudo mkdir -p /home/mlebard/data/wordpress
#	@sudo mkdir -p /home/mlebard/data/mysql
#	@echo "Building containers ..."
#	@docker compose -f $(COMPOSE) --verbose up

clean: 	
	@echo "Stopping containers ..."
	@docker compose -f $(COMPOSE) down
	@docker container prune 
#	@docker rm `docker ps -qa`
	@echo "Deleting all images ..."
	@docker image rm -f `docker images -qa`
	@echo "Deleting all volumes ..."
	@docker volume prune
	@echo "Deleting all network ..."
	@docker network prune
	@echo "Deleting all data ..."
	@sudo rm -rf ~/data/wordpress
	@sudo rm -rf ~/data/mysql
	@echo "Deleting all"

