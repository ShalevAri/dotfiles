# Next Steps

This document contains the next steps you need to take in order to finish the installation.

Please do them all, in order of appearance.

## Make Script

Run the `make` script located at `$HOME/personal/dev/make.sh` to finish the installation.

## Ducky Setup

Add `http://localhost:49152?q=%s` as a custom search engine url in Zen.

To change Ducky settings, type `duckylocal` in your browser's search bar after adding the custom ducky search url.

## Neovim Setup

Neovim is not currently set up, this is normal.

To set it up, you need to do the following manually:

1. Delete the `~/.dotfiles/.config/nvim` and `~/.config/nvim` directories
2. Clone the LazyVim repository to `~/.config/nvim`
3. Remove the `.git` directory in `~/.config/nvim`
4. Run `nvim` in your terminal to install LazyVim
5. Delete the newly created `~/.config/nvim` directory (and `~/.dotfiles/.config/nvim` if it was created again)
6. Copy everything from `~/.dotfiles/.config/nvim-files` to `~/.dotfiles/.config/nvim`
7. `cd` into `~/.dotfiles`
8. Run `stow .` to symlink the files
9. Run `nvim` again to install the new plugins
10. You're done!

Do NOT modify the `nvim-files` directory manually.

It should only be modified using the `nvimsync` script located at `$HOME/personal/dev/nvimsync.sh`

## DOOM Emacs

To set up DOOM Emacs, first clone the repository using the below command:

```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
```

Then, run the install script:

```bash
~/.config/emacs/bin/doom install
```

DOOM Emacs should now be installed, however you're still using the default config.

To use the custom config, do the following:

1. Delete the `~/.config/doom` directory (and `~/.dotfiles/.config/doom` if it was created)
2. Rename the `~/.dotfiles/.config/doom-personal` directory to `~/.dotfiles/.config/doom`
3. `cd` into `~/.dotfiles`
4. Run `stow .` to symlink the files
5. Run `emacs` from Rofi
6. Run `SPC h r r` to refresh the packages (you might have gotten a few errors by now, that's fine)

You're done!
