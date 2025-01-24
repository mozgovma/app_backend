FROM nginx:stable-alpine

RUN apk add --no-cache curl

COPY ./nginx/nginx.conf /etc/nginx/

WORKDIR /var/www/html

HEALTHCHECK --interval=10s --timeout=3s --start-period=1s CMD curl --fail http://127.0.0.1/health || exit 1
