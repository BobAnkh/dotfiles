!#/usr/bin/sh
sudo apt install bat -y

# cargo install lsd
wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb
sudo dpkg -i lsd_0.20.1_amd64.deb

cargo install du-dust

cargo install procs

cargo install broot
