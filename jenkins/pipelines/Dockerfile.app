FROM tomcat:9.0-jdk8
EXPOSE 8081
COPY hello-1.0.war $CATALINA_HOME/webapps/ #todo cope doesn't work because of context issue
