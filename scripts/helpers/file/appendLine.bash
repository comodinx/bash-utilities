#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
backup=false
newline=''
filename=''


### Parse arguments
while getopts ":l:p:f:bh" opt; do
    case "${opt}" in
        l)  newline=$OPTARG;;
        f)  filename=$OPTARG;;
        b)  backup=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n file_append_line -a fileal -d 'Append line in file' -o '-l New line value' -o '-f File to append the line' -o '-b (?) Generate backup for yuor file. Default false'
    exit 0
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
extbkp=''
if is_os_mac
then
    extbkp='.bkp'
fi

if [ "$backup" != false ]
then
    cp $filename $filename$extbkp 2>/dev/null
fi

echo -e "\n$newline" >> $filename

exit 0