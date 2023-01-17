#!/bin/bash

mk_folder() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Create folder $1"
    fi
}

install_rust() {
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
    if $1; then
        mk_folder .cargo
        wget --no-check-certificate --content-disposition -P .cargo "$2"BobAnkh/dotfiles/main/rust/.config
    fi
}

change_src_ubuntu() {
    sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
    sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
}

install_gitconfig() {
    # install gitconfig
    wget --no-check-certificate --content-disposition -P "$HOME" "$2"BobAnkh/dotfiles/main/git/.gitconfig
}

install_min_zsh() {
    mk_folder .zsh
    git clone --depth=1 "$1"zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
    git clone --depth=1 "$1"zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    git clone --depth=1 "$1"romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
    wget --no-check-certificate --content-disposition "$2"BobAnkh/dotfiles/main/zsh/.zshrc
    wget --no-check-certificate --content-disposition "$2"BobAnkh/dotfiles/main/zsh/.p10k.zsh
    wget --no-check-certificate --content-disposition "$2"BobAnkh/dotfiles/main/tmux/.tmux.conf
}

install_ohmyzsh() {
    # install oh-my-zsh
    wget --no-check-certificate --content-disposition "$2"ohmyzsh/ohmyzsh/master/tools/install.sh
    sh install.sh --skip-chsh && rm install.sh

    # install powerlevel10k
    git clone --depth=1 "$1"romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

    # see https://github.com/zsh-users/zsh-autosuggestions/issues/673
    git clone --depth=1 "$1"zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
    git clone --depth=1 "$1"zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

    wget --no-check-certificate --content-disposition "$2"BobAnkh/dotfiles/main/ohmyzsh/.zshrc
    wget --no-check-certificate --content-disposition "$2"BobAnkh/dotfiles/main/ohmyzsh/.p10k.zsh
    wget --no-check-certificate --content-disposition "$2"BobAnkh/dotfiles/main/tmux/.tmux.conf
}

install_zsh() {
    sudo apt update -y && sudo apt-get install zsh -y
}

install_modern_unix() {
    if command -v rustc >/dev/null 2>&1; then
        sudo apt update -y && sudo apt install build-essential -y
        cargo install fd-find
        cargo install ripgrep
    else
        install_rust
    fi
}

install_vscode_cli() {
    curl -L -max-redirs 5 "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" --output code.tar.gz
    tar -zxvf code.tar.gz
    sudo install -s -m 755 -o root -g root code /usr/local/bin
}

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
    --help | -h)
        exit 1
        ;;
    --repo-proxy | -r)
        REPO_PROXY="https://github.com/"
        if [ -n "$2" ]; then
            REPO_PROXY="$2"
            shift # past value 
        fi
        shift # past argument
        ;;
    --file-proxy | -f)
        FILE_PROXY="https://raw.githubusercontent.com/"
        if [ -n "$2" ]; then
            FILE_PROXY="$2"
            shift # past value
        fi
        shift # past argument
        ;;
    --rust-change-src)
        RUST_CHANGE_SOURCE_ARG=true
        shift
        ;;
    --ubuntu-change-src)
        change_src_ubuntu
        shift
        ;;
    --* | -*)
        echo "Unknown option $1"
        exit 1
        ;;
    *)
        POSITIONAL_ARGS+=("$1") # save positional arg
        shift                   # past argument
        ;;
    esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

REPO_PREFIX=${REPO_PROXY:-"https://github.com/"}
FILE_PREFIX=${FILE_PROXY:-"https://raw.githubusercontent.com/"}
RUST_CHANGE_SOURCE=${RUST_CHANGE_SOURCE_ARG:-false}

for arg in "$@"; do
    case $arg in
    rust)
        install_rust "$RUST_CHANGE_SOURCE" "$FILE_PREFIX"
        echo "Install rust done!"
        ;;
    gitconfig)
        install_gitconfig "$REPO_PREFIX" "$FILE_PREFIX"
        echo "Install gitconfig done!"
        ;;
    min-zsh)
        install_zsh
        install_min_zsh "$REPO_PREFIX" "$FILE_PREFIX"
        echo "Install minimal zsh done!"
        ;;
    ohmyzsh)
        install_zsh
        install_ohmyzsh "$REPO_PREFIX" "$FILE_PREFIX"
        echo "Install ohmyzsh done!"
        ;;
    unix-tool)
        install_modern_unix
        ;;
    vsc-cli)
        install_vscode_cli
        ;;
    esac
done
