FROM node:8.9 as builder

RUN mkdir -p /opt/app
ADD . /opt/app/
WORKDIR /opt/app
RUN npm install
RUN npm run build


FROM nginx
MAINTAINER orvice orvice@orx.me

ENV API_URI = http://127.0.0.1:2008
COPY --from=builder /opt/app/dist /usr/share/nginx/html

ADD ./docker-run.sh /usr/share/nginx/

EXPOSE 80

CMD ["sh", "/usr/share/nginx/docker-run.sh"]
