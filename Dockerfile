FROM tomcat:8
LABEL app=Achistar
RUN sed -i 's/port="8080"/port="4287"/' ${CATALINA_HOME}/conf/server.xml
CMD ["catalina.sh", "run"]
COPY target/*.war /usr/local/tomcat/webapps/home.war
RUN mkdir -p /scripts
COPY script.sh /scripts
WORKDIR /scripts
RUN chmod +x script.sh
RUN ./script.sh
