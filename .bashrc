# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Use 256 color
TERM=xterm-256color

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# powerline shell
if [ "$TERM" != "linux" ]; then
    source ~/.config/pureline/pureline ~/.config/pureline.conf
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

for file in ~/.{aliases,exports,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# yadm
if [ ! -d /root/.yadm ]; then
    yadm clone https://github.com/akngs/denv-dotfiles
    cp ~/.config/yadm.git.config ~/.yadm/repo.git/config
fi

# vim
if [ ! -f /root/.config/vim-plug-installed ]; then
    vim '+PlugInstall --sync' +qall &> /dev/null
    touch /root/.config/vim-plug-installed
fi
export EDITOR=vim

# pyenv
export PATH="/root/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# poetry
export PATH="/root/.poetry/bin:$PATH"
poetry completions bash > /etc/bash_completion.d/poetry.bash-completion

# misc.
export GPG_TTY=$(tty)

