#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
message=''
submessage=''
limit='50'


### Parse arguments
while getopts ":m:s:l:h" opt; do
    case "${opt}" in
        m)  message=$OPTARG;;
        s)  submessage=$OPTARG;;
        l)  limit=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n read_input -a readi -d 'Read input text' -o '-m Message for input' -o '-s (?) Sub message for input. Default ""' -o '-l (?) Limit of the characters. Default 50'
    exit 0
fi

if [ -z "$message" ]
then
    logwarn 'Please enter a input message'
    exit 1
fi


### Source function
read -e -p "$(tput bold)$message$(tput sgr0) $submessage" -n "$limit" input

echo "$input"
