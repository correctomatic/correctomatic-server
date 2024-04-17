# Correctomatic server

The purpose of this project is to provide a docker compose for starting a correctomatic system.

The correctomatic system has these components:
- A RabbitMQ queue for sending messages between the subsystems
- The correction API: is an API endpoint for launching corrections. It puts the correction on the RabbitMQ queue for further processing.
- The correction starter: Receives works from Rabbit and launches the docker container for correcting the exercise.
- The correction completer: Detects when a container finished and stores the correction result.
- The correction notifier: Calls the callback with the correction results, notifying the client which started the correction.

The API and starter subsystems must share a path to the correction files: the easiest way is to run them in the same machine. This project launches one container for the RabbitMQ server and another one for the rest of the processes.

It's planned to add an intermediate process for transfering the files to another machine, so they can be run in different machines

## Launch the server

You can launch all systems with `docker compose up`

Alternatively, you can launch the RabbitMQ and the correctomatic processes with:
- `docker compose up rabbitmq`
- `docker compose up correctomatic`

You don't need the correctomatic processes for development: you should launch the RabbitMQ server and run the other processes in your machine.

## RabbitMQ
The container exposes the ports `5672` for RabbitMQ and `15672` for the web management UI.

The users are `admin` (default password `admin`) for management and `app_user` (default password `user`)f or the correctomatic processes. You can change the password modifying the variables `ADMIN_PASSWORD_HASH` and `APP_USER_PASSWORD_HASH` in the `.env` file. The hash can be generated with `generate_password <password>.sh`

The management interface can be accessed at [http://localhost:15672](http://localhost:15672)

## Correctomatic

TO-DO
