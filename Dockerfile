FROM tomcat:latest
 
RUN wget  http://10.0.7.107:8082/remote.php/webdav/iam/iam-02.war --http-user=kevin --http-password=kevin -O iam-02.war
RUN unzip iam-02.war -d /usr/local/tomcat/webapps/iam/   
