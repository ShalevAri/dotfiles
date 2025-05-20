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

# Check if scripts exist
PATH="$HOME/personal/dev"
SYSMAIN_SCRIPT="$PATH/sysmain.sh"
PACKAGES_SCRIPT="$PATH/packages.sh"
GIT_SCRIPT="$PATH/git.sh"
NVIMSYNC_SCRIPT="$PATH/nvimsync.sh"

for script in "$SYSMAIN_SCRIPT" "$PACKAGES_SCRIPT" "$GIT_SCRIPT" "$NVIMSYNC_SCRIPT"; do
    if [ ! -f "$script" ]; then
        error "Script not found: $script"
        exit 1
    fi
    if [ ! -x "$script" ]; then
        note "Making script executable: $script"
        chmod +x "$script"
    fi
done

# Run scripts in order
note "Running system maintenance..."
"$SYSMAIN_SCRIPT" || { error "System maintenance failed"; exit 1; }

note "Installing packages..."
"$PACKAGES_SCRIPT" || { error "Package installation failed"; exit 1; }

note "Configuring git..."
"$GIT_SCRIPT" || { error "Git configuration failed"; exit 1; }

note "Synchronizing nvim files..."
"$NVIMSYNC_SCRIPT" || { error "Nvim synchronization failed"; exit 1; }

success "All scripts completed successfully!"

