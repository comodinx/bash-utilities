#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/git/index.bash


### Local variables
help=false
delete=false
tag=''
comment=''


### Parse arguments
while getopts ":t:c:dh" opt; do
    case "${opt}" in
        t)  tag=$OPTARG;;
        c)  comment=$OPTARG;;
        d)  delete=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_tag -a gtag -d 'Tagging code version' -o '-t Tag version' -o '-d (?) Delete the tag. Default false' -o '-c (?) Comment for the tag. Default the tag specified'
    exit 0
fi

if ! git_check
then
    logwarn "Directory is not a GIT repository"
    exit 1
fi

if [ -z "$tag" ]
then
    logwarn 'Please enter a tag'
    exit 1
fi

if [ -z "$comment" ]
then
    logwarn "Not comment specified, the default comment is '[c:blueb]$tag[c:yellow]'"
    comment=$tag
fi


### Source function
if [ "$delete" != false ]
then
    git tag -d $tag
    git push origin :refs/tags/$tag
    exit 0
fi

logdebug "Tagging version [c:blueb]$tag[c:green] with comment [c:blueb]$comment\n"
git tag $tag -m "$comment" -f

logdebug 'Pushing tags\n'
git push origin --tags -f
