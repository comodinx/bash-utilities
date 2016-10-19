#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
directory=''
filename=''


### Parse arguments
while getopts ":f:d:h" opt; do
    case "${opt}" in
        f)  filename=$OPTARG;;
        d)  directory=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n image_compress -a imgcom -d 'Compress image size. Require run command in image folder' -o '-f Your file image to compress (.png or .jpg)'
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

extension=${filename: -4}
if [ "$extension" != '.png' ] && [ "$extension" != '.jpg' ]
then
	logwarn 'File must be a .png or .jpg'
	exit 1
fi

if [ ! -d "$directory" ]
then
    directory="$(basename "$filename").out"
fi

### Source function
logdebug "Compressing..."

fbname=$(basename "$filename" $extension)
file_original="$fbname-raw$extension"
file_compressed="$fbname-raw-fs8$extension"
file_final="$fbname$extension"

if [ ! -d "$directory" ]
then
    mkdir  "$directory"
fi

cp "$filename" "$directory/$file_original"

if [ $extension == ".png" ]
then
    ~/bash/scripts/images/pngquant "$directory/$file_original"

    filesize_original=$(du -k "$directory/$file_original" | cut -f1)
    filesize_compressed=$(du -k "$directory/$file_compressed" | cut -f1)

    mv "$directory/$file_compressed" "$directory/$file_final"

    logdebug "$file_final created ($filesize_original KB to $filesize_compressed KB)"
fi

if [ $extension == ".jpg" ]
then
    logdebug "I don't know how to compress JPG files, sorry!"

    filesize_original=$(du -k "$directory/$file_original" | cut -f1)

    mv "$directory/$file_original" "$directory/$file_final"

    logdebug "$file_original renamed to $file_final ($filesize_original KB)"
fi
