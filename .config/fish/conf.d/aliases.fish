# I'm lazy
alias clr clear

# I'm very lazy
alias cl clear

# Sometimes things just happen
alias cls clear

# THE BLOAT
alias sudo doas

# :)
alias yay paru

# Them walls
alias setwallpaper "hyprctl hyprpaper reload ,$HOME/.dotfiles/walls/evangelion.jpg"

### NAVIGATION ###
alias .. "cd .."
alias ... "cd ../.."
alias .3 "cd ../../.."
alias .4 "cd ../../../.."
alias .5 "cd ../../../../.."

### VIM ###
alias v nvim
alias vi nvim
alias vim nvim

### EMACS ###
alias dooms "~/.config/emacs/bin/doom sync"
alias doomsync "~/.config/emacs/bin/doom sync"
alias doomd "~/.config/emacs/bin/doom doctor"
alias doomdoctor "~/.config/emacs/bin/doom doctor"

### TMUX ###
alias tls "tmux list-sessions"
alias tkas "tmux kill-session -a"

### EZA ###
alias ls "eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll "eza -l -a --color=always --group-directories-first"
alias l ll
alias la "eza -a --color=always --group-directories-first"
alias lld "eza -1 --icons=always -d -T -a --level=1"
alias lld1 "eza -1 --icons=always -d -T -a --level=1"
alias lld2 "eza -1 --icons=always -d -T -a --level=2"
alias lld3 "eza -1 --icons=always -d -T -a --level=3"
alias lld4 "eza -1 --icons=always -d -T -a --level=4"
alias lld5 "eza -1 --icons=always -d -T -a --level=5"
alias lt "eza -aT --color=always --group-directories-first"

### Colorized Grep output ###
alias grep "grep --color=auto"

### GIT ###
alias g git

# Lazygit
alias lg lazygit

# Cursor
alias c cursor

### ZOXIDE ###
alias zoxide-show-query "zoxide query -l -s | less"

### PNPM ###
alias pn pnpm
