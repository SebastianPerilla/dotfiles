# =============================================================================
# Oh My Zsh
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Keep plugin list minimal; order matters.
# - zsh-autosuggestions should load late
# - zsh-syntax-highlighting should be the LAST plugin
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# Zoxide (smart cd)
# =============================================================================
# Must load AFTER Oh My Zsh: oh-my-zsh.sh is what runs compinit, and zoxide's
# init script registers its completion via compdef, which doesn't exist yet
# on a fresh shell if this runs first. That's why `cd <Tab>` only worked
# after manually re-sourcing this file (compinit had run by then).

# Remove any previous alias named 'z' created by themes/plugins to avoid conflicts
unalias z 2>/dev/null

# Initialize zoxide if installed
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  # Optional: make `cd` automatically use zoxide's logic
  alias cd='z'
fi

# =============================================================================
# User Functions & Aliases
# =============================================================================

# Build helper (keeps your original logic)
cmk() {
  if [[ ! -f "CMakeLists.txt" ]]; then
    echo "❌ No CMakeLists.txt found here. Please cd into your project folder first."
    return 1
  fi

  cmake -B build
  mkdir -p build
  cd build || return 1

  cmake .. \
    -DCMAKE_C_COMPILER=gcc-14 \
    -DCMAKE_CXX_COMPILER=g++-14 \
    -DCMAKE_CXX_STANDARD=23 \
    -DCMAKE_CXX_STANDARD_REQUIRED=ON \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_TOOLCHAIN_FILE=~/vcpkg/scripts/buildsystems/vcpkg.cmake\
    || { echo "❌ CMake configuration failed"; cd ..; return 1; }

  cmake --build . \
    || { echo "❌ Build failed"; cd ..; return 1; }

  cd ..
  echo ":) Build complete with GCC 14 + C++23"
}

# Handy aliases
alias zshconfig="nvim ~/.zshrc"
alias ghostconfig="nvim ~/.config/ghostty/config"
alias tmuxconf="nvim ~/.config/tmux/tmux.conf"
alias v="nvim"

# General Aliases
alias copy="xclip -selection clipboard"
alias contopen="xdg-open ."

# C++ Aliases
alias rmain="./src/main"
alias cbuild="cmake -B build"
alias cbcfirst="cmake --build build --clean-first"

# uv/Python aliases
alias activate="source .venv/bin/activate"


export DUCKDB_EDITOR="nvim -u ~/.config/nvim/init.lua"

export PATH="$HOME/vcpkg:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# GCC Debug Flags Shell Variable
export gccdebug=@"$HOME/cppUtils"/debug.flags
export VCPKG_DISABLE_METRICS=1
# =============================================================================
# NVM (Node Version Manager)
# =============================================================================
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh"          ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# =============================================================================
# Conda - managed by conda
# =============================================================================
__conda_setup="$("$HOME/conda/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [[ $? -eq 0 ]]; then
  eval "$__conda_setup"
else
  if [[ -f "$HOME/conda/etc/profile.d/conda.sh" ]]; then
    . "$HOME/conda/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/conda/bin:$PATH"
  fi
fi
unset __conda_setup

# Pixi 

export PATH="$HOME/.pixi/bin:$PATH"

# Google Cloud SDK
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/opt/google-cloud-sdk/path.zsh.inc"
fi

# Google Cloud SDK completion
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/opt/google-cloud-sdk/completion.zsh.inc"
fi

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Machine-specific settings and secrets (not tracked in dotfiles)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
