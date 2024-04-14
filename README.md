

https://hub.docker.com/_/rabbitmq


$ docker run --rm -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management



docker run --name ${rabbitmq_name} -d -p ${rabbitmq_port}:15672 -v $PWD/rabbitmq/${env}/data:/var/lib/rabbitmq:rw -v $PWD/rabbitmq/${env}/definitions.json:/opt/definitions.json:ro -v $PWD/rabbitmq/${env}/rabbitmq.config:/etc/rabbitmq/rabbitmq.config:ro rabbitmq:3-management

Launch server:
----------------------------

rabbitmq_name=rabbitmq
rabbitmq_port=8080
data_dir=data
config_dir=config
docker run --name ${rabbitmq_name} -d \
    -p ${rabbitmq_port}:15672 \
    -v $PWD/rabbitmq/${data_dir}/data:/var/lib/rabbitmq:rw \
    -v $PWD/rabbitmq/${config_dir}/definitions.json:/opt/definitions.json:ro \
    -v $PWD/rabbitmq/${config_dir}/rabbitmq.config:/etc/rabbitmq/rabbitmq.config:ro \
    rabbitmq:3-management
