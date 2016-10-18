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
    utils_help -n config_remove -a cremove -d 'Remove config value for key in configuration file' -o '-k Config key'
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
    exit 1
fi

extbkp=''
if is_os_mac
then
    extbkp='.bkp'
fi

file_remove_line -p "$line" -f ~/bash/config/default.properties

exit $?