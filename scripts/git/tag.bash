#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/git/index.bash


### Local variables
help=false
tag=''
comment=''


### Parse arguments
while getopts ":t:c:h" opt; do
    case "${opt}" in
        t)  tag=$OPTARG;;
        c)  comment=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_tag -a gtag -d 'Tagging code version' -o '-t Tag version' -o '-c (?) Comment for the tag. Default the tag specified'
    exit 1
fi

if ! git_check
then
    logwarn "Directory is not a GIT repository"
    exit 0
fi

if [ -z "$tag" ]
then
    logwarn 'Please enter a tag'
    exit 0
fi

if [ -z "$comment" ]
then
    logwarn "Not comment specified, the default comment is '[c:blueb]$tag[c:yellow]'"
    comment=$tag
fi


### Source function
logdebug "Tagging version [c:blueb]$tag[c:green] with comment [c:blueb]$comment\n"
git tag $tag -m "$comment" -f

logdebug 'Pushing tags\n'
git push origin --tags -f
