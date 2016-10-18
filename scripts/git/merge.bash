#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/git/index.bash


### Local variables
help=false
origin=''
branch=''


### Parse arguments
while getopts ":o:b:h" opt; do
    case "${opt}" in
        o)  origin=$OPTARG;;
        b)  branch=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_merge -a gmer -d 'Merge your branch with other branch' -o '-o (?) Your branch to use for merge into your selected branch. Default is the result of [c:blueb]git_br_dev[c:0] command' -o '-b (?) Your branch to update. Default your current branch'
    exit 1
fi

if ! git_check
then
    logwarn "Directory is not a GIT repository"
    exit 0
fi

if [ -z "$origin" ]
then
    origin=$(git_br_dev)
    if [ -z "$origin" ]
    then
        logwarn 'Please enter a valid origin branch'
        exit 0
    fi
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

if [ "$origin" == "$branch" ]
then
    logwarn "Your branch [c:blue]$branch[c:yellow] is not merged with itself"
    exit 0
fi

### Source function
git_rebase -b "$origin"

logdebug "Change to branch [c:blueb]$branch\n"
git checkout $branch

logdebug "Merging branch [c:blueb]$branch[c:green] with [c:blueb]$origin\n"
git merge $origin
