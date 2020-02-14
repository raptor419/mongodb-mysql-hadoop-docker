#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml


service ssh start

$HADOOP_PREFIX/sbin/stop-dfs.sh
$HADOOP_PREFIX/sbin/stop-yarn.sh

$HADOOP_PREFIX/bin/hdfs namenode -format

$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

$HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/hive/warehouse
$HADOOP_PREFIX/bin/hdfs dfs -mkdir /tmp
$HADOOP_PREFIX/bin/hdfs dfs -chmod g+w /user/hive/warehouse
$HADOOP_PREFIX/bin/hdfs dfs -chmod g+w /tmp

service mysql start
mongod --fork --logpath /var/log/mongod.log
mysql --user=root --password=root < /var/lib/mysql/dump.sql
python3 /code/answer2.py

cp /usr/local/hadoop/share/hadoop/common/lib/guava-27.0-jre.jar $HIVE_HOME/lib/guava-19.0.jar
rm -rf metastore_db/
$HIVE_HOME/bin/schematool -initSchema -dbType derby

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
