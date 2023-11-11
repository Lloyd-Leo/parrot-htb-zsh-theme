# Inspired by heatbytes-zsh.theme
# it seems like ippsec's bash theme


PROMPT='
%F{green}┌─[%f%F{blue}eu-mod-2%f%F{green}]-[%f%n%F{yellow}@%f%F{blue}%m%f%F{green}]-[%f%F{yellow}📁 %~%f%F{green}]-[%f$(get_ip_address)%F{green}]%f
%F{green}└─━ [%f%F{yellow}*%f%F{green}]%f%F{yellow}$(check_root)%f '

RPROMPT='[%F{red}%?%f][git:%F{yellow}$(parse_git_branch)%f]'

get_ip_address()
{
  if [[ -n "$(ifconfig tun0 2>/dev/null)" ]]; then
    echo "%{$fg[green]%}$(ifconfig tun0 | awk '/inet / {print $2}')%{$reset_color%}"
  elif [[ -n "$(ifconfig eth0 2>/dev/null)" ]]; then
    echo "%{$fg[green]%}$(ifconfig eth0 | awk '/inet / {print $2}')%{$reset_color%}"
  else
    echo "%{$fg[red]%}No IP%{$reset_color%}"
  fi
}

function parse_git_branch()
{
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function check_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "#"
    else
        echo "$"
    fi
}
