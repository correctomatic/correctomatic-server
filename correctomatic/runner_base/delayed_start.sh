#!/bin/sh

# Wait for a specified number of seconds, so that RabbitMQ can be
# fully started before the Node.js process starts
echo "Waiting for $DELAY_SECONDS seconds before starting the Node.js process..."
sleep $DELAY_SECONDS

# Start your Node.js process
case $1 in
  "starter")
    echo "Starting the starter process..."
    exec node src/correction_starter.js
    ;;
  "completer")
    echo "Starting the completer process..."
    exec node src/correction_completer.js
    ;;
  "notifier")
    echo "Starting the notifier process..."
    exec node src/correction_notifier.js
    ;;
  *)
    echo "Unknown process type: $1. Please use 'starter', 'completer' or 'notifier'"
    exit 1
    ;;
esac
