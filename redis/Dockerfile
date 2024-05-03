FROM redis:7.2-alpine

ARG REDIS_PASSWORD_HASH

COPY redis.conf /usr/local/etc/redis/redis.conf
COPY acl.conf /usr/local/etc/redis/acl.conf

# Replace passwords in configuration
RUN ESCAPED_PASSWORD_HASH=$(printf '%s\n' "$REDIS_PASSWORD_HASH" | sed -e 's/[\/&]/\\&/g') && \
    echo $ESCAPED_PASSWORD_HASH && \
    sed -i "s/<REDIS_PASSWORD_HASH>/$ESCAPED_PASSWORD_HASH/g" /usr/local/etc/redis/acl.conf

EXPOSE 6379

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
