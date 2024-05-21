#!/bin/bash

# Check if any services to exclude are provided
if [ "$#" -eq 0 ]; then
  echo "Usage: $0 service1 service2 ..."
  echo "If you want to run all services, use $0 none"
  echo "The possible services are: `docker compose config --services  | tr '\n' ' '`"
  exit 1
fi

if [ "$1" == "none" ]; then
  # Run all services
  docker compose up
  exit 0
fi

# Get the list of services from docker-compose.yml
ALL_SERVICES=$(docker compose config --services)

# Convert the provided arguments into a list of excluded services
EXCLUDE_SERVICES="runner_base $@"

# Filter out the excluded services
INCLUDE_SERVICES=""
for SERVICE in $ALL_SERVICES; do
  if [[ ! " $EXCLUDE_SERVICES " =~ " $SERVICE " ]]; then
    INCLUDE_SERVICES="$INCLUDE_SERVICES $SERVICE"
  fi
done

# Run docker-compose up with the filtered list of services
docker compose up $INCLUDE_SERVICES
