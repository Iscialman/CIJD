FROM centos:latest
MAINTAINER Silva Song "silva.song@aliyun.com"

#安装JDK
RUN yum update
RUN yum install -y java-1.6.0-openjdk.x86_64 && yum install -y wget

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
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.121-0.b13.el7_3.x86_64



RUN mkdir /var/tmp/webapp
ADD ./ /var/tmp/webapp
RUN cd /var/tmp/webapp && mvn package && cp /var/tmp/webapp/target/CIJD.war /var/tmp/tomcat/apache-tomcat-8.5.15/webapps

EXPOSE 8080

CMD ["./var/tmp/tomcat/apache-tomcat-8.5.15/bin/catalina.sh","run"]

