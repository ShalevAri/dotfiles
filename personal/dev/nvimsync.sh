#!/usr/bin/env bash

set -euo pipefail

# Color variables
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Message functions
error()   { echo -e "${RED}ERR: $*${NC}"; }
warning() { echo -e "${YELLOW}WARNING: $*${NC}"; }
note()    { echo -e "${BLUE}NOTE: $*${NC}"; }
success() { echo -e "${GREEN}$*${NC}"; }

# Define variables
DOTFILES_DIR="$HOME/.dotfiles"
NVIM_DIR="$DOTFILES_DIR/.config/nvim"
NVIM_FILES_DIR="$DOTFILES_DIR/.config/nvim-files"

# Check if nvim directory exists
if [ ! -d "$NVIM_DIR" ]; then
  error "The nvim directory ($NVIM_DIR) does not exist. Aborting."
  exit 1
fi

# Check if nvim-files directory exists
if [ ! -d "$NVIM_FILES_DIR" ]; then
  error "The nvim-files directory ($NVIM_FILES_DIR) does not exist. Aborting."
  exit 1
fi

# Backup nvim-files directory
note "Creating backup of nvim-files directory..."
if [ -d "$NVIM_FILES_DIR.bak" ]; then
  rm -rf "$NVIM_FILES_DIR.bak" || { error "Failed to remove existing backup. Aborting."; exit 1; }
fi
cp -r "$NVIM_FILES_DIR" "$NVIM_FILES_DIR.bak" || { error "Failed to create backup. Aborting."; exit 1; }
success "Backup created successfully!"

# Remove contents of nvim-files directory
note "Removing contents of nvim-files directory..."
rm -rf "$NVIM_FILES_DIR"/* || { error "Failed to remove contents of nvim-files directory. Aborting."; exit 1; }

# Copy contents from nvim to nvim-files
note "Copying contents from nvim to nvim-files..."
cp -r "$NVIM_DIR"/* "$NVIM_FILES_DIR"/ || { error "Failed to copy contents. Aborting."; exit 1; }

success "Successfully synchronized nvim files!"
note "A backup of the previous nvim-files directory was created at $NVIM_FILES_DIR.bak"
