# ---- Dependencies ----
FROM node:16-alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm i -g pnpm
RUN pnpm install

# ---- Build ----
FROM dependencies AS build
WORKDIR /app
COPY . /app
RUN pnpm build

FROM nginx:1.24-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
