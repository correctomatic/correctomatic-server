# Use the base image specified during build
ARG PARENT_IMAGE
FROM ${PARENT_IMAGE}

# This is the command that will be executed when the container starts
# It will be passed as an argument when the container is started
# The values that can be passed are: "starter", "completer", "notifier"
ARG PROCESS

CMD [ "/delayed_start.sh", $PROCESS ]
