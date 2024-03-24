#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# //////////////////////////////////////////////////////////////////////////// Color settings
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# //////////////////////////////////////////////////////////////////////////// Prompt settings
git_branch() {
    # git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

get_python_environment() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo -n "${VIRTUAL_ENV##*/}"
    fi
}
# PS1='[\u@\h \W]\$ '
# PS1='\u@\h \w$(__git_ps1 " (%s)") $ '

P_USER='\[\e[1;32m\]\u\[\e[0m\]'
P_HOST='\[\e[1;35m\]\h\[\e[0m\]'
P_DIR='\[\e[1;34m\]\w\[\e[0m\]'
P_PYTHON_ENV='\[\e[1;31m\]$(get_python_environment)\[\e[0m\]'
P_BRANCH='\[\e[1;33m\]$(git_branch)\[\e[0m\]'


PROMPT_COMMAND='PS1="[$P_USER@$P_HOST in $P_DIR]$P_PYTHON_ENV $P_BRANCH $ "'

# //////////////////////////////////////////////////////////////////////////// Environment Variables
export VISUAL=hx
export EDITOR=hx


# //////////////////////////////////////////////////////////////////////////// Path settings
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin/note-grep/src"
export PATH="$PATH:$HOME/.local/bin/renpy-8.1.1-sdk"
export PATH="$PATH:$HOME/.config/emacs/bin"



[ -f "/home/jonesgc/.ghcup/env" ] && source "/home/jonesgc/.ghcup/env" # ghcup-env
[ -f "/home/jonesgc/.bash_aliases" ] && source "/home/jonesgc/.bash_aliases"
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/lib/mojo
export PATH=$PATH:~/.modular/pkg/packages.modular.com_mojo/bin/

source ~/.config/zoxide/config.sh
