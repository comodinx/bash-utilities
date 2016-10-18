#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/git/index.bash


### Local variables
help=false
branch=''


### Parse arguments
while getopts ":h" opt; do
    case "${opt}" in
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_dev -a gdev -d 'Change your current branch with result of [c:blueb]git_br_development[c:0] command, fetch and rebase from origin this branch' -N "This command is shortcut for [c:blueb]git_rebase -b $branch"
    exit 1
fi


### Source function
branch=$(git_br_development)

git_rebase -b $branch
logdebug '\nListortirijillo amiguillo'
