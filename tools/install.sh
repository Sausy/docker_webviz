sudo apt-get update && \
sudo apt-get install -y git nano curl sudo man wget unzip tar gnupg2 lsb-release\
vim lsb-release build-essential autoconf libtool cmake pkg-config \
python3-dev python3 python3-pip && \
DEBIAN_FRONTEND=noninteractive sudo apt-get install -qq tzdata

#====== install dev package =====
#    pip install --upgrade pip && \
sudo apt install -y vim lsb-release build-essential autoconf libtool cmake pkg-config && \
sudo apt install -y python3-dev python3 python3-pip && \
pip3 install --user --upgrade pip


#====== install docker spezific stuff =====
sudo groupadd docker

sudo gpasswd -a $USER docker
sudo mkdir ~/.docker
sudo chown $USER:docker ~/.docker


sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose
pip install docker-squash

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo chown $USER:docker ~/.docker

sudo service docker restart
