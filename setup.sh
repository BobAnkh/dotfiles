#!/usr/bin/bash

bash scripts/install.sh --rust-change-source --repo-proxy "https://ghproxy.com/https://github.com/" --file-proxy "https://ghproxy.com/https://raw.githubusercontent.com/" rust gitconfig unix-tool ohmyzsh

# change shell
chsh -s "$(which zsh)"

echo "Please logout and login again!"
