#!/bin/bash

# Replace placeholder with environment variables
sed -i "s/ADMIN_PASSWORD_HASH/$ADMIN_PASSWORD_HASH/g" /etc/rabbitmq/definitions.json
sed -i "s/APP_USER_PASSWORD_HASH/$APP_USER_PASSWORD_HASH/g" /etc/rabbitmq/definitions.json

# Wait for RabbitMQ server to be ready before executing any commands
rabbitmqctl wait /var/lib/rabbitmq/mnesia/rabbit@$HOSTNAME.pid

# Load definitions and config
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl load_definitions /etc/rabbitmq/definitions.json
rabbitmqctl start_app

unset ADMIN_PASSWORD_HASH
unset APP_USER_PASSWORD_HASH
unset ADMIN_PASSWORD
unset APP_USER_PASSWORD
