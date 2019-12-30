
# path completion for commonly used paths...

# this provides cd tab completion and suggestions for common paths
# would be really nice if could have something similar that would replace current string
# to use in contexts other that cd

_foo() 
{
  # see, https://debian-administration.org/article/317/An_introduction_to_bash_completion_part_2
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

  # COMP_CWORD  is number of arguments
  # cur is the current arg.  so we just need to matchj
  #   echo $COMP_CWORD

    prev="${COMP_WORDS[COMP_CWORD-1]}"
    # opts="--help --verbose --version"
    opts=". open-trade nspawn backup ansible-consolidated nixos-config Config_Stuff2 devel07/me devel07/downloads devel07.old/downloads nixos03/me"

    #if [[ ${cur} == -* ]] ; then
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
    #fi
}
complete -F _foo h 

function h() {

  # if [ -z "$1" ];                       then echo 'unrecognized path';
  if [ -z "$1" ];                       then cd '/home/me/';
  #elif [ $1 = '.' ];                    then cd '/home/me/'; # fi;

  elif [ $1 = 'open-trade' ];           then cd '/home/me/devel/haskell/open-trade/'; 
  #elif [ $1 = 'nspawn' ];              then cd '/home/me/devel/nspawn/'; 
  elif [ $1 = 'nspawn' ];               then cd '/home/me/nspawn/'; 
  elif [ $1 = 'backup' ];               then cd '/mnt/drive/backup/'; 
  elif [ $1 = 'ansible-consolidated' ]; then cd '/home/me/devel/ansible-consolidated/'; 
  elif [ $1 = 'nixos-config' ];         then cd '/home/me/devel/nixos-config/'; 

  elif [ $1 = 'Config_Stuff2' ];        then cd '/home/me/Config_Stuff2/'; 

  elif [ $1 = 'devel07/me'   ];         then cd '/home/large/nspawn/devel07.chroot/home/me/'; 
  elif [ $1 = 'devel07/downloads' ];    then cd '/home/large/nspawn/devel07.chroot/var/lib/transmission-daemon/downloads/'; 
  elif [ $1 = 'devel07.old/downloads' ]; then cd '/home/large/nspawn/devel07.chroot.old/var/lib/transmission-daemon/downloads/'; 

 

  elif [ $1 = 'nixos03/me'   ];         then cd '/home/large/nspawn/nixos03.chroot/home/me/'; 
  else 
    echo 'unrecognized path';
  fi;

  #if [ $1 = 'home' ];       then cd '/home/me/'; fi;
  # ok we can do tab completion, buy just using a set/map
  # echo 'hi'
  

};


