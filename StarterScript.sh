# set the hostname in /etc/hosts
sudo sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts

echo "============ Update and install wget and git ====================="

sudo apt-get -y update
sudo rm /boot/grub/menu.lst
sudo update-grub-legacy-ec2 -y
sudo apt-get dist-upgrade -qq --force-yes
sudo apt-get  upgrade

sudo apt-get -y install linux-image-generic-lts-trusty

sudo apt-get -y install wget
sudo apt-get -y install git


echo "==========================Isntalling Java================================"
# Installation of JDK
sudo apt-get -y install default-jre
sudo apt-get -y install default-jdk


echo "============================Python Libraries============================="
sudo apt-get install -y python-pip python-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade virtualenv
sudo pip install pandas
sudo pip install seaborn
sudo pip install pyfits
sudo pip install "ipython[notebook]"


echo "===============================Scala installation================================="
# Installation of scala
wget http://www.scala-lang.org/files/archive/scala-2.11.8.deb
sudo dpkg -i scala-2.11.8.deb

echo "===========================Download Spark============================"
# Downloading spark
wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz
tar -zxf spark-1.6.1-bin-hadoop2.6.tgz
cd spark-1.6.1-bin-hadoop2.6/conf
cp log4j.properties.template log4j.properties
sed -i 's/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g' ./log4j.properties

cd
export PATH=$PATH:~/spark-1.6.1-bin-hadoop2.6/bin
echo export PATH=$PATH:~/spark-1.6.1-bin-hadoop2.6/bin >> ~/.bashrc

echo "============================Install Docker==============================="
# as per documentations of docker
# make sure apt works with http
cd

sudo apt-get update

sudo apt-get -y install bridge-utils

sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

cd
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > docker.list
sudo mv ./docker.list /etc/apt/sources.list.d/

sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine

sudo apt-get update
sudo apt-get install -y docker-engine
sudo service docker start


echo "=========================Create bridge==================================="
##create bridge to avoid conflict with ip

sudo service docker stop
sudo ip link set dev docker0 down
sudo brctl delbr docker0
sudo iptables -t nat -F POSTROUTING
sudo brctl addbr bridge0
sudo ip addr add 192.168.5.1/24 dev bridge0
sudo ip link set dev bridge0 up
echo 'DOCKER_OPTS="-b=bridge0"' > docker
sudo mv ./docker /etc/default/
sudo service docker start
sudo iptables -t nat -L -n

echo "==========================Add username to docker group=================================="
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
newgrp docker
echo "==========================Clean up======================================="
# Clean-up
cd
rm scala-2.11.8.deb
rm spark-1.6.1-bin-hadoop2.6.tgz
rm StarterScript.sh

echo "=========================Docker Image======================"

docker pull ubuntu:14.04
docker build -t sahandha/ubuntu:14.04 .
