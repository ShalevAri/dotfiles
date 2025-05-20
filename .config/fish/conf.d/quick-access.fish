# --- advanced, uses tmux ---
function projects
    echo "Previous directory: $PWD"
    cd ~/1-projects/

    echo "Current directory: $PWD"
end

function areas
    echo "Previous directory: $PWD"
    cd ~/2-areas/

    echo "Current directory: $PWD"
end

function resources
    echo "Previous directory: $PWD"
    cd ~/3-resources/

    echo "Current directory: $PWD"
end

function archives
    echo "Previous directory: $PWD"
    cd ~/4-archives/

    echo "Current directory: $PWD"
end

alias nvd "cd ~/.dotfiles/.config/nvim/"
alias nvimd "cd ~/.dotfiles/.config/nvim/"
alias fshd "cd ~/.dotfiles/.config/fish/"
alias dot "cd ~/.dotfiles/"
alias ghost "cd ~/.dotfiles/.config/ghostty/"
alias dotsc "cd ~/.dotfiles/scripts/"
