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
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k

# change shell
chsh -s /usr/bin/zsh

# use already-written configurations
wget https://raw.githubusercontent.com/BobAnkh/dotfiles/main/zsh/.zshrc
wget https://raw.githubusercontent.com/BobAnkh/dotfiles/main/zsh/.p10k.zsh

echo "Please logout and login again!"
