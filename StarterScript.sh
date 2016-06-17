# set the hostname in /etc/hosts
sudo sed -i 's/127.0.0.1 localhost/127.0.0.1 localhost $HOSTNAME/g' /etc/hosts

echo "============ Update and install wget and git ====================="
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install wget
sudo apt-get -y install git


echo "==========================Isntalling Java================================"
# Installation of JDK
sudo apt-get -y install default-jre
sudo apt-get -y install default-jdk


echo "============================Installing Python============================"
# Installation of Pyython 2 and 3
# sudo apt-get -y install python-software-properties
# sudo apt-get -y install python3 python3-setuptools
# sudo apt-get -y install python3-pip
# sudo apt-get -y install python3-pip
# sudo apt-get -y install python3-matplotlib
# sudo apt-get -y install python3-numpy
# sudo apt-get -y install python3-scipy
#
# sudo apt-get -y install python python-setuptools
# sudo apt-get -y install python-pip
# sudo apt-get -y install python-pip
# sudo apt-get -y install python-matplotlib
# sudo apt-get -y install python-numpy
# sudo apt-get -y install python-scipy


echo "============================Python Libraries============================="
# sudo pip3 install pandas
# sudo pip3 install seaborn
# sudo pip2 install pandas
# sudo pip2 install seaborn
#
# sudo pip3 install pyfits
# sudo pip2 install pyfits
#
# sudo pip2 install "ipython[notebook]"
# sudo pip3 install "ipython[notebook]"


echo "===============================Scala installation================================="
# Installation of scala
wget http://www.scala-lang.org/files/archive/scala-2.10.6.deb
sudo dpkg -i scala-2.10.6.deb
sudo apt-get -y update

echo "===========================Download Spark============================"
# Downloading spark
wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz
tar -zxf spark-1.6.1-bin-hadoop2.6.tgz
cd /spark-1.6.1-bin-hadoop2.6/conf
cp log4j.properties.template log4j.properties
sed -i 's/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g' ./log4j.properties

cd
export PATH=$PATH:~/spark-1.6.1-bin-hadoop2.6/bin
echo export PATH=$PATH:~/spark-1.6.1-bin-hadoop2.6/bin >> ~/.bashrc

# export SPARK_LOCAL_IP=127.0.0.1
# echo export SPARK_LOCAL_IP=127.0.0.1 >> ~/.bashrc



echo "==========================Clean up======================================="
# Clean-up
cd
rm scala-2.10.6.deb
rm spark-1.6.1-bin-hadoop2.6
rm StarterScript.sh
