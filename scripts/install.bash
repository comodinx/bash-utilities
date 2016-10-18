#!/bin/bash


# Constants variables
REPO=${PWD};

if [ "${PWD##*/}" != "scripts" ]
then
    cd "scripts";
else
    REPO='${PWD}/..'
fi

SCRIPTS=${PWD};


### Local variables
help=false


# Source utilities
source "${SCRIPTS}/helpers/index.bash"


### Parse arguments
while getopts ":h" opt; do
    case "${opt}" in
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    logdebug "./scripts/install.sh"
    exit 0
fi


### Source function
line="source ~/bash/scripts/profile.bash"

if file_has_line -p "$line" -f ~/.bash_profile
then
    logwarn "Already installed"
    exit 1
fi

logdebug "Installing bash utilities"

config_put -k "base.directory" -v "$HOME"
file_append_line -l "$line" -f ~/.bash_profile
source ~/.bash_profile

lognote "If the scripts not appear, please execute this line.\n\n\t$(tput bold)source ~/.bash_profile$(tput sgr0)\n"
logdebug "Install OK"

exit 0
