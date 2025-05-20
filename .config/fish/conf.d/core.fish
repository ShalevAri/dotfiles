# Update system
alias async "doas pacman -Syu"
alias archsync "doas pacman -Syu"
alias cp "cp -iv"
alias mv "mv -iv"
alias rm "rm -v"
alias mkd "mkdir -pv"
alias cloudencrypt "gpg -c --no-symkey-cache --cipher-algo AES256"
alias makepdf "pdflatex *.tex"
alias viewpdf "zathura *.pdf"

function mvpdf
    makepdf; and viewpdf
end

function ducky
    cd /home/shalev/1-projects/ducky; and pnpm dev
end
