echo "============ Update and install wget and git ====================="
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install wget
sudo apt-get -y install git


echo "==========================Isntalling Java================================="
# Installation of JDK
sudo apt-get -y install default-jre
sudo apt-get -y install default-jdk
sudo apt-get -y install openjdk-7-jre
sudo apt-get -y install openjdk-7-jdk


sudo apt-get -y install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

sudo apt-get -y install oracle-java8-installer

export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
echo export JAVA_HOME=\"/usr/lib/jvm/java-8-oracle\" >> ~/.bashrc

echo "=============================Installing Python=============================="
# Installation of Pyython 2 and 3
sudo apt-get -y install python3 python3-setuptools
sudo apt-get -y install python3-pip
sudo apt-get -y install python3-pip
sudo apt-get -y install python3-matplotlib
sudo apt-get -y install python3-numpy
sudo apt-get -y install python3-scipy

sudo apt-get -y install python python-setuptools
sudo apt-get -y install python-pip
sudo apt-get -y install python-pip
sudo apt-get -y install python-matplotlib
sudo apt-get -y install python-numpy
sudo apt-get -y install python-scipy


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
wget http://www.scala-lang.org/files/archive/scala-2.11.6.deb
sudo dpkg -i scala-2.11.6.deb
sudo apt-get -y update
sudo apt-get -y install scala


echo "===========================Download Spark============================"
# Downloading spark
wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1.tgz
tar -zxf spark-1.6.1.tgz
cd spark-1.6.1

echo "===========================Build Spark using Maven============================"
# Building spark

export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
./dev/change-version-to-2.11.sh
./build/mvn -Pyarn -Phadoop-2.4 -Dhadoop.version=2.4.0 -Dscala-2.11 -Phive -Phive-thriftserver -DskipTests clean package


echo "==========================Clean up========================================="
# Clean-up
cd
rm scala-2.11.6.deb
rm spark-1.6.1.tgz
rm StarterScript.sh
