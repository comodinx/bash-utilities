#! bash/bash

### Includes
source ~/.git-prompt.sh
source ~/.git-completion.bash
source ~/bash/scripts/helpers/index.bash


### Global variables
dimens_line="dimen"
dimens_line_prefix='^.+\">'
dimens_line_suffix='dp<\/dimen>$'


### Local variables
help=false
filename=''
dimension=''
rawline=''


### Parse arguments
while getopts ":f:h" opt; do
    case "${opt}" in
        f)  filename=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n android_dimens_generator -a adimgen -d 'Generate dimensions for support multiples devices' -o '-f (?) Your path with base file dimens.xml. Default use optimize file dimens.xml for this utilities'
    exit 0
fi

if [ -n "$filename" ]
then
    if ! [ -f "$filename" ]
    then
        logwarn "Please enter a valid file"
        exit 1
    fi
else
    # filename="$HOME/bash/scripts/android/defaults/dimens.xml"
    filename=${PWD}
fi


### Source function
currentPath=${PWD}

cd ~/bash/scripts/android/
java -cp . Main "$filename"
cd $currentPath

# while IFS= read -r line
# do
#     rawline=${line%[a-z]}

#     echo $rawline | sed -e s/^$dimens_line_prefix// -e s/$dimens_line_suffix$//

#     if [[ ${line} =~ ${dimens_line} ]]
#     then
#         echo "$line" |grep -e "[0-9\.]+"
#     fi

# done <"$filename"

# exit 0
