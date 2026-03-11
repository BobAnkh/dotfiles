#!/bin/bash
# sudo apt install bat -y
sudo apt install wget build-essential -y
wget --no-check-certificate --content-disposition https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
sudo dpkg -i bat_0.18.3_amd64.deb

# cargo install lsd
wget --no-check-certificate --content-disposition https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb
sudo dpkg -i lsd_0.20.1_amd64.deb

# install rust
if command -v rustc >/dev/null 2>&1; then
	echo 'Exists rustc...skip intstall!'
else
	echo 'No exists rustc...install rust!'
	sudo apt install curl -y
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	# shellcheck disable=SC1091
	source "$HOME"/.cargo/env
fi

cargo install du-dust --locked

cargo install procs --locked

cargo install broot --locked

cargo install zoxide --locked

cargo install git-delta

cargo install hexyl

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz && rm -rf lazygit

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
