FROM jmervine/nodebox:0.12.0-onbuild
MAINTAINER Joshua Mervine <joshua@mervine.net>

ENV NODE_ENV production
RUN mkdir logs

CMD ["node", "make", "run"]
