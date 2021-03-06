FROM qizha/phalcon:latest
MAINTAINER Qi Zhang <todayhill@gmail.com>

ENV DB_HOST localhost
ENV DB_USER root
ENV DB_PASSWORD admin!
RUN apt-get update
RUN apt-get install --no-install-recommends -y -q mysql-client-5.5 openssh-server
ADD pohome-www /app
RUN mkdir /app/public/upload /app/public/upload/image /app/apps/frontend/compiled /app/apps/backend/compiled
RUN chmod 777 /app/public/upload /app/public/upload/image /app/apps/frontend/compiled /app/apps/backend/compiled
ADD config/init* /config/
ADD config/nginx* /config/
ADD config/default.conf /etc/nginx/host.d/
ADD config/fastcgi.conf /etc/nginx/
ADD config/default-php.conf /etc/nginx/addon.d/
