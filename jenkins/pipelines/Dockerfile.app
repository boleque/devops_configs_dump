FROM tomcat:9.0-jdk8
COPY target/hello-1.0.war $CATALINA_HOME/webapps/
