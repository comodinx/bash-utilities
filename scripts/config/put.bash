#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
key=''
value=''


### Parse arguments
while getopts ":k:v:h" opt; do
    case "${opt}" in
        k)  key=$OPTARG;;
        v)  value=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n config_put -a cput -d 'Put config value for key in configuration file' -o '-k Config key' -o '-v Config value'
    exit 0
fi

if [ -z "$key" ]
then
    logwarn 'Please enter a key'
    exit 1
fi

if ! [ -f "~/bash/config/default.properties" ]
then
    echo "" >> ~/bash/config/default.properties
    exit 0
fi


### Source function
line=$(file_get_line -p "$key=*" -f ~/bash/config/default.properties)
config="$key=$value"
isNew=false

if [ -z "$line" ]
then
    line=$(file_get_line -p "#\snew*" -f ~/bash/config/default.properties)
    isNew=true
fi

extbkp=''
if is_os_mac
then
    extbkp='.bkp'
fi

file_replace_line -l "$config" -p "$line" -f ~/bash/config/default.properties

if [ "$isNew" != false ]
then
    file_append_line -l "# new" -f ~/bash/config/default.properties
fi

exit 0
