FROM ubuntu:14.04
MAINTAINER Sahand Hariri


# update, wget and git
RUN apt-get -y update && apt-get install -y \
wget \
git \
vim

# Java
RUN apt-get install -y \
default-jre \
default-jdk

# Scala
RUN wget http://www.scala-lang.org/files/archive/scala-2.11.8.deb
RUN dpkg -i scala-2.11.8.deb

# get Spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz
RUN tar -zxf spark-1.6.1-bin-hadoop2.6.tgz
RUN cp /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties.template /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties
RUN sed -i 's/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g' /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties
RUN cd / && rm spark-1.6.1-bin-hadoop2.6.tgz && rm scala-2.11.8.deb && sudo mv spark-1.6.1-bin-hadoop2.6 /usr/local/spark
RUN cd && export SPARK_HOME=/usr/local/spark && export SPARK_LOCAL_IP="127.0.0.1" && export PATH=$PATH:$SPARK_HOME/bin
RUN echo export SPARK_HOME=/usr/local/spark >> ~/.profile && echo export SPARK_LOCAL_IP="127.0.0.1" >> ~/.profile && echo export PATH=$PATH:$SPARK_HOME/bin >> ~/.profile

# Setting up an sshd service
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd && echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
