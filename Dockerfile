FROM tomcat:latest
 
RUN wget  http://10.0.8.107:8082/remote.php/webdav/iam/iam-1.1.war --http-user=kevin --http-password=kevin -O iam-1.1.war
RUN unzip iam-1.1.war -d /usr/local/tomcat/webapps/iam/   
