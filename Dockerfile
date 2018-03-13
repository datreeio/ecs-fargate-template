FROM node:8
WORKDIR /usr/src/app
COPY package.json .
ARG NPM_TOKEN
RUN npm config set //registry.npmjs.org/:_authToken=$NPM_TOKEN
RUN npm install
COPY . .
EXPOSE 8000
CMD [ "npm", "start" ]
