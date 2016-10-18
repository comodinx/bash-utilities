#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false


### Parse arguments
while getopts ":h" opt; do
    case "${opt}" in
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n logcolors -a lcolors -d 'Print log color information'
    exit 1
fi


### Source function
echo -e 'Reset (Usage: [c:0])'
logtrace '[c:yellow]--------------------'
logtrace '\033[0mReset (033[0m)'

echo -e '\nTable colors'
logtrace '[c:yellow]------------'
logtrace "|\033[4;37m ____Name_____ | Regular Colors_ | ___Bold (b)____ | _Underline (u)_ | Background (bg) | _High Intensity (hi) | _Bold HI (bhi)_ | Backgrounds HI (bghi) \033[0m|" 
logtrace "|  black\t\t\033[0m|  \033[0;30m### (033[0;30m)\033[0m  |  \033[1;30m### (033[1;30m)\033[0m  |  \033[4;30m### (033[4;30m)\033[0m  |  \033[0;40m### (033[0;40m)\033[0m  |  \033[0;90m######## (033[0;90m)\033[0m  |  \033[1;90m### (033[1;90m)\033[0m  |  \033[0;100m######## (033[0;100m)\033[0m  |"
logtrace "|  red\t\t\033[0m|  \033[0;31m### (033[0;31m)\033[0m  |  \033[1;31m### (033[1;31m)\033[0m  |  \033[4;31m### (033[4;31m)\033[0m  |  \033[0;41m### (033[0;41m)\033[0m  |  \033[0;91m######## (033[0;91m)\033[0m  |  \033[1;91m### (033[1;91m)\033[0m  |  \033[0;101m######## (033[0;101m)\033[0m  |"
logtrace "|  green\t\t\033[0m|  \033[0;32m### (033[0;32m)\033[0m  |  \033[1;32m### (033[1;32m)\033[0m  |  \033[4;32m### (033[4;32m)\033[0m  |  \033[0;42m### (033[0;42m)\033[0m  |  \033[0;92m######## (033[0;92m)\033[0m  |  \033[1;92m### (033[1;92m)\033[0m  |  \033[0;102m######## (033[0;102m)\033[0m  |"
logtrace "|  yellow\t\033[0m|  \033[0;33m### (033[0;33m)\033[0m  |  \033[1;33m### (033[1;33m)\033[0m  |  \033[4;33m### (033[4;33m)\033[0m  |  \033[0;43m### (033[0;43m)\033[0m  |  \033[0;93m######## (033[0;93m)\033[0m  |  \033[1;93m### (033[1;93m)\033[0m  |  \033[0;103m######## (033[0;103m)\033[0m  |"
logtrace "|  blue\t\t\033[0m|  \033[0;34m### (033[0;34m)\033[0m  |  \033[1;34m### (033[1;34m)\033[0m  |  \033[4;34m### (033[4;34m)\033[0m  |  \033[0;44m### (033[0;44m)\033[0m  |  \033[0;94m######## (033[0;94m)\033[0m  |  \033[1;94m### (033[1;94m)\033[0m  |  \033[0;104m######## (033[0;104m)\033[0m  |"
logtrace "|  purple\t\033[0m|  \033[0;35m### (033[0;35m)\033[0m  |  \033[1;35m### (033[1;35m)\033[0m  |  \033[4;35m### (033[4;35m)\033[0m  |  \033[0;45m### (033[0;45m)\033[0m  |  \033[0;95m######## (033[0;95m)\033[0m  |  \033[1;95m### (033[1;95m)\033[0m  |  \033[0;105m######## (033[0;105m)\033[0m  |"
logtrace "|  cyan\t\t\033[0m|  \033[0;36m### (033[0;36m)\033[0m  |  \033[1;36m### (033[1;36m)\033[0m  |  \033[4;36m### (033[4;36m)\033[0m  |  \033[0;46m### (033[0;46m)\033[0m  |  \033[0;96m######## (033[0;96m)\033[0m  |  \033[1;96m### (033[1;96m)\033[0m  |  \033[0;106m######## (033[0;106m)\033[0m  |"
logtrace "|  white\t\t\033[0m|  \033[0;37m### (033[0;37m)\033[0m  |  \033[1;37m### (033[1;37m)\033[0m  |  \033[4;37m### (033[4;37m)\033[0m  |  \033[0;47m### (033[0;47m)\033[0m  |  \033[0;97m######## (033[0;97m)\033[0m  |  \033[1;97m### (033[1;97m)\033[0m  |  \033[0;107m######## (033[0;107m)\033[0m  |"

echo -e '\nUsage'
logtrace '[c:yellow]-----'
logtrace 'Syntax'
logtrace '\t[c:<YOUR_SELECTED_COLOR><YOUR_SELECTED_COLOR_TYPE>]'
logtrace '\nExample'
echo -e '\tCyan [c:cyan]'
logtrace '\t[c:cyan]This is a cyan text without type'
echo -e '\tCyan Bold High Intensity [c:cyanbhi]'
logtrace '\t[c:cyanbhi]This is a cyan text with type bold high intensity'
logtrace '\nCode'
echo -e '\t\033[1;30mlogtrace "[c:cyan]This is a cyan text without type"'
echo -e '\t\033[1;30mlogtrace "[c:cyanbhi]This is a cyan text with type bold high intensity"'
