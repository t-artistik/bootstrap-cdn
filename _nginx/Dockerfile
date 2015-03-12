FROM jmervine/docker-ngxbox:latest
MAINTAINER Joshua Mervine <joshua@mervine.net>
COPY nginx.conf /etc/nginx/nginx.conf
COPY upstream.conf /upstream.conf
COPY startup.sh /startup.sh
CMD sh /startup.sh
