sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install wget
sudo apt-get -y install git


# Installation of JDK
sudo apt-get install default-jre
sudo apt-get install default-jdk
sudo apt-get install openjdk-7-jre
sudo apt-get install openjdk-7-jdk


sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

sudo apt-get install oracle-java7-installer

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


sudo pip3 install pandas
sudo pip3 install seaborn
sudo pip2 install pandas
sudo pip2 install seaborn

sudo pip3 install pyfits
sudo pip2 install pyfits

sudo pip2 install "ipython[notebook]"
sudo pip3 install "ipython[notebook]"

# Installation of scala
wget http://www.scala-lang.org/files/archive/scala-2.11.1.deb
sudo dpkg -i scala-2.11.1.deb
sudo apt-get -y update
sudo apt-get -y install scala

# Installation of sbt
wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.deb
sudo dpkg -i sbt.deb
sudo apt-get -y update
sudo apt-get -y install sbt

# Downloading spark
wget http://d3kbcqa49mib13.cloudfront.net/spark-1.0.0.tgz
tar -zxf spark-1.0.0.tgz
cd spark-1.0.0

# Building spark
./sbt/sbt assembly

# Clean-up
rm scala-2.11.1.deb
rm sbt.deb
rm spark-1.0.0.tgz
rm install.sh
