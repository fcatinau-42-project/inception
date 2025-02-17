DOCKER	=	docker compose

HOME	=	/Users/florian/

OS		=	$(shell uname)

ifeq ($(OS), Linux)
	HOME	=	/home/fcatinau/
	DOCKER	=	docker-compose
endif

all		:
	mkdir -p $(HOME)data/wordpress
	mkdir -p $(HOME)data/db_data
	$(DOCKER) -f srcs/docker-compose.yml build
	$(DOCKER) -f srcs/docker-compose.yml up

stop	:
	$(DOCKER) -f srcs/docker-compose.yml stop

clean:
	docker volume ls -qf dangling=true | xargs -r docker volume rm
	docker system prune -f -a

fclean: stop clean
	sudo rm -rf ${HOME}data

re : fclean all
