#!/usr/bin/bash

bash scripts/install.sh --rust-change-src --repo-proxy "https://github.com/" --file-proxy "https://raw.githubusercontent.com/" rust unix-tool ohmyzsh

# change shell
chsh -s "$(which zsh)"

./bin/dotter -f deploy

echo "Please logout and login again!"
