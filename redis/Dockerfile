FROM redis:7.2-alpine

ARG ADMIN_PASSWORD_HASH

COPY redis.conf /usr/local/etc/redis/redis.conf
COPY acl.conf /usr/local/etc/redis/acl.conf

# Copy setup script into the image
COPY setup-acl.sh /usr/local/bin/setup-acl.sh
RUN chmod +x /usr/local/bin/setup-acl.sh

EXPOSE 6379
CMD [ "sh", "/usr/local/bin/setup-acl.sh" ]
# CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
