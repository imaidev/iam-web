FROM tomcat:latest

RUN yum install wget unzip -y
RUN wget http://10.0.7.107:8082/remote.php/webdav/iam/iam.war?downloadStartSecret=eikkzlsf9jgd2i0wn4iiicnmi --http-user=kevin --http-password=kevin -O iam.war
RUN unzip iam.war -d /usr/local/tomcat/webapps/iam/ 

