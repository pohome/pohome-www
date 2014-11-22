FROM qizha/phalcon:latest
MAINTAINER Qi Zhang <todayhill@gmail.com>

ENV DB_HOST localhost
ENV DB_USER root
ENV DB_PASSWORD admin!
RUN apt-get update
RUN apt-get install --no-install-recommends -y -q mysql-client-5.5
ADD pohome-www /data/http
ADD config/init* /config/
ADD config/default.conf /etc/nginx/host.d/
ADD config/fastcgi.conf /etc/nginx/
ADD config/default-php.conf /etc/nginx/addon.d/
