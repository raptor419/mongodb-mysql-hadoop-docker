FROM ubuntu

MAINTAINER Harsh Bandhey <raptor419heavy@gmail.com>

USER root

# install dev tools
RUN apt-get update
RUN apt-get install -y curl 
RUN apt-get install -y tar 
RUN apt-get install -y sudo 
RUN apt-get install -y openssh-server 
RUN apt-get install -y openssh-client 
RUN apt-get install -y rsync 
RUN apt-get install -y gnupg

# Environment Variables
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG "en_US.UTF-8"

# passwordless ssh
RUN rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key /root/.ssh/id_rsa
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# SQL Setup

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install -y mysql-server

ADD sql.cnf         /etc/mysql/my.cnf

RUN mkdir -p        /etc/service/mysql
ADD run_mysql.sh    /etc/service/mysql/run
RUN chmod +x        /etc/service/mysql/run

RUN mkdir -p        /var/lib/mysql/
RUN chmod -R 755    /var/lib/mysql/

ADD my_sql.sh       /etc/mysql/my_sql.sh
RUN chmod +x        /etc/mysql/my_sql.sh

EXPOSE 3306

# MongoDB

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN curl -s https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org

RUN mkdir -p /data/db
VOLUME ["/data/db"]
RUN chown -R mongodb:mongodb /data
RUN echo "bind_ip = 0.0.0.0" >> /etc/mongodb.conf

EXPOSE 27017

RUN mkdir /etc/service/mongo
ADD run_mongodb.sh /etc/service/mongo/run
RUN chown root /etc/service/mongo/run
RUN chmod +x /etc/service/mongo/run


# UCARP
RUN apt-get install -y ucarp

# java
RUN apt-get install -y openjdk-8-jdk 

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
ENV PATH $PATH:$JAVA_HOME/bin

# Hadoop
RUN curl -s https://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-3.1.3/hadoop-3.1.3-src.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local 
RUN ln -s ./hadoop-3.1.3 hadoop

# Hadoop Envs

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
RUN . $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

RUN $HADOOP_PREFIX/bin/hdfs namenode -format

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

ENV BOOTSTRAP /etc/bootstrap.sh

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

RUN service ssh start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
RUN service ssh start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input

CMD ["/etc/bootstrap.sh", "-bash"]

# === Clean APT
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122 22