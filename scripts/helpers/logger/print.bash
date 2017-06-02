#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
message=''


### Parse arguments
while getopts ":m:h" opt; do
    case "${opt}" in
        m)  message=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n logprint -a lprint -d 'Print log message' -o '-m Log message'
    exit 0
fi


### Source function
message=$message"[c:0]"

# Reset
message="${message//\[c:0\]/\\033[0m}"

# Black
message="${message//\[c:black\]/\\033[0;30m}"
message="${message//\[c:blackb\]/\\033[1;30m}"
message="${message//\[c:blacku\]/\\033[4;30m}"
message="${message//\[c:blackbg\]/\\033[0;40m}"
message="${message//\[c:blackhi\]/\\033[0;90m}"
message="${message//\[c:blackbhi\]/\\033[1;90m}"
message="${message//\[c:blackbghi\]/\\033[0;100m}"

# Red
message="${message//\[c:red\]/\\033[0;31m}"
message="${message//\[c:redb\]/\\033[1;31m}"
message="${message//\[c:redu\]/\\033[4;31m}"
message="${message//\[c:redbg\]/\\033[0;41m}"
message="${message//\[c:redhi\]/\\033[0;91m}"
message="${message//\[c:redbhi\]/\\033[1;91m}"
message="${message//\[c:redbghi\]/\\033[0;101m}"

# Green
message="${message//\[c:green\]/\\033[0;32m}"
message="${message//\[c:greenb\]/\\033[1;32m}"
message="${message//\[c:greenu\]/\\033[4;32m}"
message="${message//\[c:greenbg\]/\\033[0;42m}"
message="${message//\[c:greenhi\]/\\033[0;92m}"
message="${message//\[c:greenbhi\]/\\033[1;92m}"
message="${message//\[c:greenbghi\]/\\033[0;102m}"

# Yellow
message="${message//\[c:yellow\]/\\033[0;33m}"
message="${message//\[c:yellowb\]/\\033[1;33m}"
message="${message//\[c:yellowu\]/\\033[4;33m}"
message="${message//\[c:yellowbg\]/\\033[0;43m}"
message="${message//\[c:yellowhi\]/\\033[0;93m}"
message="${message//\[c:yellowbhi\]/\\033[1;93m}"
message="${message//\[c:yellowbghi\]/\\033[0;103m}"

# Blue
message="${message//\[c:blue\]/\\033[0;34m}"
message="${message//\[c:blueb\]/\\033[1;34m}"
message="${message//\[c:blueu\]/\\033[4;34m}"
message="${message//\[c:bluebg\]/\\033[0;44m}"
message="${message//\[c:bluehi\]/\\033[0;94m}"
message="${message//\[c:bluebhi\]/\\033[1;94m}"
message="${message//\[c:bluebghi\]/\\033[0;104m}"

# Purple
message="${message//\[c:purple\]/\\033[0;35m}"
message="${message//\[c:purpleb\]/\\033[1;35m}"
message="${message//\[c:purpleu\]/\\033[4;35m}"
message="${message//\[c:purplebg\]/\\033[0;45m}"
message="${message//\[c:purplehi\]/\\033[0;95m}"
message="${message//\[c:purplebhi\]/\\033[1;95m}"
message="${message//\[c:purplebghi\]/\\033[0;105m}"

# Cyan
message="${message//\[c:cyan\]/\\033[0;36m}"
message="${message//\[c:cyanb\]/\\033[1;36m}"
message="${message//\[c:cyanu\]/\\033[4;36m}"
message="${message//\[c:cyanbg\]/\\033[0;46m}"
message="${message//\[c:cyanhi\]/\\033[0;96m}"
message="${message//\[c:cyanbhi\]/\\033[1;96m}"
message="${message//\[c:cyanbghi\]/\\033[0;106m}"

# White
message="${message//\[c:white\]/\\033[0;37m}"
message="${message//\[c:whiteb\]/\\033[1;37m}"
message="${message//\[c:whiteu\]/\\033[4;37m}"
message="${message//\[c:whitebg\]/\\033[0;47m}"
message="${message//\[c:whitehi\]/\\033[0;97m}"
message="${message//\[c:whitebhi\]/\\033[1;97m}"
message="${message//\[c:whitebghi\]/\\033[0;107m}"

echo -e $message
