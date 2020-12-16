FROM maven:3.6.0-jdk-11-slim AS build

RUN apt update && apt install git -y

ENV BOXFUSE_HOME /usr/local/boxfuse
RUN mkdir -p "$BOXFUSE_HOME"
WORKDIR $BOXFUSE_HOME

ARG BOXFUSE_REPO="boxfuse-sample-java-war-hello"

RUN git clone https://github.com/boxfuse/${BOXFUSE_REPO}.git

WORKDIR ${BOXFUSE_REPO}
RUN mvn clean install

WORKDIR $MAVEN_HOME
RUN mkdir artifacts/

VOLUME /$MAVEN_HOME/artifacts

RUN cp $BOXFUSE_HOME/${BOXFUSE_REPO}/target/hello-1.0.war $MAVEN_HOME/artifacts

# TODO find another solution to keep container enable
ENTRYPOINT [ "tail", "-f", "/dev/null" ]
