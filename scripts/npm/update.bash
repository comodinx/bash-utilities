#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
onlyupdate=true


### Parse arguments
while getopts ":oh" opt; do
    case "${opt}" in
        o)  onlyupdate=false;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n npm_update -a npmu -d 'Update node modules' -o '-o (?) Remove current node_modules folder. Default true'
    exit 1
fi


### Source function
if [ "$onlyupdate" != false ]
then
    logtrace 'Delete [c:blueb]node_modules[c:green] folder'
    rm -rf node_modules
fi

logtrace 'Installing modules'
npm install
