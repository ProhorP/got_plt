#/bin/bash
sudo apt install -y gcc snap
sudo snap install radare2 --classic
echo 'export PATH="$PATH:/snap/bin"' >> ~/.bashrc
echo "alias r2='radare2.r2'" >> ~/.bashrc
source ~/.bashrc
