FROM maven:3.6.0-jdk-11-slim AS build

RUN apt update && apt install git -y

WORKDIR $MAVEN_HOME
RUN git clone https://github.com/boleque/App42PaaS-Java-MySQL-Sample.git

RUN mvn package -f App42PaaS-Java-MySQL-Sample/

RUN mkdir artifacts/ && pwd
VOLUME /artifacts/

ENTRYPOINT cp App42PaaS-Java-MySQL-Sample/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war \
        artifacts/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war

