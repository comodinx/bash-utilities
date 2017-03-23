#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/images/index.bash


### Local variables
help=false
compress=false
directory=''
filename=''
filesize=''
resizetype=''


### Parse arguments
while getopts ":f:s:d:r:ch" opt; do
    case "${opt}" in
        f)  filename=$OPTARG;;
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
    utils_help -n image_resize -a imgres -d 'Resize image for Android and IOS' -o '-f Your file image to resize (.png or .jpg)' -o '-s (?) Current image size (ldpi, mdpi, hdpi, xhdpi, xxhdpi or xxxhdpi). Default "xxxhdpi"' -o '-r (?) Resize platform ("i" for IOS, "a" for Android or "*" for all). Default "*" (IOS and Android)' -o '-c (?) Compress images. Default false'
    exit 0
fi

if [ -z "$filename" ]
then
    logwarn 'Please enter a file image path'
    exit 1
fi

if [ ! -f "$filename" ]
then
    logwarn 'File not found!'
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

extension=${filename: -4}
if [ "$extension" != '.png' ] && [ "$extension" != '.jpg' ] && [ "$extension" != '.gif' ]
then
    logwarn 'File must be a .png or .jpg or .gif'
    exit 1
fi
if [ ! -d "$directory" ]
then
    directory="$(basename "$filename")"
    directory="${directory%.*}"
fi

### Source function
mkdir -p "$directory"

args=''
if [ "$compress" != false ]
then
    args='-c'
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
