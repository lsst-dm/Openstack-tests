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


# Python
#RUN apt-get install python-pip
#RUN pip install --upgrade pip 
#RUN pip install --upgrade virtualenv 
#RUN pip install \
#pandas \
#"ipython[notebook]"


# Scala
RUN wget http://www.scala-lang.org/files/archive/scala-2.11.8.deb
RUN dpkg -i scala-2.11.8.deb

# get Spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz
RUN tar -zxf spark-1.6.1-bin-hadoop2.6.tgz
RUN cp /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties.template /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties 
RUN sed -i 's/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g' /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties

RUN export PATH=$PATH:/spark-1.6.1-bin-hadoop2.6/bin && echo export PATH=$PATH:/spark-1.6.1-bin-hadoop2.6/bin >> ~/.bashrc
