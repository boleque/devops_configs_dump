FROM tomcat:9.0-jdk8
COPY target/ /usr/local/tomcat/webapps/
