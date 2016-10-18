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
    utils_help -n command_is_running -a cisrunning -d 'Check if command is running' -o '-c Command name' -o '-d (?) Show more details indicate if command is running. Default false'
    exit 0
fi

if [ -z "$name" ]
then
    logwarn 'Please enter a command name'
    exit 1
fi


### Source function
commands=$(ps aux | grep $name | wc -l)
detailInformation='Stopped'

# Default is not running
isRunning=1

if [ $commands -gt 3 ]
then
    detailInformation='Running'
    isRunning=0
fi

if [ "$details" != false ]
then
    logtrace "$detailInformation"
fi
exit $isRunning
