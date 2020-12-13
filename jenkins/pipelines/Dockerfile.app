FROM tomcat:9.0-jdk8
RUN pwd && ls /var/
COPY /var/jenkins_home/workspace/boxfuse_pipeline/target/hello-1.0.war $CATALINA_HOME/webapps/