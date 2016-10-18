# bash/bash Completion support for Show Help command.

### Includes
source ~/bash/scripts/helpers/index.bash


### Helper function
replaceSeparator() {
    local string=$1

    string="$(echo "$string" | sed 's/\[SEPARATOR\]$//g')"
    string="${string//\[SEPARATOR\]/\n}"
    echo $string
}


### Local variables
name=''
usage=''
description=''
note=''
alias=''
options=''


### Parse arguments
while getopts ":n:u:d:N:a:o:" opt; do
    case "${opt}" in
        n)  name=$OPTARG;;
        u)  usage=$OPTARG;;
        d)  description=$OPTARG;;
        N)  note=$OPTARG;;
        a)  alias+="\t$OPTARG[SEPARATOR]";;
        o)  options+="\t$OPTARG[SEPARATOR]";;
    esac
done


### Source function
logtrace "[c:whiteu]Usage[c:0]:\t$name $usage"

if ! [ -z "$description" ]
then
    logtrace "\t$description"
fi

logtrace '\n[c:whiteu]Options[c:0]:'

if ! [ -z "$options" ]
then
    logtrace "$(replaceSeparator "$options")"
fi
logtrace "\t-h (?) Display help"

if ! [ -z "$alias" ]
then
    logtrace '\n[c:whiteu]Alias[c:0]:'
    logtrace "$(replaceSeparator "$alias")"
fi

logtrace ""

if ! [ -z "$note" ]
then
    lognote "\n\t$note"
fi
logtrace ""
