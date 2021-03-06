FROM docker.io/java
MAINTAINER Silva Song "silva.song@aliyun.com"

#安装JDK
RUN apt-get update
RUN apt-get install -y wget


#安装tomcat
RUN mkdir -p /var/tmp/tomcat
RUN wget -P /var/tmp/tomcat http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz
RUN tar xzf /var/tmp/tomcat/apache-tomcat-8.5.15.tar.gz -C /var/tmp/tomcat
RUN rm -rf /var/tmp/tomcat/apache-tomcat-8.5.15.tar.gz

#安装maven
RUN mkdir /var/tmp/maven
RUN wget -P /var/tmp/maven http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
RUN tar xzf /var/tmp/maven/apache-maven-3.5.0-bin.tar.gz -C /var/tmp/maven
RUN rm -rf /var/tmp/maven/apache-maven-3.5.0-bin.tar.gz
#设置maven环境变量
ENV MAVEN_HOME=/var/tmp/maven/apache-maven-3.5.0
ENV PATH=$MAVEN_HOME/bin:$PATH


RUN mkdir /var/tmp/webapp
ADD ./ /var/tmp/webapp
RUN cd /var/tmp/webapp && mvn package && cp /var/tmp/webapp/target/CIJD.war /var/tmp/tomcat/apache-tomcat-8.5.15/webapps

EXPOSE 8080

CMD ["./var/tmp/tomcat/apache-tomcat-8.5.15/bin/catalina.sh","run"]
