# syntax=docker/dockerfile:1

FROM openjdk:8u312-jdk-buster

LABEL version="1.2.0"

RUN apt-get update && apt-get install -y curl dos2unix && \
 addgroup minecraft && \
 adduser --home /data --ingroup minecraft --disabled-password minecraft

COPY launch.sh /launch.sh
RUN dos2unix /launch.sh
RUN chmod +x /launch.sh

COPY --chown=minecraft:minecraft server /server

USER minecraft

VOLUME /backup
VOLUME /data

WORKDIR /data

EXPOSE 25565/tcp

CMD ["/launch.sh"]

ENV EULA "false"

ENV MOTD "Vault Hunters 1.13.9 Modded Minecraft Server Powered by Docker"

# default
ENV LEVEL "Vault-Hunters" 
#  loads Iskall's pre-generated world
# ENV LEVEL "Iskall-world"

ENV GAMEMODE "survival"

ENV DIFFICULTY "normal"

# Start with 2G of ram expandable to 6G
ENV JVM_OPTS "-Xms2g -Xmx6g"
