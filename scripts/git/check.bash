#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
details=false
directory='.'


### Parse arguments
while getopts ":d:Dh" opt; do
    case "${opt}" in
        d)  directory=$OPTARG;;
        D)  details=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_check -a gcheck -d 'Check if directory is a git repository' -o '-d Directory' -o '-D (?) Show more details indicate if directory is a git repository. Default false'
    exit 0
fi

if [ -z "$directory" ]
then
    logwarn 'Please enter a command name'
    exit 1
fi


### Source function
detailInformation='Unavailable'

# Default is unavailable
isRepository=1

if [ -d "$directory/.git" ]
then
    detailInformation='Available'
    isRepository=0
fi

if [ "$details" != false ]
then
    logtrace "$detailInformation"
fi
exit $isRepository
