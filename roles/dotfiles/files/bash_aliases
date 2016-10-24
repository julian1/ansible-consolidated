# deployed by ansible!
# http://unix.stackexchange.com/questions/30925/in-bash-when-to-alias-when-to-script-and-when-to-write-a-function
. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export HISTFILESIZE=40000
export HISTSIZE=40001
export HISTTIMEFORMAT="%T " # "
export EDITOR=vim

# locations
export H=$HOME
export A=$HOME/ansible-tests
export C=$HOME/Config_Stuff2
export D=$HOME/dotfiles
#export L=/var/log

alias a="cd $A"
alias c="cd $C"
alias d="cd $D"
alias e='cd /etc'

alias h="cd $HOME"

alias dmesg='dmesg -T --color=always'
alias less='less -R'
alias vim='vim -p'
alias top='top -d .7'
# just use  cd $(mktemp -d )
# alias tmp='export T=$(mktemp -d); pushd $T'

# alias hs="history" # conflict with h=home
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

alias pt="ping 8.8.8.8 -c 4"
alias pw="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 18 | head -n 1"
alias pr='a2ps -1 -R -f 9'

alias rec="ffmpeg  -f x11grab -s 1920x1200 -r 25 -i :0.0 output.mp4"
alias rec2="ffmpeg -f x11grab -s 1920x1080 -r 25 -i :0.0 output.mp4"

# screen capture, emits a png in folder
alias cap="scrot -d 5"

alias frdate='TZ=Europe/Paris date'

# Single key aliases are idempotent, no rm,cp,mv etc
# alias a=apt-get         # ansible
# alias c=cat             # cd or cat? config_stufff
alias f=find
alias g=git
alias h=history
alias l=less
alias ls='ls --group-directories-first --color=always' # or less, or locate?
alias p=ping
# alias ps='ps auxf'
alias s=sudo
alias t='top -d .7'
alias sc=screen
alias sv='sudo vim -p'
# TODO issue ss conflicts with sockets util, also
alias ss='sudo -s'
alias se='sudo -sE'
alias v='vim -p'

# mkdir and cd into it
mkdir_cd() {
    mkdir $1
    cd $1
}
alias m=mkdir_cd

# chup directory
up() {
    if [ -z "$1" ]; then
      cd ..
    else
      for i in $(seq 1 "$1"); do cd ..; done
    fi
}
alias u=up


# TODO maybe remove since it's a bit specific
function logs() {
  zcat -f $(ls -rv "$1"*) | less;
}

function ll() {
  ls -lh --group-directories-first --color=always $@ | awk '{
    k=0;
    for(i=0;i<=8;i++)
      k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));
      if(k)
        printf("%0o ",k);
      print
    }'
}

# TODO  test which /bin/systemctl
# systemd specific
if [ -f /bin/systemctl ]; then
function start()    { sudo systemctl start $@;   }
function stop()     { sudo systemctl stop $@;    }
function restart()  { sudo systemctl restart $@; }
function status()   { sudo systemctl status $@;  }
function enable()   { sudo systemctl enable $@;  }
function disable()  { sudo systemctl disable $@; }
fi

export PATH="$PATH:$HOME/dotfiles/scripts"


RED="\[\033[1;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[1;32m\]"
BLUE="\[\033[1;34m\]"
NO_COLOUR="\[\033[0m\]"

get_prompt_color() {
    if [ `id -u` -eq 0 ]; then
        echo "$RED"
    else
        echo "$GREEN"
    fi
}

PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}$(get_prompt_color)\u@\h${NO_COLOUR}:${BLUE}\w${NO_COLOUR}\$ "


