#!/bin/bash
GREEN='\033[0;32m'
BLUE='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'
GITHUB_MAIL='1213@holbertonschool.com'
GITHUB_USERNAME='Juan Lopez'

cd
if [ "$(id -u)" != "0" ]; then
echo -e "${RED}[ERROR]: Please, execute the script with sudo.${NC}"
exit 1
fi
echo -e "${BLUE}UPDATE && UPGRADE !${NC}"
sudo apt-get update -y && sudo apt-get upgrade -y
## Git install
echo -e "${BLUE}[INSTALLING]: GIT !${NC}"
if ! sudo apt-get install git -y; then exit 1; fi
echo -e "${BLUE}[INSTALLING]: EMACS !${NC}"
if ! sudo apt-get install emacs -y; then exit 1; fi
## Betty Coding Style
git clone https://github.com/holbertonschool/Betty.git
echo -e "${BLUE}[INSTALLING]: Betty !${NC}"
cd Betty && sudo ./install.sh
echo -e "${RED}Cleaning Betty directory and deleting ~/.vimrc file${NC}"
sudo rm -Rf ../Betty && sudo rm ~/.emacs
## C indentation
echo -e "${BLUE}Configuring .emacs file with C indentation${NC}"
echo "( setq c-default-style \" bsd \"
     c-basic-offset 8
     tab-width 8
     indent-tabs-mode t )" >> ~/.emacs
echo "(require 'whitespace)" >> ~/.emacs
echo "(setq whitespace-style '(face empty lines-tail trailing))" >> ~/.emacs
echo "(global-whitespace-mode t)" >> ~/.emacs
echo "(setq column-number-mode t)" >> ~/.emacs
echo "(global-linum-mode t)" >> ~/.emacs
echo "(setq-default linum-format \"%4d \u2502 \")" >> ~/.emacs

# Python3 && PEP8
echo -e "${BLUE}[INSTALLING]: PYTHON3 && PEP8 !${NC}"
if ! sudo apt-get install python3-pep8 -y; then
echo -e "${RED}[ERROR]: APT-GET INSTALL - PYTHON3-PEP8 issue.${NC}"
exit 1;
fi
if ! sudo apt-get install python3-pip -y; then
echo -e "${RED}[ERROR]: APT-GET INSTALL - PYTHON3-PIP issue.${NC}"
exit 1;
fi
if ! sudo apt-get install pep8 -y; then
echo -e "${RED}[ERROR]: APT-GET INSTALL - PEP8 issue.${NC}"
exit 1;
fi
cd
if ! sudo pip3 install pep8; then exit 1; fi
sudo rm -Rf /usr/lib/python3*/dist-packages/pep* &&
sudo pip3 install pep8 &&
sudo cp /usr/local/lib/python3*/dist-packages/pep8.py /usr/bin/pep8 &&
sudo chmod u+x /usr/bin/pep8
# Valgrind Installation
echo -e "${BLUE}[INSTALLING]: VALGRIND !${NC}"
sudo apt-get install valgrind -y
# Generate SSH KEY for github
echo -e "${BLUE}Generating SSH KEY AND SETTING UP GITHUB GLOBAL CONFIGURATION${NC}"
#ssh-keygen -t rsa -b 4096 -C ${GITHUB_MAIL} -f $HOME/.ssh/id_rsa
#cat $HOME/.ssh/id_rsa.pub
git config --global user.email ${GITHUB_MAIL}
git config --global user.name ${GITHUB_USERNAME}
git config --global credential.helper store
echo -e "${BLUE}COnfiguration Prompt${NC}"
sed -i "s/#force_color_prompt=yes/force_color_prompt=yes/" ~/.bashrc
echo "parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}" >> ~/.bashrc
echo "export PS1=\"\[\033[38;5;34m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;208m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;69m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] > [\[$(tput sgr0)\]\[\033[38;5;196m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\]]\[\033[38;5;178m\]\$(parse_git_branch)\n\[$(tput sgr0)\]\[\033[38;5;7m\]——\[$(tput sgr0)\]\[\033[38;5;9m\]►\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\"" >> ~/.bashrc
echo -e "${BLUE}execute bash${NC}"
source ~/.bashrc
cd /
echo -e "${BLUE}Stderred"
git clone git://github.com/sickill/stderred.git
cd stderred

sudo apt-get install build-essential cmake -y
make
echo "export LD_PRELOAD=\"$PWD/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}\"" >> ~/.bashrc
cd
echo -e "${GREEN} Install Node 10"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm install semistandard --global
sudo npm install request --global
export NODE_PATH=/usr/lib/node_modules

echo -e "${GREEN} MySQL, MySQLdb and SQLAlchemy "
echo 'deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7-dmr' | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install mysql-server-5.7 -y
mysql --version

sudo apt-get install python3-dev
sudo apt-get install libmysqlclient-dev -y
sudo apt-get install zlib1g-dev
sudo pip3 install mysqlclient==1.3.10

pip3 install SQLAlchemy==1.2.5

curl -o 100-dump.sql "https://s3.amazonaws.com/intranet-projects-files/holbertonschool-higher-level_programming+/290/100-hbnb.sql"
cat 100-dump.sql | sudo mysql -uroot -proot
sudo service mysql start

echo -e "${GREEN} fabric python"

pip3 uninstall Fabric
sudo apt-get install libffi-dev
sudo apt-get install libssl-dev
sudo apt-get install build-essential
sudo apt-get install python3.6-dev
sudo apt-get install libpython3-dev
pip3 install pyparsing
pip3 install appdirs
pip3 install setuptools==40.1.0
pip3 install cryptography==2.8
pip3 install Fabric3==1.14.post1

echo -e "${GREEN} Flask python"

pip3 install Flask
pip3 install flask_cors

sudo apt-get install -y python3-lxml
sudo pip3 install flasgger

echo -e "${GREEN} Restart the terminal"
