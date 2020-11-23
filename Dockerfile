FROM tomcat:9.0-jdk8

RUN apt-get update && apt-get install maven -y

RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git && \
    cd boxfuse-sample-java-war-hello/ && mvn package
RUN rm -rf webapps/* && \
    cp boxfuse-sample-java-war-hello/target/hello-1.0.war webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
