# Instructions

These dotfiles require you to use your system in a certain way.

It is recommended you read the entirety of this file before using your new system.

## Updating the system

To update your system, only use the `sysmain` script found in `$HOME/personal/dev/sysmain.sh`.

## Installing packages

If a package you want to install can be installed using `pacman`, please add it to the package list in `$HOME/personal/dev/packages.sh` as well as the `setup.sh` script.

Then, run the `packages.sh` script to install the new package(s).

## Neovim

When making changes to your neovim configuration, only modify the `~/.dotfiles/.config/nvim` directory.

DO NOT modify any of the following directories:

- `~/.config/nvim`
- `~/.dotfiles/.config/nvim-files`
- `~/.config/nvim-files`

After making changes you want to keep, run the `nvimsync` script found in `$HOME/personal/dev/nvimsync.sh`.

This will sync the changes from `~/.dotfiles/.config/nvim` to the `~/.dotfiles/.config/nvim-files` directory.
