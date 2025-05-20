# PWDS
function pwds
    # Get the current directory
    set current_dir (pwd)

    # Define custom mappings for directories
    set -l dir_map ~/.dotfiles dotfiles \
        ~/.dotfiles/.config config-dot \
        ~/.dotfiles/.config/nvim nvim-dot \
        ~/.dotfiles/.config/wezterm wezterm-dot \
        ~/.dotfiles/.config/zellij zellij-dot \
        ~/.dotfiles/.config/zellij/layouts zellij-layouts-dot \
        ~/.dotfiles/.config/fish fish-dot \
        ~/.dotfiles/.config/fastfetch fastfetch-dot \
        ~/.dotfiles/homebrew homebrew-dot \
        ~/.dotfiles/scripts scripts-dot \
        ~/.dotfiles/.config/starship starship-dot \
        ~/.config config \
        ~/.config/nvim nvim \
        ~/.config/wezterm wezterm \
        ~/.config/zellij zellij \
        ~/.config/zellij/layouts zellij-layouts \
        ~/.config/fish fish \
        ~/.config/fastfetch fastfetch \
        ~/.config/starship starship
    # Check if the current directory matches any key in the dir_map
    for dir in $dir_map
        if string match -q "$dir" $current_dir
            # If there's a match, print the custom name
            echo $dir_map[(math (contains --index $dir $dir_map) + 1)]
            return
        end
    end

    # If no match, just print the regular pwd result
    echo $current_dir
end
