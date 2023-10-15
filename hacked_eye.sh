#!bin/bash 
shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Default command line prompt.
PROMPT_DIRTRIM=2
python __load.py
PS1='Root@Hacked_Eye'
export PS1="╭─\Hacked_Eye@Root"

__ScriptVersion="0.0.1"

function usage () {
     cat <<- EOT
     User : $0 [options] [--]
     Options:
          -h|help          Display for help 
          -v|version       Display for version 
          -k|kill          Kill the shell 
          -neo|neofetch    display neofetch of os
          
EOT
}
function puss_to_internet () {
     export PS1="╭─\Hacked_Eye@Internet"
     read int_command 
     
     while :
     do 
          case $int_command in
               
          esac 
     done 
}
while :
do 
     echo "$PS1"
     read command 
     case $command in 
          h|help           ) usage;;
          v|version        ) echo "$0 --version $__ScrScriptVersion" ;;
          neo|neofetch     ) neofetch;;
          k|kill           ) exit 1;;
          load_int         ) puss_to_internet;;
          clean            ) clear;;
          \?               ) echo "$command: Command not found!";;
     esac
done
