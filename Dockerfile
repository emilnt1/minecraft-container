# syntax=docker/dockerfile:1

FROM openjdk:17-jdk-buster

LABEL version="1.18.0"

RUN apt-get update && apt-get install -y curl dos2unix && \
 addgroup minecraft && \
 adduser --home /data --ingroup minecraft --disabled-password minecraft

COPY launch.sh /launch.sh
RUN dos2unix /launch.sh
RUN chmod +x /launch.sh

COPY --chown=minecraft:minecraft server /server
RUN dos2unix /server/start.sh
RUN chmod +x /server/start.sh

USER minecraft

VOLUME /backup
VOLUME /data

WORKDIR /data

EXPOSE 25565/tcp
# RCON
# EXPOSE 25575/tcp

CMD ["/launch.sh"]

ENV EULA "true"

# defaults
# ENV LEVEL "Vault-Hunters"
# ENV MOTD "Vault Hunters 3rd Edition Powered by Docker"
# ENV GAMEMODE "survival"
# ENV DIFFICULTY "normal"

# Start with 2G of ram expandable to 6G
ENV JVM_OPTS "-Xms2g -Xmx6g"
