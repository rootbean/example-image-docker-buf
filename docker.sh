
#Variables - DO NOT CHANGE
NAME_IMAGE=debian-buf
NAME_CONTAINER=test-buf
DIR_REMOTE=/temp/buf-gen

# Variable - Modify
DIR_LOCAL=/home/ruber/Documentos/curso_docker/ejemplo1/proto-models

# Docker commands
docker build --tag $NAME_IMAGE .

docker rm -fv $NAME_CONTAINER

docker run -dti --name $NAME_CONTAINER -v $DIR_LOCAL/:$DIR_REMOTE $NAME_IMAGE

docker exec -ti $NAME_CONTAINER bash