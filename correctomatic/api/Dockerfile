FROM node:20.12.2-alpine
ARG SHARED_FOLDER
ARG REPO_URL="https://github.com/correctomatic/correction-API.git"
ARG BRANCH="master"

RUN apk add --no-cache git
USER node

# Shared folder between containers
RUN mkdir -p ${SHARED_FOLDER}

# App directory
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# Clone the repo and install dependencies
RUN git clone -b $BRANCH $REPO_URL correction-api
WORKDIR /home/node/app/correction-api
RUN npm install

EXPOSE 3000
ENTRYPOINT [ "node", "src/index.js" ]
