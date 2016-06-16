echo "============ Update and install wget and git ====================="
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install wget
sudo apt-get -y install git


echo "==========================Isntalling Java================================="
# Installation of JDK
sudo apt-get install default-jre
sudo apt-get install default-jdk
sudo apt-get install openjdk-7-jre
sudo apt-get install openjdk-7-jdk


sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

sudo apt-get install -y oracle-java8-installer


echo "=============================Installing Python=============================="
# Installation of Pyython 2 and 3
sudo apt-get install -y python3 python3-setuptools
sudo apt-get install -y python3-pip
sudo apt-get install python3-pip
sudo apt-get install -y python3-matplotlib
sudo apt-get install -y python3-numpy
sudo apt-get install -y python3-scipy

sudo apt-get install -y python python-setuptools
sudo apt-get install -y python-pip
sudo apt-get install python-pip
sudo apt-get install -y python-matplotlib
sudo apt-get install -y python-numpy
sudo apt-get install -y python-scipy


echo "==============================Python Libraries==============================="
sudo pip3 install pandas
sudo pip3 install seaborn
sudo pip2 install pandas
sudo pip2 install seaborn

sudo pip3 install pyfits
sudo pip2 install pyfits

sudo pip2 install "ipython[notebook]"
sudo pip3 install "ipython[notebook]"


echo "===============================Scala installation================================="
# Installation of scala
wget http://www.scala-lang.org/files/archive/scala-2.11.1.deb
sudo dpkg -i scala-2.11.1.deb
sudo apt-get -y update
sudo apt-get -y install scala

# Installation of sbt
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get install sbt


echo "===========================Download and build spark============================"
# Downloading spark
wget http://d3kbcqa49mib13.cloudfront.net/spark-1.0.0.tgz
tar -zxf spark-1.0.0.tgz
cd spark-1.0.0

# Building spark
./sbt/sbt assembly

# Clean-up
cd
rm scala-2.11.1.deb
rm sbt.deb
rm spark-1.0.0.tgz
rm StarterScript.sh
