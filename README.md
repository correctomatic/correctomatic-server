# Correctomatic server

The purpose of this project is to provide a docker compose file for starting a correctomatic system.

When you launch this server you will have a complete system for launching corrections using your local docker daemon. You can use it for testing the correctomatic system in your local machine, just use the API URL (http://localhost:3000) to launch corrections.

Take in account that the callback URL must be accessible from the notifier container, so if you are running the server in a container, the callback URL must be accessible from the container. You will probably need to use `host.docker.internal` or the IP of your host machine for the callback URL.

The correctomatic system has these components:
- A **Redis** server as a backend for BullMQ queue system
- The **correction API**: is an API endpoint for launching corrections. It puts the correction on the bullMQ queue for further processing.
- The **correction starter**: Receives works from bullMQ and launches the docker container for correcting the exercise.
- The **correction completer**: Detects when a container finished and stores the correction result.
- The **correction notifier**: Calls the callback with the correction results, notifying the client which started the correction.

The API and starter subsystems must share a path to the correction files: the easiest way is to run them in the same machine. This project launches one container for each service, and uses a volume for a shared folder between correctomatic components.

## Launch the server

You can launch all the systems with `docker compose up`. The database must be filled with the correctomatic data before using the API, so you need to run the following command once the containers are up:
```sh
docker compose exec api npx sequelize-cli db:migrate
```

The API will have an empty database, you can seed it with:
```sh
docker compose exec api npx sequelize-cli db:seed:all
```

Or just create a root user and start from scratch:
```sh
docker compose exec -e ROOT_USER=root -e ROOT_PASSWORD=root api yarn create-root-user
```

After that, you can access the API at [http://localhost:3000/](http://localhost:3000/) and use the API to launch corrections.

It will use your local docker daemon to launch the correction containers, so you need to have docker installed in your machine and access to the registry
containing the correction images, or the images dowloades in your machine.

Alternatively, you can launch/stop the Redis and the correctomatic processes separately with:
- `docker compose up redis`
- `docker compose up api`
- `docker compose up starter`
- `docker compose up completer`
- `docker compose up notifier`

Or use the script `up_except.sh` to launch all the services except the ones you specify, for example:
```sh
./up_except.sh completer notifier
```

You don't need the correctomatic processes for developing the correctomatic: you should launch the Redis server and run the other processes in your machine.

## Monitoring

The project provides two services for monitoring the correctomatic queues:
- **BullMQ Dashboard**: You can see the current state of the correction queues here. It's accessible at [http://localhost:3030/](http://localhost:3030/)
- **Redis Insight**: To inspect the contents of the Redis server. It's for low-level debugging, you probably won't need this. It's accessible at [http://localhost:5540/](http://localhost:5540/). You will need to configure the connection data to the redis server the first time you use this service.

The Redis server exposes the port 6379 on localhost, so you can also connect to redis using a `redis-cli` image, or whatever Redis DB tool you prefer:
```sh
USER=default
PASS="<the password here>"

docker run -it --rm --network=correctomatic-server_default redis redis-cli -u redis://$USER:$PASS@redis -p 6379
```

## Correctomatic components


### Correction API

The correction API is the component which receives the works to be corrected. It exposes a REST API for launching corrections.

You can launch a work for correction using the following curl command:

```bash
curl --request POST \
  --url http://localhost:3000/grade \
  --header 'Content-Type: multipart/form-data' \
  --form file=@<PATH OF YOUR FILE> \
  --form work_id=<A RANDOM WORK ID> \
  --form assignment_id=<THE ASSIGNMENT ID> \
  --form callback=http://host.docker.internal:9000
```
You will receive a POST on the callback URL once the work has finished


### Correction Starter

The correction starter is the component which receives the works from the queue and launches the docker container for correcting the exercise.

### Correction Completer

The correction completer is the component which detects when a container finished and stores the correction result. Then it puts the result on the queue for the notifier to send the result to the client.

### Correction Notifier

The correction notifier is the component which calls the callback with the correction results, notifying the client which started the correction. Take in account the notes about the callback URL above.










