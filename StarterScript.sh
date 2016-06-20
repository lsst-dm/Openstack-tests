# set the hostname in /etc/hosts
sudo sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts

echo "============ Update and install wget and git ====================="
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install wget
sudo apt-get -y install git


echo "==========================Isntalling Java================================"
# Installation of JDK
sudo apt-get -y install default-jre
sudo apt-get -y install default-jdk


echo "============================Python Libraries============================="
sudo pip install pandas
sudo pip install seaborn
sudo pip install pyfits
sudo pip install "ipython[notebook]"


echo "===============================Scala installation================================="
# Installation of scala
wget http://www.scala-lang.org/files/archive/scala-2.10.6.deb
sudo dpkg -i scala-2.10.6.deb
sudo apt-get -y update
sudo apt-get -y insall scala

sudo aptget -f install

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

echo "==========================Clean up======================================="
# Clean-up
cd
rm scala-2.10.6.deb
rm spark-1.6.1-bin-hadoop2.6.tgz
rm StarterScript.sh
