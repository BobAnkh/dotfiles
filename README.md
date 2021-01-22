# dotfile

A repo to place my dotfiles

## zsh

```shell
# prepare
sudo apt-get install zsh -y
sudo apt-get install zsh-autosuggestions zsh-syntax-highlighting -y
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# change default shell
chsh -s /usr/bin/zsh
echo 'source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc
echo 'source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >>~/.zshrc
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

Then configure it as the suggestion or copy the dotfile `.zshrc` and `.p10k.zsh`

