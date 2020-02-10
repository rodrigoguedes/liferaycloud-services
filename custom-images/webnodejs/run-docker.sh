### CLEAN
docker rm -f webnodejs
docker rmi rodrigoguedes/webnodejs:local -f

### DOCKER BUILD
docker build -t rodrigoguedes/webnodejs:local .

### DOCKER RUN
docker run -d \
  --name webnodejs \
	-it rodrigoguedes/webnodejs:local

# docker exec -i -t webnodejs bash

docker logs -f webnodejs
