{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    initExtra = ''
      source "${pkgs.git}/share/bash-completion/completions/git-prompt.sh"
      GIT_PS1_SHOWDIRTYSTATE=1
      GIT_PS1_SHOWSTASHSTATE=1
      GIT_PS1_SHOWUNTRACKEDFILES=1
      GIT_PS1_SHOWUPSTREAM=auto
      PS1='\[\033[01;32m\]\w$(__git_ps1 " \[\033[30m\]⎇  %s")\[\033[00m\] \$ '
    '';
  };
}
