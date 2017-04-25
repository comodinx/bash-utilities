#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
sourceDir=''
targetDir=''


### Parse arguments
while getopts ":s:t:h" opt; do
    case "${opt}" in
        s)  sourceDir=$OPTARG;;
        t)  targetDir=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n android_copy_resources -a acopyres -d 'Copy all resources from source to target' -o '-s Source directory. This directory is the resources in an android proyect' -o '-t Target directory. This directory is the resources in other android proyect'
    exit 0
fi

if ! [ -d "$sourceDir" ]
then
    logwarn "Please enter a valid source directory"
    exit 1
fi

if ! [ -d "$targetDir" ]
then
    logwarn "Please enter a valid target directory"
    exit 1
fi

if [ "$sourceDir" == "$targetDir" ]
then
    logwarn "Source and target are equals. Please, use different directories"
    exit 1
fi


### Source function
for entry in "$sourceDir"/*
do
    sourceEntry="${entry/$sourceDir/}"
    sourceEntry="${sourceEntry:1}"

    if [ -d "$targetDir/$sourceEntry" ]
    then
        logtrace "Copy files from '$entry/*'' to '$targetDir/$sourceEntry/'"
        cp -r "$entry"/* "$targetDir/$sourceEntry/"
    fi
done

exit 0