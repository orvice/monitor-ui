FROM node:8.9 as builder

RUN mkdir -p /opt/app
ADD . /opt/app/
WORKDIR /opt/app
RUN npm install
RUN npm run build


FROM nginx
MAINTAINER orvice orvice@orx.me
COPY --from=builder /opt/app/dist /usr/share/nginx/html
