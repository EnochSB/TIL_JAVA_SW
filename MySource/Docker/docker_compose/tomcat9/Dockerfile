FROM tomcat:9.0.94-jre11
ENV VIRTUAL_HOST=www.miniboard.com
ADD server.xml /usr/local/tomcat/conf
ADD ROOT.war /usr/local/tomcat/webapps
WORKDIR /usr/local/tomcat
EXPOSE 8080