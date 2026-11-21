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

Existing configs are moved to `~/.dotfiles-backup/<timestamp>/`. It also installs
Oh My Zsh (+ zsh-autosuggestions, zsh-syntax-highlighting), TPM and the tmux plugins; Neovim plugins install on first launch via lazy.nvim.

Requires: `git`, `nvim` (0.10+), `tmux` (3.2+).

Machine-specific settings or secrets go in `~/.zshrc.local` (sourced automatically, not tracked).
