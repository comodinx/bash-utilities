#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
details=false
name=''


### Parse arguments
while getopts ":c:dh" opt; do
    case "${opt}" in
        c)  name=$OPTARG;;
        d)  details=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n command_check -a ccheck -d 'Check if command is available' -o '-c Command name' -o '-d (?) Show more details indicate if command is available. Default false'
    exit 0
fi

if [ -z "$name" ]
then
    logwarn 'Please enter a command name'
    exit 1
fi


### Source function
commands=$(command -v $name | grep $name | wc -l)
detailInformation='Unavailable'

# Default is unavailable
isAvailable=1

if [ $commands -gt 0 ]
then
    detailInformation='Available'
    isAvailable=0
fi

if [ "$details" != false ]
then
    logtrace "$detailInformation"
fi
exit $isAvailable
