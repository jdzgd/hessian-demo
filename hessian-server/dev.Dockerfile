#FROM centos:7
#
#WORKDIR /app
#
#RUN yum install -y wget && \
#    yum install -y java-1.8.0-openjdk
#
#ADD http://mirrors.tuna.tsinghua.edu.cn/apache/skywalking/6.4.0/apache-skywalking-apm-6.4.0.tar.gz /app
#
#RUN tar -xf apache-skywalking-apm-6.4.0.tar.gz && \
#    mv apache-skywalking-apm-bin skywalking
#
#RUN ls /app

# 该镜像需要依赖的基础镜像
FROM java:8
# 将当前目录下的jar包复制到docker容器的/目录下
ADD hessian-server-0.0.1-SNAPSHOT.jar /hessian-server-0.0.1-SNAPSHOT.jar
# 运行过程中创建一个mall-tiny-docker-file.jar文件
RUN bash -c 'touch /hessian-server-0.0.1-SNAPSHOT.jar'
# 声明服务运行在8080端口
EXPOSE 8081
# 指定docker容器启动时运行jar包
ENTRYPOINT ["java", "-jar","/hessian-server-0.0.1-SNAPSHOT.jar"]
MAINTAINER jiangdongzhao