FROM tomcat:latest
 
RUN wget  http://10.0.7.107:8082/remote.php/webdav/iam/iam-01.war --http-user=kevin --http-password=kevin -O iam-01.war
RUN unzip iam-01.war -d /usr/local/tomcat/webapps/iam/
