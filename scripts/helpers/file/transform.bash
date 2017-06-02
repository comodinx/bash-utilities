#! bash/bash

### Includes
source ~/.git-prompt.sh
source ~/.git-completion.bash
source ~/bash/scripts/helpers/index.bash


### Global variables
CCAK_PART_1="QYdzs1pcGpbS0WlgO5v2XDAdovtECvDsmA9HnGlGcfY"
CCAK_PART_2="zf3aXmvA3ZNF_00pGZlrgDlvyXEG2q8ZkR9TGMvEoUw"
CCAK="$CCAK_PART_1$CCAK_PART_2"


### Local variables
help=false
currentPath=''
filename=''
sourcefile=''
outputformat=''
outputname=''
extension=''
cchost=''


### Parse arguments
while getopts ":f:o:n:h" opt; do
    case "${opt}" in
        f)  filename=$OPTARG;;
        o)  outputformat=$OPTARG;;
        n)  outputname=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n file_transform -a filet -d 'Transform file from currect extension type to selected format' -o '-f File for transformation' -o '-o Output file format (MP3, PNG, SVG, etc.). More information on https://cloudconvert.com' -o '-n (?) Output file name. Default current file name'
    exit 0
fi

if ! [ -n "$filename" ]
then
    logwarn 'Please enter a file'
    exit 1
fi

if ! [ -f "$filename" ]
then
    logwarn 'Please enter a valid file'
    exit 1
fi

if ! [ -n "$outputformat" ]
then
    logwarn 'Please enter a output file format'
    exit 1
fi


### Source function
extension=${filename: -4}

if ! [ -n "$outputname" ]
then
    outputname="$(basename "$filename" $extension).$outputformat"
fi

uploadFile()
{
    local response=$(curl -s -i -F name=$filename -F file=@$filename https://uguu.se/api.php?d=upload-tool)

    sourcefile=$(echo "$response" | tail -n1)
    if ! [ -n "$sourcefile" ]
    then
        logwarn "Upload source file to uguu.se not found."
        exit 1
    fi

    logsuccess "Uploaded source file for transform via online mode ($sourcefile). OK"
}


createProcessIDForTransformation()
{
    local response=$(curl -s "https://api.cloudconvert.com/process" -F "apikey=$CCAK" -F "inputformat=${extension:1}" -F "outputformat=$outputformat")

    cchost=$(jsonvalue "$response" url)
    if ! [ -n "$cchost" ]
    then
        logwarn "Init process ID in Cloud Convert not found."
        exit 1
    fi
    logsuccess "Init process ID in Cloud Convert. OK"
}

startingTransformation()
{
    local response=$(curl -s "https:$cchost" -F "input=download" -F "file=$sourcefile" -F "outputformat=$outputformat")

    logsuccess "Starting transformation in Cloud Convert. OK"
}

checkStatusTransformation()
{
    local status=0

    while [  $status -lt 1 ]
    do
        local response=$(curl -s "https:$cchost")
        local step=$(jsonvalue "$response" step)
        local message=$(jsonvalue "$response" message)
        local percent=$(jsonvalue "$response" percent)

        if [ "$step" == 'error' ]
        then
            logerror "$message"
            exit 1
        fi

        if ! [ -n "$percent" ]
        then
            percent='0'
        fi

        echo -e "\033[s\033[u $message $percent% \033[u"

        if [ "$step" == 'finished' ] || [ "$step" == 'output' ]
        then
            let status=status+1
        fi
        sleep 0.25
    done
    logsuccess "Transform file in Cloud Convert. OK"
}

downloadTransformation()
{
    local response=$(curl -s "https:$cchost")
    local ccdownload=$(jsonvalue "$response" url)

    if ! [ -n "$ccdownload" ]
    then
        logwarn "Download file from Cloud Convert not found."
        exit 1
    fi
    curl -s "https:$ccdownload" > "$outputname"
    logsuccess "Download file from Cloud Convert. OK"
}


uploadFile
createProcessIDForTransformation
startingTransformation
checkStatusTransformation
downloadTransformation

exit 0
