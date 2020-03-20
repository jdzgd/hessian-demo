

# 该镜像需要依赖的基础镜像
FROM java:8
# 将当前目录下的jar包复制到docker容器的/目录下
ADD ./target/hessian-client-0.0.1-SNAPSHOT.jar /hessian-client-0.0.1-SNAPSHOT.jar
# 运行过程中创建一个jar文件
RUN bash -c 'touch /hessian-client-0.0.1-SNAPSHOT.jar'
# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
# 通过网站下载
#ADD https://mirrors.tuna.tsinghua.edu.cn/apache/skywalking/6.6.0/apache-skywalking-apm-6.6.0.tar.gz /
#RUN tar -xf apache-skywalking-apm-6.6.0.tar.gz && \
#    mv apache-skywalking-apm-bin skywalking

ADD /skywalking/agent.config /
ADD /skywalking/skywalking-agent.jar /

#RUN bash -c 'touch /skywalking'


# 暴露端口
EXPOSE 8082
#EXPOSE 11800
# 指定docker容器启动时运行jar包
RUN ["chmod", "+x", "/agent.config"]
RUN ["chmod", "+x", "/skywalking-agent.jar"]

#ENTRYPOINT ["java", "-jar","/hessian-client-0.0.1-SNAPSHOT.jar"]
ENTRYPOINT ["java", "-javaagent:/skywalking-agent.jar","-Dskywalking_config=/agent.config","-Dskywalking.agent.service_name=hessiaclient","-Dskywalking.collector.backend_service=127.0.0.1:11800", "-jar","/hessian-client-0.0.1-SNAPSHOT.jar"]
#ENTRYPOINT java -javaagent:/home/workspace/skywalking/skywalking-agent.jar -Dskywalking_config=/home/workspace/skywalking/agent.config -Dskywalking.collector.backend_service=${SW_COLLECTOR_SERVERS} \
#-Dskywalking.agent.service_name=${SW_SERVICE_NAME} -jar /app.jar
# 指定维护者的名字
MAINTAINER jiangdongzhao