set fish_greeting
set TERM xterm-256color

# Set default editor and manpager to neovim
set -x EDITOR "emacsclient -t -a ''"
set -x VISUAL "emacsclient -c -a emcas"
set -x MANPAGER "nvim +Man!"

# Enable vi mode
function fish_user_key_bindings
    fish_vi_key_bindings

end

# Set theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# Zellij
set -x ZELLIJ_CONFIG_FILE $HOME/.config/zellij/config.kdl

# Rust stuff
set -x PATH $HOME/.cargo/bin $PATH

# Bat theme
set -x BAT_THEME Catppuccin-mocha

# Initialize Starship
starship init fish | source

# Initialize zoxide
zoxide init fish | source

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Go
set -gx GOPATH $HOME/go
set -U fish_user_paths $GOPATH/bin $HOME/.local/bin $fish_user_paths

# Add Doom Emacs bin to PATH
set -gx PATH $PATH $HOME/.config/emacs/bin

# fzf
fzf --fish | source

# Set the starship config to use
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
