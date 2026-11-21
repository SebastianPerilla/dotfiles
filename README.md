# dotfiles

My tmux and Neovim (NvChad) configs.

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

Existing configs are moved to `~/.dotfiles-backup/<timestamp>/`. It also installs
TPM and the tmux plugins; Neovim plugins install on first launch via lazy.nvim.

Requires: `git`, `nvim` (0.10+), `tmux` (3.2+).
