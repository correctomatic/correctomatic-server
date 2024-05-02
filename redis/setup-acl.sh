#!/bin/sh

# Start Redis server
redis-server /usr/local/etc/redis/redis.conf &

# Wait for Redis server to start
sleep 3

# Set password for default user
echo "ACL SETUSER default on >banana" | redis-cli -h 127.0.0.1 -p 6379

# Keep the container running
tail -f /dev/null
