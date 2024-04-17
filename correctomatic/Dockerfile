FROM node:20.12.2-alpine

ENV REPO_URL https://github.com/correctomatic/correction-API.git

RUN apk add --no-cache git
USER node
RUN mkdir -p /home/node/app
# RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

# Correction API
RUN git clone $REPO_URL correction-api
WORKDIR /home/node/app/correction-api
RUN npm install

# TO-DO: starter
# TO-DO: completer
# TO-DO: notifier

#TO-DO: env variables

EXPOSE 3000

CMD [ "node", "app.js" ]
