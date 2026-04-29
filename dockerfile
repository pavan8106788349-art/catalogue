FROM node:20-alpine3.23 as builder
WORKDIR /app
COPY package.json .
COPY *.js .
RUN npm install
   
FROM node:20-alpine

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN chown -R roboshop:roboshop /app

USER roboshop

CMD ["node", "server.js"]

# FROM node:20
# # this creates /app and move there
# WORKDIR /app
# COPY package.json .
# COPY *.js .
# RUN npm install
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# CMD ["node", "server.js"]    