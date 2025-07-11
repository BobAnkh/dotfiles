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
		rustup component add rust-analyzer
	fi
	# if $1; then
	#     mk_folder .cargo
	#     wget --no-check-certificate --content-disposition -P .cargo "$2"BobAnkh/dotfiles/main/rust/.config
	# fi
}

change_src_ubuntu() {
	sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
	sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
}

# install_gitconfig() {
#     # install gitconfig
#     wget --no-check-certificate --content-disposition -P "$HOME" "$2"BobAnkh/dotfiles/main/git/.gitconfig
# }

install_min_zsh() {
	mk_folder "$HOME"/.zsh
	git clone --depth=1 "$1"zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
	git clone --depth=1 "$1"zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
	git clone --depth=1 "$1"romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
	# wget --no-check-certificate --content-disposition -P "$HOME" "$2"BobAnkh/dotfiles/main/zsh/.zshrc
	# wget --no-check-certificate --content-disposition -P "$HOME" "$2"BobAnkh/dotfiles/main/zsh/.p10k.zsh
	# wget --no-check-certificate --content-disposition -P "$HOME" "$2"BobAnkh/dotfiles/main/tmux/.tmux.conf
}

install_ohmyzsh() {
	# install oh-my-zsh
	# wget --no-check-certificate --content-disposition -P "$HOME" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	# cd "$HOME" && sh install.sh --unattended && rm install.sh
	wget --no-check-certificate --content-disposition -qO https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended

	mk_folder "$HOME"/.oh-my-zsh/custom/themes
	mk_folder "$HOME"/.oh-my-zsh/custom/plugins
	# install powerlevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

	# see https://github.com/zsh-users/zsh-autosuggestions/issues/673
	git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
	git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

	# wget --no-check-certificate --content-disposition -P "$HOME" -O .zshrc "$2"BobAnkh/dotfiles/main/ohmyzsh/.zshrc
	# wget --no-check-certificate --content-disposition -P "$HOME" "$2"BobAnkh/dotfiles/main/ohmyzsh/.p10k.zsh
	# wget --no-check-certificate --content-disposition -P "$HOME" "$2"BobAnkh/dotfiles/main/tmux/.tmux.conf
}

install_zsh() {
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		sudo apt update -y && sudo apt-get install zsh -y
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		brew install zsh
	fi
}

install_modern_unix() {
	mk_folder ~/tools
	if ! command -v rustc >/dev/null 2>&1; then
		install_rust
	fi
	echo "Install modern unix tool collections..."
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		sudo apt update -y && sudo apt install build-essential xclip -y
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		:
	fi

	if ! command -v fd >/dev/null 2>&1; then
		cargo install --locked fd-find
	fi

	if ! command -v rg >/dev/null 2>&1; then
		cargo install --locked ripgrep
	fi

	if ! command -v zellij >/dev/null 2>&1; then
		cargo install --locked zellij
	fi

	if ! command -v zoxide >/dev/null 2>&1; then
		cargo install --locked zoxide
	fi

	if ! command -v delta >/dev/null 2>&1; then
		cargo install git-delta
	fi

	if ! command -v hexyl >/dev/null 2>&1; then
		cargo install hexyl
	fi

	if ! command -v lazygit >/dev/null 2>&1; then
		if [[ "$OSTYPE" == "linux-gnu"* ]]; then
			LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
			curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
			tar xf lazygit.tar.gz lazygit
			sudo install lazygit -D -t /usr/local/bin/
			rm lazygit.tar.gz && rm -rf lazygit
		elif [[ "$OSTYPE" == "darwin"* ]]; then
			brew install lazygit
		fi
	fi
}

install_vscode_cli() {
	curl -L -max-redirs 5 "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" --output code.tar.gz
	tar -zxvf code.tar.gz
	sudo install -s -m 755 -o root -g root code /usr/local/bin
}

install_tpm() {
	git clone "$1"tmux-plugins/tpm ~/.tmux/plugins/tpm
	#     cat <<EOF >~/.tmux.conf
	# set -g @plugin 'tmux-plugins/tpm'
	# set -g @plugin 'tmux-plugins/tmux-sensible'
	# set -g @plugin 'tmux-plugins/tmux-sidebar'
	# run '~/.tmux/plugins/tpm/tpm'
	# EOF
	echo "Please run: tmux source ~/.tmux.conf"
	echo "Please press: prefix+I to install all the plugins"
}

install_nvim() {
	sudo apt install xclip -y
	wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
	sudo apt install ./nvim-linux64.deb
	# git clone "$1"LazyVim/starter ~/.config/nvim
}

install_fzf() {
	mk_folder ~/tools
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/tools/fzf
	cd ~/tools/fzf && ./install --all --completion --key-bindings --no-bash

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
	tpm)
		install_tpm "$REPO_PREFIX"
		;;
	nvim)
		install_nvim "$REPO_PREFIX"
		;;
	fzf)
		install_fzf
		;;
	esac
done
