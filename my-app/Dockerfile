FROM node as prod
WORKDIR /app
COPY package*.json ./
COPY . .
RUN npm i
# RUN npm test - if you want to test before to build
RUN npm run build
EXPOSE 3000

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=prod /app/build .
EXPOSE 80
# run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]

