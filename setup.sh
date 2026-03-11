#!/bin/bash
# setup.sh - Bootstrap a new machine with dotfiles
#
# Usage: ./setup.sh [--profile PROFILE] [options]
#
# Profiles:
#   dev      Full development workstation (default)
#              installs: rust, ohmyzsh, unix-tool, node, fzf, nvim
#   server   Minimal server setup
#              installs: rust, ohmyzsh, unix-tool
#   minimal  Git config only, no installs
#
# Options:
#   --repo-proxy URL     Proxy prefix for git repo URLs (e.g. mirror for China)
#   --file-proxy URL     Proxy prefix for raw file URLs
#   --rust-change-src    Use USTC mirror for Rust crates
#   --ubuntu-change-src  Use Tsinghua mirror for apt
#   --no-install         Skip tool installation, only deploy dotfiles
#
# Examples:
#   ./setup.sh
#   ./setup.sh --profile server
#   ./setup.sh --profile dev --ubuntu-change-src --rust-change-src
#   ./setup.sh --no-install

PROFILE="dev"
EXTRA_ARGS=()
NO_INSTALL=false

while [[ $# -gt 0 ]]; do
  case $1 in
  --profile | -p)
    PROFILE="$2"
    shift 2
    ;;
  --no-install)
    NO_INSTALL=true
    shift
    ;;
  *)
    EXTRA_ARGS+=("$1")
    shift
    ;;
  esac
done

# Resolve script directory so this works when called from any path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Setting up profile: $PROFILE"

# ─── Copy local.toml template ────────────────────────────────────────────────

TEMPLATE="$SCRIPT_DIR/templates/local-${PROFILE}.toml"
LOCAL_TOML="$SCRIPT_DIR/.dotter/local.toml"

if [ ! -f "$TEMPLATE" ]; then
  echo "Error: Unknown profile '$PROFILE'. Available profiles: dev, server, minimal"
  exit 1
fi

if [ -f "$LOCAL_TOML" ]; then
  echo "==> Existing .dotter/local.toml found, backing up to local.toml.bak"
  cp "$LOCAL_TOML" "$LOCAL_TOML.bak"
fi

cp "$TEMPLATE" "$LOCAL_TOML"
echo "==> Copied $TEMPLATE -> .dotter/local.toml"

# ─── Install tools ───────────────────────────────────────────────────────────

if [ "$NO_INSTALL" = false ]; then
  case "$PROFILE" in
  dev)
    bash "$SCRIPT_DIR/scripts/install.sh" "${EXTRA_ARGS[@]}" rust ohmyzsh unix-tool node fzf nvim claude
    ;;
  server)
    bash "$SCRIPT_DIR/scripts/install.sh" "${EXTRA_ARGS[@]}" rust ohmyzsh unix-tool
    ;;
  minimal)
    # No tool installs for minimal profile
    ;;
  esac
fi

# ─── Deploy dotfiles ─────────────────────────────────────────────────────────

echo "==> Deploying dotfiles..."
"$SCRIPT_DIR/bin/dotter" -f deploy

# ─── Set default shell ───────────────────────────────────────────────────────

if command -v zsh >/dev/null 2>&1; then
  if [ "$SHELL" != "$(which zsh)" ]; then
    echo "==> Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    echo "==> Please log out and back in for the shell change to take effect."
  fi
fi
