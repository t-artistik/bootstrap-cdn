FROM jmervine/nodebox:0.12.0-onbuild
MAINTAINER Joshua Mervine <joshua@mervine.net>

ENV NODE_ENV production
RUN mkdir logs
EXPOSE 3000

CMD ["node", "make", "run"]
