# dotfiles

A repo to place my dotfiles

```shell
wget --no-check-certificate --content-disposition https://ghproxy.com/https://raw.githubusercontent.com/BobAnkh/dotfiles/main/scripts/install.sh
bash install.sh --rust-change-source --repo-proxy "https://ghproxy.com/https://github.com/" --file-proxy "https://ghproxy.com/https://raw.githubusercontent.com/" rust gitconfig unix-tool ohmyzsh
chsh -s "$(which zsh)"
```

## zsh

```shell
# prepare
sudo apt-get install zsh -y
mkdir .zsh
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k

# change default shell
chsh -s /usr/bin/zsh

# turn on the extension or just use already-written dotfile
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc
echo 'source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >>~/.zshrc
echo 'source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
# wget https://raw.githubusercontent.com/BobAnkh/dotfiles/main/zsh/.zshrc
```

Then configure it as the suggestion or copy the dotfile `.zshrc` and `.p10k.zsh`

## docker network

```shell
docker network create -d bridge --ipv6 --subnet="2604:abc0:64:3902:62eb::/80" --gateway="2604:abc0:64:3902:62eb::1" --subnet="172.19.0.0/16" --gateway="172.19.0.1" proxy
```
