#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
key=''
default=''


### Parse arguments
while getopts ":k:d:h" opt; do
    case "${opt}" in
        k)  key=$OPTARG;;
        d)  default=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n config_get -a cget -d 'Return config value for key' -o '-k Config key' -o '-d Default value if config key not exists. Default ""'
    exit 0
fi

if [ -z "$key" ]
then
    logwarn 'Please enter a key'
    exit 1
fi


### Source function
line=$(file_get_line -p "$key=*" -f ~/bash/config/default.properties)

if [ -z "$line" ]
then
    echo "$default"
    exit 0
fi

echo "$(echo "$line" | tr "=" "\n" | tail -n1)"
exit 0
