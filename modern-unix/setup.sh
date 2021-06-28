!#/usr/bin/sh
sudo apt install bat -y

# cargo install lsd
wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb
sudo dpkg -i lsd_0.20.1_amd64.deb

# install rust
if command -v rustc >/dev/null 2>&1; then
    echo 'Exists rustc...skip intstall!'
else
    echo 'No exists rustc...install rust!'
    curl https://sh.rustup.rs -sSf | sh -s
    # shellcheck disable=SC1091
    source "$HOME"/.cargo/env
fi

cargo install du-dust

cargo install procs

cargo install broot
