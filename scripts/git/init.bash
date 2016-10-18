#! bash/bash

### Includes
source ~/.git-prompt.sh
source ~/.git-completion.bash
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
origin=''
comment=''
branch=''


### Parse arguments
while getopts ":o:c:b:h" opt; do
    case "${opt}" in
        o)  origin=$OPTARG;;
        c)  comment=$OPTARG;;
        b)  branch=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_init -a ginit -d 'Initialize a GIT repository' -o '-o GIT origin. Example "https://github.com/comodinx/bash-utilities.git"' -o '-c (?) Comment for GIT commit. Default "Initial commit"' -o '-b (?) Your branch to push. Default master'
    exit 1
fi

if [ -z "$origin" ]
then
    logwarn 'Please enter a origin'
    exit 1
fi

if [ -z "$comment" ]
then
    comment="Initial commit"
    logwarn "Not comment specified, the default comment is '[c:blueb]$comment[c:yellow]'"
fi

if [ -z "$branch" ]
then
    branch="master"
    logwarn "Not branch specified, the default branch is '[c:blueb]$branch[c:yellow]'"
fi


### Source function
git init
git add --all
git commit -m "$comment"
git remote add origin $origin
git push -u origin $branch
