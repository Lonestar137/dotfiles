
# //////////////////////////////////////////////////////////////////////////// Notegrep settings
# NOTEDIR=$(toml get $HOME/.config/note-grep.toml note.note_dir | sed 's/"//g')
# alias til="ranger ${NOTEDIR}"
# alias ntil='FILENAME=$(date +%m-%d-%y) && if [ ! -s "${NOTEDIR}${FILENAME}.md" ]; then echo "${FILENAME}:
# ---" >> "${NOTEDIR}${FILENAME}.md"; fi && $EDITOR "${NOTEDIR}${FILENAME}.md"'


alias ssm='hname=`grep -e "^Host" ~/.ssh/config | fzf --height=30% --layout=reverse | awk '\'' {print $2}'\''`; ssh $hname'


alias python=python3.10
alias ll='eza -la'

alias rmspaces='for f in *\ *; do mv "$f" "${f// /_}"; done'

alias rc='wf-recorder -g "$(slurp)" -o /home/$USER/Downloads/Videos/video-$(date +"%Y-%m-%d_%H-%M-%S").mkv'

alias ll='ls -alF'
alias grep='grep --color=auto'

# pactl list sinks | grep -B1 -A9 State:
# pactl set-sink-volume @DEFAULT_SINK@ 100%
