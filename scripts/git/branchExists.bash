#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
remote=false
details=false
branch=''


### Parse arguments
while getopts ":b:rdh" opt; do
    case "${opt}" in
        b)  branch=$OPTARG;;
        r)  remote=true;;
        d)  details=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_br_exists -a gbrexists -d 'Check if branch exists in GIT repository' -o '-b Your branch to check if exists' -o '-r (?) Only check in remote. Default false' -o '-d (?) Show more details indicate if branch exists in GIT repository. Default false'
    exit 0
fi

if [ -z "$branch" ]
then
    logwarn 'Please enter a branch'
    exit 1
fi

if [ "$remote" != false ]
then
    branch="remotes/origin/$branch"
fi


### Source function
detailInformation='Unavailable'

# Default is unavailable
exists=1

if ! [ -z "$(git branch -a | egrep $branch)" ]
then
    detailInformation='Available'
    exists=0
fi

if [ "$details" != false ]
then
    logtrace "$detailInformation"
fi
exit $exists
