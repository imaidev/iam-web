FROM tomcat:latest
 
RUN wget  http://10.0.7.107:8082/remote.php/webdav/iam/iam-03.war --http-user=kevin --http-password=kevin -O iam-03.war
RUN unzip iam-03.war -d /usr/local/tomcat/webapps/iam/   
