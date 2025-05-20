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

DUCKY_DIR="$HOME/1-projects/ducky"

if [ ! -d "$DUCKY_DIR" ]; then
    error "Ducky directory does not exist"
    exit 1
fi

if [ -z "$(ls -A "$DUCKY_DIR")" ]; then
    error "Ducky directory is empty"
    exit 1
fi

if [ ! -d "$DUCKY_DIR/node_modules" ]; then
    error "node_modules directory not found. Please run 'pnpm install' inside the ducky directory first"
    exit 1
fi

cd "$DUCKY_DIR"
pnpm dev &