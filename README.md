# Correctomatic server

The purpose of this project is to provide a docker compose for starting a correctomatic system.

The correctomatic system has these components:
- A RabbitMQ queue for sending messages between the subsystems
- The correction API: is an API endpoint for launching corrections. It puts the correction on the RabbitMQ queue for further processing.
- The correction starter: Receives works from Rabbit and launches the docker container for correcting the exercise.
- The correction completer: Detects when a container finished and stores the correction result.
- The correction notifier: Calls the callback with the correction results, notifying the client which started the correction.

The API and starter subsystems must share a path to the correction files: the easiest way is to run them in the same machine. This project launches one container for each service, and uses a volume for a shared folder between correctomatic components.

## Launch the server

You can launch all systems with `docker compose up`

Alternatively, you can launch/stop the RabbitMQ and the correctomatic processes separately with:
- `docker compose up rabbitmq`
- `docker compose up api`
- `docker compose up starter` (TO-DO)
- `docker compose up completer` (TO-DO)
- `docker compose up notifier` (TO-DO)

You don't need the correctomatic processes for development: you should launch the RabbitMQ server and run the other processes in your machine.

## RabbitMQ
The container exposes the ports `5672` for RabbitMQ and `15672` for the web management UI.

The users are `admin` (default password `admin`) for management and `app_user` (default password `user`)f or the correctomatic processes. You can change the password modifying the variables `ADMIN_PASSWORD_HASH` and `APP_USER_PASSWORD_HASH` in the `.env` file. The hash can be generated with `generate_password <password>.sh`

The management interface can be accessed at [http://localhost:15672](http://localhost:15672)

## Correctomatic components

TO-DO

Launch a work for correction:

```bash
curl --request POST \
  --url http://localhost:3000/grade \
  --header 'Content-Type: multipart/form-data' \
  --form file=@<PATH OF YOUR FILE> \
  --form work_id=<A RANDOM WORK ID> \
  --form assignment_id=<THE ASSIGNMENT ID> \
  --form callback=http://localhost:9000
```
You will receive a POST on the callback URL once the work has finished




### BullMQ information and tests

docker run -it --rm --network=correctomatic-server_default redis redis-cli -h redis -p 6379 -a banana
