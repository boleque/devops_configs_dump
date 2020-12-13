FROM tomcat:9.0-jdk8
EXPOSE 8081
COPY target/ $CATALINA_HOME/webapps/
