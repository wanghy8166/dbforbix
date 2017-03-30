# 依赖的镜像
FROM centos:7.3.1611
# 安装必要路径
RUN mkdir -p /opt/dbforbix/
WORKDIR /opt/dbforbix
# 设置环境变量
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV JAVA_HOME /opt/dbforbix/jre1.7.0_80
ENV CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $JAVA_HOME/bin:$PATH
# 设置时间
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
# 添加本地文件到容器中,如果是压缩包会在目标目录进行自动解压
ADD dbforbix-2.2-beta-linux64.tar.gz /opt/dbforbix/
ADD jre-7u80-linux-x64.tar.gz /opt/dbforbix/
ADD jsvc /usr/bin/jsvc
ADD jtds-1.3.1.jar /opt/dbforbix/lib/
# ADD jre-6u45-linux-x64.bin /opt/orabbix/ 
# RUN sh jre-6u45-linux-x64.bin && rm -rf jre-6u45-linux-x64.bin 
# ADD config.props /opt/orabbix/ 
# RUN mv /opt/orabbix/config.props /opt/orabbix/conf/
RUN chmod -R a+x /opt/dbforbix/dbforbix.sh && \
    sed -i "s#USER=dbforbix#USER=root#g" /opt/dbforbix/dbforbix.sh 
# 容器启动命令
ENTRYPOINT /opt/dbforbix/dbforbix.sh start && sleep 5 && tail -F /opt/dbforbix/logs/dbforbix.log
# entrypoint tail -F /var/log/message 
