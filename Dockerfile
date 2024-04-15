FROM rabbitmq:3.13-management

ARG ADMIN_PASSWORD_HASH
ARG APP_USER_PASSWORD_HASH

# Copy custom definitions and config files
COPY config/definitions.json /etc/rabbitmq/definitions.json
COPY config/rabbitmq.config /etc/rabbitmq/rabbitmq.config

RUN echo $ADMIN_PASSWORD_HASH
RUN echo $APP_USER_PASSWORD_HASH

# Replace passwords in configuration
RUN ESCAPED_ADMIN_HASH=$(printf '%s\n' "$ADMIN_PASSWORD_HASH" | sed -e 's/[\/&]/\\&/g')
RUN sed -i "s/\$ADMIN_PASSWORD_HASH/$ESCAPED_ADMIN_HASH/g" /etc/rabbitmq/definitions.json

RUN ESCAPED_USER_HASH=$(printf '%s\n' "$APP_USER_PASSWORD_HASH" | sed -e 's/[\/&]/\\&/g')
RUN sed -i "s/\$APP_USER_PASSWORD_HASH/$ESCAPED_USER_HASH/g" /etc/rabbitmq/definitions.json

# Copy entrypoint script to create users
# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# Run entrypoint script
# ENTRYPOINT ["/entrypoint.sh"]

# ENV RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS="-rabbitmq_management load_definitions \"/etc/rabbitmq/definitions.json\""


# FROM rabbitmq:3.8.3-management

# ADD --chown=rabbitmq ./definitions.json /etc/rabbitmq/

# ENV RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS="-rabbitmq_management load_definitions \"/etc/rabbitmq/definitions.json\""


