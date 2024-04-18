#!/bin/sh

# Wait for a specified number of seconds, so that RabbitMQ can be
# fully started before the Node.js process starts
echo "Waiting for $DELAY_SECONDS seconds before starting the Node.js process..."
sleep $DELAY_SECONDS

# Start your Node.js process
exec node src/correction_starter.js
