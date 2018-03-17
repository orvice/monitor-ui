#! /bin/sh

set -e

if [[ -f $API_URI ]]; then
  sed -i "s/http:\/\/127.0.0.1:2008/$API_URI/g" /usr/share/nginx/html/static/js/*.js
else
  echo "no replace api_uri"
fi



exec nginx -g 'daemon off;'
