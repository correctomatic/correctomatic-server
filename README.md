# Correctomatic server

The purpose of this project is to provide a docker compose file for starting a correctomatic system.

The correctomatic system has these components:
- A **Redis** server as a backend for BullMQ queue system
- The **correction API**: is an API endpoint for launching corrections. It puts the correction on the RabbitMQ queue for further processing.
- The **correction starter**: Receives works from Rabbit and launches the docker container for correcting the exercise.
- The **correction completer**: Detects when a container finished and stores the correction result.
- The **correction notifier**: Calls the callback with the correction results, notifying the client which started the correction.

The API and starter subsystems must share a path to the correction files: the easiest way is to run them in the same machine. This project launches one container for each service, and uses a volume for a shared folder between correctomatic components.

## Launch the server

You can launch all the systems with `docker compose up`.

Alternatively, you can launch/stop the Redis and the correctomatic processes separately with:
- `docker compose up redis`
- `docker compose up api`
- `docker compose up starter`
- `docker compose up completer` (TESTING)
- `docker compose up notifier` (TO-DO)

You don't need the correctomatic processes for development: you should launch the Redis server and run the other processes in your machine.

## Monitoring

The project provides two services for monitoring the correctomatic queues:
- **BullMQ Dashboard**: You can see the current state of the correction queues here. It's accessible at [http://localhost:3000/](http://localhost:3000/)
- **Redis Insight**: To inspect the contents of the Redis server. It's for low-level debugging, you probably won't need this. It's accessible at [http://localhost:5540/](http://localhost:5540/). You will need to configure the connection data to the redis server the first time you use this service.

The Redis server exposes the port 6379 on localhost, so you can also connect to redis using a `redis-cli` image, or whatever Redis DB tool you prefer:
```sh
USER=default
PASS="<the password here>"

docker run -it --rm --network=correctomatic-server_default redis redis-cli -u redis://$USER:$PASS@redis -p 6379
```

## Correctomatic components

TO-DO

Launch a work for correction:

```bash
curl --request POST \
  --url http://localhost:8080/grade \
  --header 'Content-Type: multipart/form-data' \
  --form file=@<PATH OF YOUR FILE> \
  --form work_id=<A RANDOM WORK ID> \
  --form assignment_id=<THE ASSIGNMENT ID> \
  --form callback=http://localhost:9000
```
You will receive a POST on the callback URL once the work has finished






