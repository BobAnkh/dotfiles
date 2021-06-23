#!/usr/bin/sh

mk_folder() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Create folder $1"
    fi
}


# install zsh
sudo apt-get install zsh -y

# install zsh extensions
mk_folder .zsh
git clone --depth=1 https://github.com.cnpmjs.org/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone --depth=1 https://github.com.cnpmjs.org/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com.cnpmjs.org/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k

# change shell
chsh -s /usr/bin/zsh

# use already-written configurations
wget https://cdn.jsdelivr.net/gh/BobAnkh/dotfiles@main/zsh/.zshrc
wget https://cdn.jsdelivr.net/gh/BobAnkh/dotfiles@main/zsh/.p10k.zsh

echo "Please logout and login again!"
