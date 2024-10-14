

# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTCONTROL=ignoredups:ignorespace
HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs



if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
  . "/nix/store/14izq6jjd2l24w2p4j4xmkfkp0521vr0-bash-completion-2.13.0/etc/profile.d/bash_completion.sh"
fi

source "/nix/store/vdd8ccp9x69v7kp5g9khq7j43n6dqf16-git-2.44.1/share/bash-completion/completions/git-prompt.sh"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto
PS1='\[\033[01;32m\]\w$(__git_ps1 " \[\033[30m\]⎇  %s")\[\033[00m\] \$ '

GPG_TTY="$(tty)"
export GPG_TTY

eval "$(/nix/store/kj5k2wvwvqh2vnfndm82dpcr4canwyrn-direnv-2.34.0/bin/direnv hook bash)"

