#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
path='.'
pattern=''


### Parse arguments
while getopts ":p:f:h" opt; do
    case "${opt}" in
        p)  path=$OPTARG;;
        f)  pattern=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n file_remove -a filer -d 'Remove all files match with file pattern in path' -o '-f File pattern' -o '-p (?) Folder path. Default is "."'
    exit 0
fi

if [ -z "$pattern" ]
then
    logwarn 'Please enter a file pattern'
    exit 1
fi


### Source function
logdebug "Delete all file match with [c:blueb]$pattern[c:green] in [c:blueb]$path[c:green]"
find "$path" -name "$pattern" -type f -delete   
