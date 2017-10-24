#! bash/bash

### Includes
source ~/.git-prompt.sh
source ~/.git-completion.bash
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
filename=''
extension=''
outputfile=''
response=''
key=''


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
    utils_help -n android_vector_2_png -a avec2png -d 'Transform xml vector in png' -o '-f (?) Your path of file vector.xml'
    exit 0
fi

if ! [ -n "$filename" ]
then
    logwarn "Please enter a file"
    exit 1
fi

if ! [ -e $filename ]
then
    logwarn "Please enter a valid file"
    exit 1
fi

extension=${filename: -4}
if [ "$extension" != '.xml' ]
then
    logwarn 'File must be a .xml'
    exit 1
fi


### Source function

xml2Svg()
{
    local currentPath=${PWD}
    cd ~/bash/scripts/android/
    outputfile="$(basename "$filename" $extension)"
    java -cp . Vector2Svg "$currentPath/$filename"
    cd $currentPath

    if ! [ -e "${outputfile}.svg" ]
    then
        logwarn "Parse XML vector file to SVG not found."
        exit 1
    fi
    logsuccess "Parse XML vector file to SVG file. OK"
}

svg2Png()
{
    file_transform -f "${outputfile}.svg" -o "png"

    if ! [ -e $outputfile.png ]
    then
        logwarn "Parse SVG vector file to PNG not found."
        exit 1
    fi
    logsuccess "Parse SVG vector file to PNG file. OK"
}

xml2Svg
svg2Png

exit 0
