FROM node:20-alpine
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT npm run start