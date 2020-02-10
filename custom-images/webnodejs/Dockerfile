FROM ubuntu:16.04

# Install apps
RUN set -x && \
  apt-get update  && \
  apt-get install -y curl && \
  apt-get install -y jq && \
  apt-get install -y locales && \
  apt-get install -y mysql-client && \
  apt-get install -y npm && \
  apt-get install -y psmisc && \
  apt-get install -y supervisor && \
  apt-get install -y unzip && \
  npm install -g n && \
  n 8.15.1 && \
  rm -rf /var/lib/apt/lists/*

# Config container
COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install app dependencies
WORKDIR /app
COPY package.json .
COPY package-lock.json* .
COPY .babelrc .
RUN set -x && npm install

# Bundle app source
ADD src src
RUN npm run build

RUN cat /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3000

ENTRYPOINT [ "entrypoint" ]