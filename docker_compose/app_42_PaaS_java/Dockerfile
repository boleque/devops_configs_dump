FROM maven:3.6.0-jdk-11-slim AS build

RUN apt update && apt install git -y

ENV APP_SRC_DEST /usr/local/app24
RUN mkdir -p "$APP_SRC_DEST"
WORKDIR $APP_SRC_DEST

ARG APP="App42PaaS-Java-MySQL-Sample"

RUN git clone https://github.com/boleque/${APP}.git

WORKDIR ${APP}/
RUN mvn package && pwd && ls -a

WORKDIR $MAVEN_HOME
RUN mkdir artifacts/

VOLUME /$MAVEN_HOME/artifacts

RUN cp $APP_SRC_DEST/${APP}/target/*.war $MAVEN_HOME/artifacts && ls -a $MAVEN_HOME/artifacts
