sudo apt update
sudo apt upgrade -y

sudo apt install -y software-properties-common python3 python3-pip
sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install -y ansible

ansible --version
