# dotfiles

My zsh, tmux and Neovim (NvChad) configs.

## Install

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/SebastianPerilla/dotfiles/main/install.sh)
```

Or:

```sh
git clone https://github.com/SebastianPerilla/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

The script clones the repo to `~/dotfiles` and symlinks:

| Repo              | Location                     |
|-------------------|------------------------------|
| `nvim/`           | `~/.config/nvim`             |
| `tmux/tmux.conf`  | `~/.config/tmux/tmux.conf`   |
| `zsh/.zshrc`      | `~/.zshrc`                   |
| `zsh/.zprofile`   | `~/.zprofile`                |
| `herdr/templates/` | `~/.config/herdr-core/templates` |

Existing configs are moved to `~/.dotfiles-backup/<timestamp>/`. It also installs
Oh My Zsh (+ zsh-autosuggestions, zsh-syntax-highlighting), zoxide, pixi, TPM and the tmux plugins; Neovim plugins install on first launch via lazy.nvim.

Requires: `git`, `nvim` (0.10+), `tmux` (3.2+).

Machine-specific settings or secrets go in `~/.zshrc.local` (sourced automatically, not tracked).

## WSL2

Works on WSL2 (Ubuntu). Before running the installer, inside WSL:

```sh
sudo apt update && sudo apt install -y git curl zsh tmux build-essential unzip ripgrep
chsh -s "$(which zsh)"
```

- Neovim: apt's version is too old for NvChad (needs 0.10+). Install the latest release, e.g.
  `curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz && sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim`
- Install a Nerd Font on **Windows** and select it in Windows Terminal, so icons render.
- Run the installer from WSL's own filesystem (`~`), not under `/mnt/c`.
- `copy` / `contopen` aliases automatically use `clip.exe` / `explorer.exe` under WSL.
