#!/usr/bin/env bash

################################################################################
#
# Title: Arch Linux w/ Hyprland setup script
# Description: Setup Arch Linux with Hyprland, Fish, and a bunch of other stuff.
# Author: Shalev Ari
#
################################################################################

set -euo pipefail

# Color variables
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Message functions
error() { echo -e "${RED}ERR: $*${NC}"; }
warning() { echo -e "${YELLOW}WARNING: $*${NC}"; }
note() { echo -e "${BLUE}NOTE: $*${NC}"; }
success() { echo -e "${GREEN}$*${NC}"; }

if [ "$EUID" -eq 0 ]; then
  error "Please do not run this script as root. Aborting."
  exit 1
fi

if ((BASH_VERSINFO[0] < 4)); then
  error "Bash 4+ is required to run this script. Aborting."
  exit 1
fi

if ! command -v sudo &>/dev/null; then
  error "sudo is not installed. Aborting."
  exit 1
fi

# Define variables
PACKAGES=("bat" "blueman" "bluez" "bluez-tools" "bluez-utils" "cava" "eza" "fastfetch" "fd" "fish" "fzf" "ghostty" "nautilus" "git" "hyprlock" "hyprpaper" "jujutsu" "lazygit" "neovim" "pnpm" "ripgrep" "starship" "stow" "tmux" "waybar" "zoxide" "ttf-font-awesome" "papirus-icon-theme" "rofi-wayland" "rofi-emoji" "rofi-calc" "dunst" "font-manager" "emacs" "wlogout")
DOTFILES_DIR="$HOME/.dotfiles"
GITHUB_REPO="ShalevAri/dotfiles"

is_installed() {
  pacman -Q "$1" &>/dev/null
}

# Update system
note "Updating system..."
sudo pacman -Syu --noconfirm
if [ $? -ne 0 ]; then
  error "An error occurred while trying to update the system. Aborting."
  exit 1
fi

if ! pacman -Qqg base-devel &>/dev/null; then
  note "Installing base-devel..."
  sudo pacman -S --needed --noconfirm base-devel
fi

# Install packages
note "Installing packages..."
sudo pacman -S --noconfirm "${PACKAGES[@]}"
if [ $? -ne 0 ]; then
  error "An error occurred while trying to install packages. Aborting."
  exit 1
fi
success "All packages installed successfully!"

# Install Paru (AUR helper)
note "Checking for Paru (AUR helper)..."
if ! command -v paru &>/dev/null; then
  warning "Paru is not installed. Installing Paru..."
  git clone https://aur.archlinux.org/paru.git /tmp/paru-install || {
    error "Failed to clone Paru AUR repo. Aborting."
    exit 1
  }
  cd /tmp/paru-install || {
    error "Failed to enter Paru build directory. Aborting."
    exit 1
  }
  makepkg -si --noconfirm || {
    error "Failed to build/install Paru. Aborting."
    exit 1
  }
  cd ~ || {
    error "Failed to change directory to home. Aborting."
    exit 1
  }
  rm -rf /tmp/paru-install || {
    error "Failed to remove Paru build directory. Aborting."
    exit 1
  }
  success "Paru successfully installed!"
else
  warning "Paru is already installed."
fi

# Create Dotfiles directory
if [ -d "$DOTFILES_DIR" ]; then
  if [ "$(ls -A "$DOTFILES_DIR")" ]; then
    warning "The Dotfiles directory ($DOTFILES_DIR) already exists and is not empty."
    note "What would you like to do?"
    echo -e "  [a] Abort the script and do nothing"
    echo -e "  [d] Delete everything inside $DOTFILES_DIR"
    echo -e "  [b] Move everything inside $DOTFILES_DIR to $DOTFILES_DIR.bak and continue"
    read -r -p "Enter your choice (a/d/b): " dir_action
    case "$dir_action" in
    a | A)
      warning "Aborting script. No changes were made to $DOTFILES_DIR."
      exit 0
      ;;
    d | D)
      warning "Deleting all contents of $DOTFILES_DIR..."
      rm -rf "$DOTFILES_DIR"/* "$DOTFILES_DIR"/.[!.]* "$DOTFILES_DIR"/..?* 2>/dev/null || true
      # Re-create directory in case it was deleted
      mkdir -p "$DOTFILES_DIR"
      success "All contents successfully deleted."
      ;;
    b | B)
      BACKUP_DIR="$DOTFILES_DIR.bak"
      warning "Moving all contents of $DOTFILES_DIR to $BACKUP_DIR..."
      mkdir -p "$BACKUP_DIR"
      shopt -s dotglob nullglob
      for f in "$DOTFILES_DIR"/* "$DOTFILES_DIR"/.[!.]* "$DOTFILES_DIR"/..?*; do
        [ -e "$f" ] && mv "$f" "$BACKUP_DIR"/
      done
      shopt -u dotglob nullglob
      success "All contents successfully moved to $BACKUP_DIR."
      ;;
    *)
      error "Invalid choice. Aborting script."
      exit 1
      ;;
    esac
  else
    warning "The Dotfiles directory ($DOTFILES_DIR) already exists and is empty. Continuing..."
  fi
else
  note "Creating the Dotfiles directory for you..."
  mkdir -p "$DOTFILES_DIR" || {
    error "Failed to create the Dotfiles directory ($DOTFILES_DIR). Aborting."
    exit 1
  }
  success "Dotfiles directory successfully created!"
fi

# Clone Dotfiles from remote GitHub repository
note "Cloning Dotfiles from the https://github.com/$GITHUB_REPO repository..."
git clone "https://github.com/$GITHUB_REPO" "$DOTFILES_DIR" || {
  error "An error occurred while trying to clone the Dotfiles repository. Please check the repository URL and your credentials."
  error "Aborting."
  exit 1
}
success "Dotfiles successfully cloned!"

# Remove default Hyprland config if it exists to avoid stow conflicts
if [ -d "$HOME/.config/hypr" ]; then
  warning "A default Hyprland config was found at $HOME/.config/hypr. It will be deleted to avoid conflicts with the dotfiles."
  read -r -p "Proceed with the deletion of $HOME/.config/hypr? [y/N]: " hypr_delete_confirm
  note "Your windows might move or look different, and you may get a warning at the top of your screen. This is normal."
  case "$hypr_delete_confirm" in
  y | Y)
    rm -rf "$HOME/.config/hypr" || {
      error "Failed to delete $HOME/.config/hypr. Aborting."
      exit 1
    }
    success "Default Hyprland config successfully deleted."
    ;;
  *)
    warning "User chose not to delete $HOME/.config/hypr. Stowing dotfiles will probably fail."
    ;;
  esac
fi

# Stowing Dotfiles
note "Stowing Dotfiles..."
cd "$DOTFILES_DIR" || {
  error "Error changing directory to $DOTFILES_DIR. Aborting."
  exit 1
}
stow . || {
  error "An error occurred while trying to stow the dotfiles"
  warning "The issue might be conflicting files/directories between the ~/.config and ~/.dotfiles directories."
  warning "Try removing only the conflicting items from the ~/.config directory and then run this script again"
  error "Aborting."
  exit 1
}
success "Successfully stowed the dotfiles!"

# Changing SHELL to Fish
note "Changing the default shell to Fish..."
FISH_PATH="$(command -v fish)"
if [ "$SHELL" != "$FISH_PATH" ]; then
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  chsh -s "$FISH_PATH" || {
    error "There was an error while trying to change the default shell to fish."
    warning "You may need to do this manually by running 'chsh -s $(command -v fish)'."
  }
  success "Successfully changed the default shell to Fish!"
else
  warning "Fish is already the default shell."
fi
note "This requires a restart to take effect."

# Creating PARA directories
note "Creating PARA directories..."
mkdir -p "$HOME/1-projects" "$HOME/2-areas" "$HOME/3-resources" "$HOME/4-archives" || {
  error "An error occurred while trying to create the PARA directories. Aborting."
  exit 1
}
success "PARA directories successfully created!"

# Setting up Ducky
note "Setting up Ducky..."
mkdir -p "$HOME/1-projects/ducky" || {
  error "An error occurred while trying to create the Ducky directory. Aborting."
  exit 1
}

note "Cloning Ducky repository..."
git clone "https://github.com/ShalevAri/ducky.git" "$HOME/1-projects/ducky" || {
  error "Failed to clone the Ducky repository. Aborting."
  exit 1
}

note "Installing Ducky dependencies..."
cd "$HOME/1-projects/ducky" || {
  error "Failed to change directory to $HOME/1-projects/ducky. Aborting."
  exit 1
}

if ! command -v pnpm &>/dev/null; then
  error "pnpm is not installed. Aborting."
  exit 1
fi

pnpm install || {
  error "Failed to install Ducky dependencies. Aborting."
  exit 1
}

success "Ducky successfully installed!"

success "Setup complete! Please reboot your system for changes to take effect."
note "Simply type 'reboot' in your terminal to do so."
note "After rebooting, follow the instructions in the NEXT_STEPS.md file to complete the installation."

