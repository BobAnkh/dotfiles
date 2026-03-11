#!/bin/bash

mk_folder() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
    echo "Create folder $1"
  fi
}

install_rust() {
  echo "Check Rust..."
  if command -v rustc >/dev/null 2>&1; then
    echo 'Exists Rust...skip install!'
  else
    echo 'No exists Rust...install Rust!'
    sudo apt install curl -y
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck disable=SC1091
    source "$HOME"/.cargo/env
    rustup component add rust-analyzer
  fi
}

change_src_ubuntu() {
  sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
  sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
}

install_min_zsh() {
  if [ -d "$HOME/.zsh/powerlevel10k" ]; then
    echo 'Exists minimal zsh plugins...skip install!'
    return
  fi
  mk_folder "$HOME"/.zsh
  git clone --depth=1 "$1"zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
  git clone --depth=1 "$1"zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  git clone --depth=1 "$1"romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
}

install_ohmyzsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo 'Exists oh-my-zsh...skip install!'
    return
  fi
  wget --no-check-certificate --content-disposition -qO - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended

  mk_folder "$HOME"/.oh-my-zsh/custom/themes
  mk_folder "$HOME"/.oh-my-zsh/custom/plugins
  # install powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
  # see https://github.com/zsh-users/zsh-autosuggestions/issues/673
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
}

install_zsh() {
  if command -v zsh >/dev/null 2>&1; then
    echo 'Exists zsh...skip install!'
    return
  fi
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

  if ! command -v dust >/dev/null 2>&1; then
    cargo install du-dust --locked
  fi

  if ! command -v procs >/dev/null 2>&1; then
    cargo install procs --locked
  fi

  if ! command -v broot >/dev/null 2>&1; then
    cargo install broot --locked
  fi

  if ! command -v bat >/dev/null 2>&1; then
    cargo install bat --locked
  fi

  if ! command -v lsd >/dev/null 2>&1; then
    cargo install lsd --locked
  fi

  if ! command -v lazygit >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      cd ~/tools || exit 1
      LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
      curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
      tar xf lazygit.tar.gz lazygit
      sudo install lazygit -D -t /usr/local/bin/
      rm lazygit.tar.gz && rm -f lazygit
      cd - || exit 1
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      brew install lazygit
    fi
  fi
}

install_vscode_cli() {
  if command -v code >/dev/null 2>&1; then
    echo 'Exists VS Code CLI...skip install!'
    return
  fi
  curl -L -max-redirs 5 "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" --output code.tar.gz
  tar -zxvf code.tar.gz
  sudo install -s -m 755 -o root -g root code /usr/local/bin
  rm -f code.tar.gz code
}

install_tpm() {
  if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo 'Exists tmux plugin manager...skip install!'
    return
  fi
  git clone "$1"tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "Please run: tmux source ~/.tmux.conf"
  echo "Please press: prefix+I to install all the plugins"
}

install_nvim() {
  if command -v nvim >/dev/null 2>&1; then
    echo 'Exists nvim...skip install!'
    return
  fi
  mk_folder ~/tools
  sudo apt install -y ninja-build gettext cmake unzip curl build-essential
  git clone https://github.com/neovim/neovim ~/tools/neovim
  cd ~/tools/neovim || exit 1
  # Checkout the latest stable tag
  NVIM_TAG=$(git describe --tags "$(git rev-list --tags --max-count=1)")
  echo "Building neovim $NVIM_TAG..."
  git checkout "$NVIM_TAG"
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd - || exit 1
}

install_fzf() {
  if command -v fzf >/dev/null 2>&1; then
    echo 'Exists fzf...skip install!'
    return
  fi
  mk_folder ~/tools
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/tools/fzf
  ~/tools/fzf/install --all --completion --key-bindings --no-bash
}

install_node() {
  if [ -d "$HOME/.nvm" ]; then
    echo 'Exists nvm...skip install!'
    return
  fi
  # Download and install nvm:
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  # in lieu of restarting the shell
  \. "$HOME/.nvm/nvm.sh"
  # Download and install Node.js:
  nvm install 22
}

install_docker() {
  if command -v docker >/dev/null 2>&1; then
    echo 'Exists docker...skip install!'
    return
  fi
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sudo sh /tmp/get-docker.sh
  rm -f /tmp/get-docker.sh
  sudo usermod -aG docker "$USER"
  echo "Note: log out and back in for docker group to take effect"
}

install_claude() {
  if command -v claude >/dev/null 2>&1; then
    echo 'Exists claude...skip install!'
  else
    curl -fsSL https://claude.ai/install.sh | bash
    curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
  fi

  # Install plugins (idempotent - claude plugin install skips already-installed ones)
  if command -v claude >/dev/null 2>&1; then
    echo "Installing Claude Code plugins..."
    claude plugin install pyright-lsp@claude-plugins-official
    claude plugin install rust-analyzer-lsp@claude-plugins-official
    claude plugin install superpowers@claude-plugins-official
    claude plugin install feature-dev@claude-plugins-official
    claude plugin install context7@claude-plugins-official
    claude plugin install code-review@claude-plugins-official
    claude plugin install github@claude-plugins-official
  else
    echo "Warning: claude not found after install, skipping plugin install"
  fi
}

# ─── Argument Parsing ────────────────────────────────────────────────────────

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
  --help | -h)
    echo "Usage: install.sh [options] <packages...>"
    echo ""
    echo "Options:"
    echo "  --repo-proxy URL     Proxy prefix for git repo URLs"
    echo "  --file-proxy URL     Proxy prefix for raw file URLs"
    echo "  --rust-change-src    Use USTC mirror for Rust crates"
    echo "  --ubuntu-change-src  Use Tsinghua mirror for apt"
    echo ""
    echo "Packages:"
    echo "  rust       Rust toolchain (rustup)"
    echo "  ohmyzsh    Oh My Zsh + powerlevel10k + plugins"
    echo "  min-zsh    Minimal zsh setup without oh-my-zsh"
    echo "  unix-tool  Modern unix tools (fd, rg, zellij, zoxide, delta, bat, lsd, ...)"
    echo "  node       Node.js via nvm"
    echo "  fzf        Fuzzy finder"
    echo "  nvim       Neovim (compiled from latest stable tag)"
    echo "  vsc-cli    VS Code CLI"
    echo "  tpm        Tmux Plugin Manager"
    echo "  docker     Docker + Docker Compose"
    echo "  claude     Claude CLI"
    exit 0
    ;;
  --repo-proxy | -r)
    REPO_PROXY="https://github.com/"
    if [ -n "$2" ]; then
      REPO_PROXY="$2"
      shift
    fi
    shift
    ;;
  --file-proxy | -f)
    FILE_PROXY="https://raw.githubusercontent.com/"
    if [ -n "$2" ]; then
      FILE_PROXY="$2"
      shift
    fi
    shift
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
    POSITIONAL_ARGS+=("$1")
    shift
    ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

REPO_PREFIX=${REPO_PROXY:-"https://github.com/"}
FILE_PREFIX=${FILE_PROXY:-"https://raw.githubusercontent.com/"}
RUST_CHANGE_SOURCE=${RUST_CHANGE_SOURCE_ARG:-false}

for arg in "$@"; do
  case $arg in
  rust)
    install_rust "$RUST_CHANGE_SOURCE" "$FILE_PREFIX"
    echo "Install rust done!"
    ;;
  ohmyzsh)
    install_zsh
    install_ohmyzsh "$REPO_PREFIX" "$FILE_PREFIX"
    echo "Install ohmyzsh done!"
    ;;
  min-zsh)
    install_zsh
    install_min_zsh "$REPO_PREFIX" "$FILE_PREFIX"
    echo "Install minimal zsh done!"
    ;;
  unix-tool)
    install_modern_unix
    echo "Install unix tools done!"
    ;;
  node)
    install_node
    echo "Install node done!"
    ;;
  fzf)
    install_fzf
    echo "Install fzf done!"
    ;;
  nvim)
    install_nvim
    echo "Install nvim done!"
    ;;
  vsc-cli)
    install_vscode_cli
    echo "Install VS Code CLI done!"
    ;;
  tpm)
    install_tpm "$REPO_PREFIX"
    echo "Install tpm done!"
    ;;
  docker)
    install_docker
    echo "Install docker done!"
    ;;
  claude)
    install_claude
    echo "Install claude done!"
    ;;
  *)
    echo "Unknown package: $arg"
    exit 1
    ;;
  esac
done
