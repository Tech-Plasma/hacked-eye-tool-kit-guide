#!bin/bash
if [ $# -eq 0 ]; then
    echo -e "$0:Error \n no argument found..!"
fi
__sudo_password="12345"

echo -e "Enter password : "
read password

if [[ $( echo -e "if( ${__sudo_password} == ${password} ) 1 else 0" -eq 1 ) ]]; then
    clear
    echo "running system...."
    sleep 2
    clear
    python system.py
    PSO="╭─\Hacked_Eye@Boot-/__init__/OS"
    while :
    do
        echo -e "$PSO"
        read command
        case $command in
            htop                ) htop;;
            neo|neofetch        ) neofetch && python color.py;;
            clean               ) clear;;
            kill                ) exit 1 ;;
        esac
    done
else:
    echo -e "Password not matched..!"
fi

