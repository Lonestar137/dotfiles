alias doom-sync="~/.emacs.d/bin/doom sync"

alias console-in="sudo screen /dev/ttyUSB0 9600"
#alias vim="/usr/local/bin/nvim.appimage"
#alias vim = "nvim"
#alias vi = "nvim"

alias wttr="curl wttr.in"

#dmesg | grep 'tty' and/or 'serial' to see.

alias gdev="cd /usr/local/"

alias gitree="git log --graph --decorate --oneline --all"
alias poll-snmp="snmpwalk -v 2c -c aldotrosnmp $1 $2"

#Brightness control TODO: brightness scripts that check for brightness and set it, prevent from going too dark.
alias blow="sudo brightnessctl set 5%"
alias bmid="sudo brightnessctl set 20%"
alias bhigh="sudo brightnessctl set 50%"
alias bmax="sudo brightnessctl set 100%"
alias bd="sudo brightnessctl set 10%-"
alias bu="sudo brightnessctl set +10%"

# Rust coreutil alts
alias cat="bat --theme gruvbox-dark"
alias ls="exa -l --icons"

# Notetaking
NOTEDIR=/home/jonesgc/Documents/TIL/
alias note="ranger ~/Documents/ranger-notes/snippets"
alias til="ranger ${NOTEDIR}"
alias ntil='FILENAME=$(date +%m-%d-%y) && if [ ! -s "${NOTEDIR}${FILENAME}.yml" ]; then echo "${FILENAME}: \n---" >> "${NOTEDIR}${FILENAME}.yml"; fi && lvim "${NOTEDIR}"'


# cp/mv with progress bar
alias rcp="rsync -aP"
alias rmv='rsync -aP --remove-source-files'

# fuzzy find
alias fd='cd "$(exa -DR | awk '\''!/^$/ && /.\// {gsub(/:$/, ""); print}'\'' | fzf)"'
alias vf='lvim "$(exa -DR | awk '\''!/^$/ && /.\// {gsub(/:$/, ""); print}'\'' | fzf)"'

