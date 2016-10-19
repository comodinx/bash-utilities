#! bash/bash

### Includes
source ~/bash/scripts/config/index.bash
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
    utils_help -n git_mas -a gmas -d 'Change your current branch to master, fetch and rebase from origin this branch' -N 'This command is shortcut for [c:blueb]git_rebase -b master'
    exit 0
fi


### Source function
branch="$(config_get -k git.master.branch)"

git_rebase -b $branch
logdebug '\nListortirijillo amiguillo'
