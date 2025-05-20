#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

error() { echo -e "${RED}ERR: $*${NC}"; }
warning() { echo -e "${YELLOW}WARNING: $*${NC}"; }
note() { echo -e "${BLUE}NOTE: $*${NC}"; }
success() { echo -e "${GREEN}$*${NC}"; }

PACKAGES_1=("bat" "blueman" "bluez" "bluez-tools" "bluez-utils" "cava" "eza" "fastfetch" "fd" "fish")

PACKAGES_2=("fzf" "ghostty" "nautilus" "git" "hyprlock" "hyprpaper" "jujutsu" "lazygit" "neovim" "pnpm")

PACKAGES_3=("ripgrep" "starship" "stow" "tmux" "waybar" "zoxide" "ttf-font-awesome" "papirus-icon-theme" "rofi-wayland" "rofi-emoji")

PACKAGES_4=("rofi-calc" "dunst" "font-manager" "emacs" "wlogout")

PACKAGES=("${PACKAGES_1[@]}" "${PACKAGES_2[@]}" "${PACKAGES_3[@]}" "${PACKAGES_4[@]}")

update_system() {
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
}

should_update=false
if [[ $# -eq 1 ]]; then
  case "$1" in
  "-u")
    should_update=true
    ;;
  "-nu")
    should_update=false
    ;;
  *)
    error "Invalid argument. Use -u to update, -nu to skip update, or no arguments for interactive mode."
    exit 1
    ;;
  esac
else
  while true; do
    read -rp "Would you like to update the system before installing packages? (y/n): " answer
    case "${answer,,}" in
    y | yes)
      should_update=true
      break
      ;;
    n | no)
      should_update=false
      break
      ;;
    *)
      warning "Please answer with yes or no (y/n)"
      ;;
    esac
  done
fi

if [ "$should_update" = true ]; then
  update_system
fi

note "Checking for packages that are not yet installed..."
TO_INSTALL=()
for pkg in "${PACKAGES[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    TO_INSTALL+=("$pkg")
  fi
done

if [ ${#TO_INSTALL[@]} -eq 0 ]; then
  success "All packages are already installed!"
  exit 0
fi

note "Installing packages: ${TO_INSTALL[*]}..."
sudo pacman -S --noconfirm "${TO_INSTALL[@]}"
if [ $? -ne 0 ]; then
  error "An error occurred while trying to install packages. Aborting."
  exit 1
fi
success "All packages installed successfully!"