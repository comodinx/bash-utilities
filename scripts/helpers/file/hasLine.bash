#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
pattern=''
filename=''


### Parse arguments
while getopts ":p:f:h" opt; do
    case "${opt}" in
        p)  pattern=$OPTARG;;
        f)  filename=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n file_has_line -a filehl -d 'Check if has line in file' -o '-p Pattern for search line' -o '-f File to search the line'
    exit 0
fi

if [ -z "$pattern" ]
then
    logwarn 'Please enter a pattern'
    exit 1
fi

if [ -z "$filename" ]
then
    logwarn 'Please enter a file'
    exit 1
fi

if ! [ -e $filename ]
then
    logwarn 'Please enter a valid file'
    exit 1
fi


### Source function
line=$(cat $filename | grep "$pattern" | head -n1)

if [ -z "$line" ]
then
    exit 1
fi

exit 0