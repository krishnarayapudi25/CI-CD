FROM node:14-alpine
ENV PATH = /app/node_modules/.bin:$PATH
WORKDIR /my-app
COPY package.json ./
RUN npm install
COPY .  ./
EXPOSE 3000
CMD ["npm" , "start"]

