FROM tomcat:latest
 
RUN wget  http://10.0.8.107:8082/remote.php/webdav/iam/iam-rest-1.0.war --http-user=kevin --http-password=kevin -O iam-rest-1.0.war
RUN unzip iam-rest-1.0.war -d /usr/local/tomcat/webapps/iam/   
