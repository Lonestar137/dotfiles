alias roam="cd ~/Desktop/roam/org-roam-library/"
alias doom-sync="~/.emacs.d/bin/doom sync"

alias console-in="sudo screen /dev/ttyUSB0 9600"
#alias vim = "nvim"
#alias vi = "nvim"

alias wttr="curl wttr.in"

#dmesg | grep 'tty' and/or 'serial' to see.


alias key-help="echo 'ctrl shft v p'; echo 'right red = ctrl; left red = alt'"


alias gdev="cd /usr/local/"

#alias vim="/usr/local/bin/nvim.appimage"
alias vim="nvim"

alias gitree="git log --graph --decorate --oneline"
alias poll-snmp="snmpwalk -v 2c -c aldotrosnmp $1 $2"

alias ssm="python3 /usr/local/bin/ssm/main.py"


#Brightness control TODO: brightness scripts that check for brightness and set it, prevent from going too dark.
alias blow="sudo brightnessctl set 5%"
alias bmid="sudo brightnessctl set 20%"
alias bhigh="sudo brightnessctl set 50%"
alias bmax="sudo brightnessctl set 100%"
alias bd="sudo brightnessctl set 10%-"
alias bu="sudo brightnessctl set +10%"
