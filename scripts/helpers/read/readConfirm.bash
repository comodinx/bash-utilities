#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
message=''


### Parse arguments
while getopts ":m:h" opt; do
    case "${opt}" in
        m)  message=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n read_confirm -a readc -d 'Read input for confirmation any action' -o '-m Confirmation message'
    exit 0
fi

if [ -z "$message" ]
then
    logwarn 'Please enter a confirmation message'
    exit 1
fi


### Source function
isConfirmed=$(read_input -m "$message" -s "(y/n) " -l 1)

if [[ "$isConfirmed" =~ ^[Yy]$ ]]
then
    exit 0
fi
exit 1
