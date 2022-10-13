#!/usr/bin/bash

mk_folder() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Create folder $1"
    fi
}

echo original parameters=[$*]
echo original OPTIND=[$OPTIND]
while getopts ":p:r:d" opt; do
    case $opt in
    p)
        proxy_prefix=$OPTARG
        # echo "this is -p option. OPTARG=[$OPTARG] OPTIND=[$OPTIND]"
        ;;
    r)
        repo_proxy_prefix=$OPTARG
        ;;
    d)
        default=true
        ;;
    ?)
        echo "there is unrecognized parameter."
        exit 1
        ;;
    esac
done

if [ -n "$proxy_prefix" ]; then
    if [ -n "$default" ]; then
        file_prefix="https://cdn.jsdelivr.net/gh/"
    else
        file_prefix=$proxy_prefix"/"
    fi
else
    file_prefix="https://raw.githubusercontent.com/"
fi

if [ -n "$repo_proxy_prefix" ]; then
    if [ -n "$default" ]; then
        repo_prefix="https://github.com.cnpmjs.org/"
    else
        repo_prefix=$repo_proxy_prefix"/"
    fi
else
    repo_prefix="https://github.com/"
fi

# install rust
echo "Check Rust..."
if command -v rustc >/dev/null 2>&1; then
    echo 'Exists Rust...skip intstall!'
else
    echo 'No exists Rust...install Rust!'
    sudo apt install curl -y
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck disable=SC1091
    source "$HOME"/.cargo/env
fi

if [ -n "$default" ]; then
    mk_folder .cargo
    wget --no-check-certificate --content-disposition -P .cargo "$file_prefix"BobAnkh/dotfiles/main/rust/.config
fi

# install gitconfig
wget --no-check-certificate --content-disposition -P "$HOME" "$file_prefix"BobAnkh/dotfiles/main/git/.gitconfig

# install zsh
echo "Install zsh and extensions..."
sudo apt-get install zsh -y

# install zsh extensions
mk_folder .zsh
git clone --depth=1 "$repo_prefix"zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone --depth=1 "$repo_prefix"zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 "$repo_prefix"romkatv/powerlevel10k.git ~/.zsh/powerlevel10k

# use already-written configurations
wget --no-check-certificate --content-disposition "$file_prefix"BobAnkh/dotfiles/main/zsh/.zshrc
wget --no-check-certificate --content-disposition "$file_prefix"BobAnkh/dotfiles/main/zsh/.p10k.zsh
wget --no-check-certificate --content-disposition "$file_prefix"BobAnkh/dotfiles/main/tmux/.tmux.conf

# change shell
chsh -s /usr/bin/zsh

echo "Please logout and login again!"
