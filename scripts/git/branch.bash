#! bash/bash

### Includes
source ~/.git-prompt.sh
source ~/.git-completion.bash
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
    utils_help -n git_br -a gbr -d 'Get your current branch'
    exit 0
fi


### Source function
echo $(type __git_ps1 &>/dev/null && __git_ps1 | sed -e "s/^.*(//" -e "s/)$//")
