#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
details=false
module=''


### Parse arguments
while getopts ":m:dh" opt; do
    case "${opt}" in
        m)  module=$OPTARG;;
        d)  details=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n npm_check -a npmc -d 'Check if NPM module exists' -o '-m Module name' -o '-d (?) Details indicate if module is local or global. Default false'
    exit 0
fi

if [ -z "$module" ]
then
    logwarn 'Please enter a module name'
    exit 1
fi


### Source function
pattern="^.+── $module@.+"
detailInformation='Unavailable'

# Default is unavailable
isAvailable=1

search="$(npm list -g $module 2> /dev/null)"
if [[ ${search} =~ ${pattern} ]]
then
    detailInformation='Available (Global)'
    isAvailable=0
fi

search="$(npm list $module 2> /dev/null)"
if [[ ${search} =~ ${pattern} ]]
then
    detailInformation='Available (Local)'
    isAvailable=0
fi

if [ "$details" != false ]
then
    logtrace "$detailInformation"
fi
exit $isAvailable
