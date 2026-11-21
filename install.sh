#!/usr/bin/env bash
# Dotfiles installer: clones (or updates) the repo and symlinks configs into place.
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/SebastianPerilla/dotfiles/main/install.sh)
set -euo pipefail

REPO="https://github.com/SebastianPerilla/dotfiles.git"
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

command -v git >/dev/null || { echo "git is required"; exit 1; }

if [ -d "$DOTFILES/.git" ]; then
  echo "==> Updating $DOTFILES"
  git -C "$DOTFILES" pull --ff-only
else
  echo "==> Cloning into $DOTFILES"
  git clone "$REPO" "$DOTFILES"
fi

link() {  # link <source> <target>
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "    ok      $dst"; return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP"
    mv "$dst" "$BACKUP/"
    echo "    backup  $dst -> $BACKUP/"
  fi
  ln -s "$src" "$dst"
  echo "    linked  $dst -> $src"
}

echo "==> Linking configs"
link "$DOTFILES/nvim"           "$CONFIG/nvim"
link "$DOTFILES/tmux/tmux.conf" "$CONFIG/tmux/tmux.conf"
link "$DOTFILES/zsh/.zshrc"     "$HOME/.zshrc"
link "$DOTFILES/zsh/.zprofile"  "$HOME/.zprofile"

# Oh My Zsh + plugins (cloned directly so OMZ's installer doesn't overwrite .zshrc)
OMZ="$HOME/.oh-my-zsh"
if [ ! -d "$OMZ" ]; then
  echo "==> Installing Oh My Zsh"
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$OMZ"
fi
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  dir="$OMZ/custom/plugins/$plugin"
  if [ ! -d "$dir" ]; then
    echo "==> Installing $plugin"
    git clone --depth 1 "https://github.com/zsh-users/$plugin" "$dir"
  fi
done

TPM="$CONFIG/tmux/plugins/tpm"
if [ ! -d "$TPM" ]; then
  echo "==> Installing tmux plugin manager"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM"
fi
echo "==> Installing tmux plugins"
"$TPM/bin/install_plugins" >/dev/null 2>&1 || echo "    (run 'prefix + I' inside tmux to install plugins)"

for bin in nvim tmux zsh; do
  command -v "$bin" >/dev/null || echo "!! $bin is not installed"
done

echo "==> Done. Open nvim and lazy.nvim will install plugins on first launch."
