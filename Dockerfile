FROM tomcat:9.0-jdk8

ENV BOXFUSE_HOME /usr/local/tomcat
RUN mkdir -p "$BOXFUSE_HOME"
WORKDIR $BOXFUSE_HOME

ARG BOXFUSE_REPO="boxfuse-sample-java-war-hello"

RUN apt-get update && apt-get install maven -y

RUN git clone https://github.com/boxfuse/${BOXFUSE_REPO}.git
WORKDIR $BOXFUSE_HOME/${BOXFUSE_REPO}
RUN mvn package

WORKDIR /
RUN rm -rf webapps/* && \
    cp $BOXFUSE_HOME/${BOXFUSE_REPO}/target/hello-1.0.war $CATALINA_HOME/webapps/
