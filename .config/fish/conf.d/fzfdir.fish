function fzfdir
    set dir (find ~/.dotfiles ~/1-projects ~/2-areas ~/3-resources ~/4-archives -mindepth 1 -maxdepth 2 -type d | fzf)
    if test -n "$dir"
        cd "$dir" && clear
    end
end
