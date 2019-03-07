FROM ubuntu:18.04

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

RUN npm link test
COPY . .

EXPOSE 3030

CMD [ "npm", "start" ]
