#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/git/index.bash


### Local variables
help=false
force=false
comment=''
branch=''


### Parse arguments
while getopts ":b:c:fh" opt; do
    case "${opt}" in
        b)  branch=$OPTARG;;
        c)  comment=$OPTARG;;
        f)  force=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_push -a gpus -d 'Add all files, Commit with comment and Push to origin' -o '-c Comment for GIT commit' -o '-b (?) Your branch to push. Default your current branch' -o '-f (?) Force to use master branch o your develop branch' 
    exit 1
fi

if ! git_check
then
    logwarn "Directory is not a GIT repository"
    exit 0
fi

if [ -z "$comment" ]
then
    logwarn 'Please enter a comment'
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

if [ "$force" == false ]
then
    base=$(git_br_development)
    if [ "$branch" == "master" ] || [ "$branch" == "$base" ]
    then
        logwarn "No use gpus with [c:blueb]master[c:yellow] or [c:blueb]$base"
        exit 0
    fi
fi


### Source function
current=$(git_br)
if [ "$current" != "$branch" ]
then
    logdebug "Change to branch [c:blueb]$branch\n"
    git checkout $branch
fi

logdebug 'Adding all changes\n'
git add --all

logdebug "Commiting the code with comment '[c:blueb]$comment'\n"
git commit -m "$comment"

logdebug "Pushing branch [c:blueb]$branch\n"
branch=$(git_br)
git push origin $branch
