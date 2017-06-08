#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/images/index.bash


### Helper function
replaceSeparator() {
    local string=$1

    string="$(echo "$string" | sed 's/\[SEPARATOR\]$//g')"
    string="${string//\[SEPARATOR\]/\n}"
    echo $string
}


### Local variables
help=false
compress=false
directory=''
files=''
filesize=''
resizetype=''


### Parse arguments
while getopts ":f:s:d:r:ch" opt; do
    case "${opt}" in
        f)  files+="$OPTARG[SEPARATOR]";;
        s)  filesize=$OPTARG;;
        d)  directory=$OPTARG;;
        c)  compress=$OPTARG;;
        r)  resizetype=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n image_resize -a imgres -d 'Resize image for Android and IOS' -o '-f Your files images to resize (.png or .jpg)' -o '-d Your directory for output files. Default image name without extension' -o '-s (?) Current image size (ldpi, mdpi, hdpi, xhdpi, xxhdpi or xxxhdpi). Default "xxxhdpi"' -o '-r (?) Resize platform ("i" for IOS, "a" for Android or "*" for all). Default "*" (IOS and Android)' -o '-c (?) Compress images. Default false'
    exit 0
fi

if [ -z "$files" ]
then
    logwarn 'Please enter one or more file image path'
    exit 1
fi

if [ -z "$filesize" ]
then
    filesize='xxxhdpi'
fi

if [ -z "$resizetype" ]
then
    resizetype='*'
fi

### Source function
args=''

prepare() {
    if [ "$compress" != false ]
    then
        args='-c'
    fi

    if ! [ -z "$directory" ]
    then
        mkdir -p "$directory"
    fi
}

resize() {
    local filename="$1"
    local directory="$2"

    local extension=${filename: -4}
    if [ "$extension" != '.png' ] && [ "$extension" != '.jpg' ] && [ "$extension" != '.gif' ]
    then
        logwarn "File must be a .png or .jpg or .gif. $filename do not resize."
        return 1
    fi

    if [ -z "$directory" ]
    then
        directory="$(basename "$filename")"
        directory="${directory%.*}"

        mkdir -p "$directory"
    fi

    if [ "$resizetype" == '*' ] || [ "$resizetype" == 'i' ]
    then
        logdebug "Resizing IOS..."
        image_resize_ios -f "$filename" -d "$directory/ios" $args
    fi

    if [ "$resizetype" == '*' ] || [ "$resizetype" == 'a' ]
    then
        logdebug "\nResizing Android..."
        image_resize_android -f "$filename" -s "$filesize" -d "$directory/android" $args
    fi
}

each() {
    local filenames="$(replaceSeparator "$files")"

    for filename in ${filenames//\\n/ }
    do
        resize "$filename" "$directory"
    done
    return 0
}

prepare
each
