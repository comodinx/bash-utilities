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
    utils_help -n config_show -a cshow -d 'Show all config values in configuration file'
    exit 0
fi

if ! [ -f "~/bash/config/default.properties" ]
then
    exit 0
fi


### Source function
cat ~/bash/config/default.properties | grep =
