
# 该镜像需要依赖的基础镜像
FROM java:8
# 将当前目录下的jar包复制到docker容器的/目录下
ADD ./target/hessian-server-0.0.1-SNAPSHOT.jar /hessian-server-0.0.1-SNAPSHOT.jar
# 运行过程中创建一个hessian-server-0.0.1-SNAPSHOT.jar文件
RUN bash -c 'touch /hessian-server-0.0.1-SNAPSHOT.jar'
# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
#
#ADD https://mirrors.tuna.tsinghua.edu.cn/apache/skywalking/6.6.0/apache-skywalking-apm-6.6.0.tar.gz /
#RUN tar -xf apache-skywalking-apm-6.6.0.tar.gz && \
#    mv apache-skywalking-apm-bin skywalking
ADD /skywalking/agent.config /usr/
ADD /skywalking/skywalking-agent.jar /

EXPOSE 8081
#EXPOSE 11800
# 指定docker容器启动时运行jar包
#ENTRYPOINT ["java", "-javaagent:/skywalking-agent.jar","-Dskywalking_config=/agent.config","-Dskywalking.agent.service_name=hessianserver","-Dskywalking.collector.backend_service=127.0.0.1:11800", "-jar","/hessian-server-0.0.1-SNAPSHOT.jar"]
ENV SKYWALKING_OPTS="-javaagent:/skywalking-agent.jar -Dskywalking_config=/usr/agent.config -Dskywalking.agent.service_name=hessianserver -Dskywalking.collector.backend_service=172.27.0.3:11800"
ENTRYPOINT [ "sh", "-c", "java $SKYWALKING_OPTS -jar /hessian-server-0.0.1-SNAPSHOT.jar" ]

MAINTAINER jiangdongzhao