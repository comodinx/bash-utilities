#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/git/index.bash


### Local variables
help=false
branch=''


### Parse arguments
while getopts ":b:h" opt; do
    case "${opt}" in
        b)  branch=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_rebase -a greb -d 'Rebase from origin your branch' -o '-b (?) Your branch to rebase. Default your current branch'
    exit 1
fi

if ! git_check
then
    logwarn "Directory is not a GIT repository"
    exit 0
fi

if [ -z "$branch" ]
then
    branch=$(git_br)
    if [ -z "$branch" ]
    then
        logwarn 'Please select any branch'
        exit 0
    fi
fi


### Source function
logdebug "GIT Rebase for [c:blueb]$branch\n"

current=$(git_br)
if [ "$current" != "$branch" ]
then
    logdebug "Change to branch [c:blueb]$branch\n"
    git checkout $branch
fi

logdebug 'Loading changes from origin\n'
git fetch -p

logdebug "Rebase branch [c:blueb]$branch\n"
git rebase origin/$branch
