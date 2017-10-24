#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
backup=false
newline=''
pattern=''
filename=''


### Parse arguments
while getopts ":l:p:f:bh" opt; do
    case "${opt}" in
        l)  newline=$OPTARG;;
        p)  pattern=$OPTARG;;
        f)  filename=$OPTARG;;
        b)  backup=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n file_replace_line -a filerepl -d 'Replace line in file' -o '-l New line value' -o '-p Pattern for search line to replace' -o '-f File to replace the line' -o '-b (?) Generate backup for yuor file. Default false'
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

extbkp=''
if is_os_mac
then
    extbkp='.bkp'
fi

line=${line//\//\\/}
newline=${newline//\//\\/}
sed -i $extbkp "s/${line}/$newline/g" $filename 2>/dev/null

if [ "$backup" == false ]
then
    rm -f $filename$extbkp 2>/dev/null
fi

exit 0