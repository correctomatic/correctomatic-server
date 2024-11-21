#!/bin/sh

# Wait for a specified number of seconds, so that DB can be
# fully started before the Node.js process starts
echo "Waiting for $DELAY_SECONDS seconds before starting the Node.js process..."
sleep $DELAY_SECONDS

echo "Starting the API..."
exec node src/index.js
