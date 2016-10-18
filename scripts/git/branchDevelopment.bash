#! bash/bash

### Includes
source ~/bash/scripts/config/index.bash
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false


### Parse arguments
while getopts ":h" opt; do
    case "${opt}" in
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_br_dev -a gbrdev -d 'Get your development branch setting in config with key "git.development.branch"'
    exit 1
fi


### Source function
echo "$(config_get -k git.development.branch)"
