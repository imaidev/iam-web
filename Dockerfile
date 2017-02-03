FROM tomcat:latest
 
RUN wget  http://10.0.8.107:8082/remote.php/webdav/iam/iam-4.0.war --http-user=kevin --http-password=kevin -O iam-4.0.war
RUN unzip iam-4.0.war -d /usr/local/tomcat/webapps/iam/   
