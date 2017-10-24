#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
key=''


### Parse arguments
while getopts ":k:h" opt; do
    case "${opt}" in
        k)  key=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n config_has -a chas -d 'Return true (0) if config key exists' -o '-k Config key'
    exit 0
fi

if [ -z "$key" ]
then
    logwarn 'Please enter a key'
    exit 1
fi

if ! [ -e ~/bash/config/default.properties ]
then
    exit 1
fi


### Source function
line=$(file_get_line -p "$key=*" -f ~/bash/config/default.properties)

if [ -z "$line" ]
then
    exit 1
fi

exit 0
