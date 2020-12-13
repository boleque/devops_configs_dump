FROM tomcat:9.0-jdk8
COPY . $CATALINA_HOME/webapps/
