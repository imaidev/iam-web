FROM tomcat7-jre8:latest

RUN yum install wget unzip -y
RUN wget https://dev.imaicloud.com/files/comic/IAM-war/iam.war
RUN unzip iam.war -d /tomcat/webapps/iam/

# test start
RUN echo 'dataSource.driverClassName=org.gjt.mm.mysql.Driver' > /tomcat/webapps/iam/WEB-INF/classes/datasource.properties
RUN echo 'dataSource.url=jdbc:mysql://10.0.7.107:3306/iam?useUnicode=true&characterEncoding=utf-8&useOldAliasMetadataBehavior=true&allowMultiQueries=true' >> /tomcat/webapps/iam/WEB-INF/classes/datasource.properties
RUN echo 'dataSource.username=root' >> /tomcat/webapps/iam/WEB-INF/classes/datasource.properties
RUN echo 'dataSource.password=root' >> /tomcat/webapps/iam/WEB-INF/classes/datasource.properties
# test end
