#!bin/bash
shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Default command line prompt.
PROMPT_DIRTRIM=2
python __load.py
clear
PS1='Root@Hacked_Eye'
export PS1="╭─\Hacked_Eye@Root [~]\ "

__ScriptVersion="0.1.9"

echo -e "Welcome To Hacked-Eye Shell V-0.1.9
Tap [ h/help ] for help & [ kill ] for kill the shell (ie Quit the shell) 
"

# if args have been specified, then
# show the correct syntax to the user
if [ $# -gt 0 ] ; then
  echo "Invalid Syntax!"
  echo "The valid syntax is ./$(basename $0)"
  exit 1
fi

function use_python_color.py () {
python3 -c "$(cat << EOF

print("\033[92m")
	
EOF
)"   
}

function usage () {
     cat <<- EOT
     User : $0 [options] [--]
     Options:
          -h|help          Display for help
          -v|version       Display for version
          -k|kill          Kill the shell
          -neo|neofetch    Display neofetch of os
          -system-profile  Display system prshell
          -reload          Reload thw shell

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
function memory_util ()
{
  BUFFCACHE_MEM=$(free -m | awk '/Mem/ {print $6}')
  FREE_MEM=$(free -m | awk '/Mem/ {print $4}')
  YIELD_MEM=$(( $BUFFCACHE_MEM + $FREE_MEM ))

  AVAILABLE_MEM=$(free -m | awk '/Mem/ {print $7}')
  TOTAL_MEM=$(free -m | awk '/Mem/ {print $2}')

  TOTAL_USED_MEM=$(( $TOTAL_MEM - $AVAILABLE_MEM ))

  #Total memory usage is Total Memory - Available Memory
  MEM_USAGE_PERCENT=$(bc <<<"scale=2; $TOTAL_USED_MEM * 100 / $TOTAL_MEM")

  echo -e "........................................\nMEMORY UTILIZATION\n"
  echo -e "Total Memory\t\t:$TOTAL_MEM MB"
  echo -e "Available Memory\t:$AVAILABLE_MEM MB"
  echo -e "Buffer+Cache Memory\t:$BUFFCACHE_MEM MB"
  echo -e "Free Memory\t\t:$FREE_MEM MB"
  echo -e "Memory Usage Percentage\t:$MEM_USAGE_PERCENT %"

  #if available or (free+buffer+cache) is close to 0
  #We will warn the user if it's below 100 MiB
  if [ $AVAILABLE_MEM -lt 100 -o $YIELD_MEM -lt 100 ] ; then
    echo "Available Memory or the free and buffer+cache Memory is too low!"
    echo "Unhealthy Memory!"
  #if kernel employed OOM Killer process
  elif dmesg | grep oom-killer > /dev/null ; then
    echo "System is critically low on memory!"
  else
    echo -e "\nMEMORY OK\n........................................"
  fi
}
function cpu_util ()
{
  #number of cpu cores
  CORES=$(nproc)

  #cpu load average of 15 minutes
  LOAD_AVERAGE=$(uptime | awk '{print $10}')
  LOAD_PERCENT=$(bc <<<"scale=0; $LOAD_AVERAGE * 100")

  echo -e "........................................\nCPU UTILIZATION\n"
  echo -e "Number of Cores\t:$CORES\n"

  echo -e "Total CPU Load Average for the past 15 minutes\t:$LOAD_AVERAGE"
  echo -e "CPU Load %\t\t\t\t\t:$LOAD_PERCENT"
  echo -e "\nThe load average reading takes into account all the core(s) present in the system"

  #if load average is equal to the number of cores, print warning
  if [[ $(echo "if (${LOAD_AVERAGE} == ${CORES}) 1 else 0" | bc) -eq 1 ]] ; then
    echo "Load average not ideal."
  elif [[ $(echo "if (${LOAD_AVERAGE} > ${CORES}) 1 else 0" | bc) -eq 1 ]] ; then
    echo "Critical! Load average is too high!"
  else
    echo -e "\nCPU LOAD OK"
  fi

  # capturing the second iteration of top and storing the CPU% id.
  IDLE=$(top -b -n2 | awk '/Cpu/ {print $8}' | tail -1)
  CPU_USAGE_PERCENT=$(bc <<<"scale=2; 100 - $IDLE/$CORES")

  echo -e "\nCPU Usage %\t:$CPU_USAGE_PERCENT\n........................................"
}
function disk_util ()
{
  ROOT_DISK_USED=$(df -h | grep -w '/' | awk '{print $5}')
  ROOT_DISK_USED=$(printf %s "$ROOT_DISK_USED" | tr -d [="%"=])
  ROOT_DISK_AVAIL=$(( 100 - $ROOT_DISK_USED ))

  HOME_DISK_USED=$(df -h | grep -w '/home' | awk '{print $5}')
  HOME_DISK_USED=$(printf %s "$HOME_DISK_USED" | tr -d [="%"=])
  HOME_DISK_AVAIL=$(( $HOME_DISK_USED ))

  echo -e "........................................\nDISK UTILIZATION\n"
  echo -e "Root(/) Used\t\t:$ROOT_DISK_USED%"
  echo -e "Root(/) Available\t:$ROOT_DISK_AVAIL%\n"

  echo -e "Home(/home) Used\t:$HOME_DISK_USED%"
  echo -e "Home(/home) Available\t:$HOME_DISK_AVAIL%"

  #print warning if any of the disk is used above 95%
  if [ $ROOT_DISK_USED -ge 95 -o $HOME_DISK_USED -ge 95 ] ; then
    echo -e "\nDisk is almost full! Free up some space!"
  else
    echo -e "\nDISK OK"
  fi
}
function use_cpu ()
{
  memory_util
  cpu_util
  disk_util
}
function load_os_.py () {
python3 -c "$(cat << EOF

import os
import time
from tqdm import tqdm

print("\033[90mRunning System....\033[0m")
time.sleep(1)
os.system('clear')

for i in tqdm(range(100), desc="Loading OS...", ascii=False, ncols=100):
    time.sleep(0.06)

os.system('clear')

logo="""
\033[95m
    %%%%%%%%%%%%%%%   %%%%%%%%%%%%%%
    ===============   ==============
    %#           #$   &$
    %#           #$   %$
    %#           #$   ^$
    %#           #$   %%%%%%%%%%%%%%
    %#           #$               A$
    %#           #$               B$
    %#           #$               C$
    ===============   ==============
    %%%%%%%%%%%%%%%   %%%%%%%%%%%%%%
\033[0m
"""

pattern = logo.strip().split('\n')
for line in pattern:
    print(line)
    time.sleep(0.1)
print('\033[92m')

	
EOF
)"
}

function load_os.sh () {
    clear
    echo "running system...."
    sleep 2
    clear
    load_os_.py
    PSO="╭─\Hacked_Eye@Boot-/__init__/OS"
    while :
    do
        echo -e "$PSO /~ [ $(pwd) ] "
        read command
        case $command in
            htop                ) htop;;
            neo|neofetch        ) neofetch && python color.py;;
            clean               ) clear;;
            kill                ) exit 1 ;;
            * 		        ) $command;;
        esac
    done
}

function main_body() {
     while :
     do
          use_python_color.py
          echo "$PS1 [ $(pwd) ]"
          read command
          case $command in
               h|help           ) usage;;
               v|version        ) echo "$0 --version $__ScriptVersion" ;;
               neo|neofetch     ) if [ -e neofetch ]; then
                                        neofetch
                                   else :
                                        neofetch
                                        python shell_style.py
                                   fi;;
               k|kill           ) exit 1;;
               load_int         ) puss_to_internet;;
               clean            ) clear;;
               system-profile   ) use_cpu;;
               reload           ) clear; echo -e "Reloading..."; clear; bash hacked_eye.sh;;
               loados           ) load_os.sh;;
               *                ) $command; 
                                  use_python_color.py;
          esac
     done
}
main_body
