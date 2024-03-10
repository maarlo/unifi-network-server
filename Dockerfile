FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive

#
RUN apt update
RUN apt-get -qq install wget gnupg curl procps nano

# Mongo
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-server-4.4.gpg
RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg ] http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

RUN apt-get update
RUN apt-get -qq install mongodb-org

# UniFI
RUN apt-get -qq install ca-certificates apt-transport-https
RUN echo 'deb [ arch=amd64,arm64 ] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg

RUN apt-get update
RUN apt-get -qq install unifi=8.0.28-24416-1

#
WORKDIR /usr/lib/unifi
VOLUME /usr/lib/unifi/data/

EXPOSE 53
EXPOSE 53/udp
EXPOSE 123/udp
EXPOSE 1900/udp
EXPOSE 3478/udp
EXPOSE 5514/udp
EXPOSE 6789
EXPOSE 8080
EXPOSE 8443
EXPOSE 10001/udp

CMD ["/bin/bash", "-c", "service unifi start && tail -f /usr/lib/unifi/logs/server.log"]