#! /bin/sh

set -e

if [ -n $API_URI ]; then
  sed -i "s|http://127.0.0.1:2008|$API_URI|g" /usr/share/nginx/html/static/js/*.js
else
  echo "no replace api_uri"
fi

if [ -n $APP_NAME ]; then
  sed -i "s|MonitorUI|$APP_NAME|g" /usr/share/nginx/html/static/js/*.js
else
  echo "using default app name"
fi



exec nginx -g 'daemon off;'
