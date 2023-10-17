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
function int_help () {
     cat <<- EOT 
     --[Under Construction]-- 
     
     User : $0 [options] [--]
     Options:
          -h|help          Display for help 
          -connect         To connect your Internet 
          -vpn             To connect through VPN 
          -k|kill_int      Kill the shell 
          
EOT
}
function puss_to_internet () {
     export PS1="╭─\Hacked_Eye@Internet"
     #echo "$PS1"
     #read int_command 
     while :
     do 
          echo "$PS1"
          read int_command
          case $int_command in
               h|help      ) int_help;;
               connect     ) if [ -f "internet_connect.sh" ]; then 
                                   internet_connect.sh 
                              else : 
                                   echo "$0: error internet_connect not found.!" 
                              fi ;; 
               vpn         ) if [ -f "internet_connect.sh" ]; then 
                                   if [ -f "vpn.py" ]; then 
                                        python vpn.py 
                                   else : 
                                        echo "vpn not found..!" 
                                   fi 
                              else : 
                                   echo "$0: Error" 
                              fi;; 
               k|kill_int  ) export PS1="╭─\Hacked_Eye@Root" && main_body;; 
               \?          ) echo "$int_command: Command not found.!";;
          esac 
     done 
}
function main_body() {
     while :
     do 
          echo "$PS1"
          read command 
          case $command in 
               h|help           ) usage;;
               v|version        ) echo "$0 --version $__ScriptVersion" ;;
               neo|neofetch     ) if [ -e neofetch ]; then 
                                        neofetch 
                                   else : 
                                        pkg install neofetch && neofetch 
                                   fi;;
               k|kill           ) exit 1;;
               load_int         ) puss_to_internet;;
               clean            ) clear;;
               \?               ) echo "$command: Command not found!";;
          esac
     done
}
main_body
