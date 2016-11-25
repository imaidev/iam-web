FROM tomcat:latest

RUN wget http://disk.imaicloud.com/remote.php/webdav/iam/iam.war?downloadStartSecret=eikkzlsf9jgd2i0wn4iiicnmi --http-user=kevin --http-password=kevin -O iam.war
RUN unzip iam.war -d /usr/local/tomcat/webapps/iam/ 

