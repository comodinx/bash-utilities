#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/images/index.bash


### Local variables
help=false
compress=false
directory=''
filename=''


### Parse arguments
while getopts ":f:d:ch" opt; do
    case "${opt}" in
        f)  filename=$OPTARG;;
        d)  directory=$OPTARG;;
        c)  compress=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n image_resize -a imgres -d 'Resize image to 1x, 2x and 3x' -o '-f Your file image to resize (.png or .jpg)' -o '-c (?) Compress images. Default false'
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
logdebug  "Resizing..."

H=$(sips -g pixelHeight "$filename" | grep 'pixelHeight' | cut -d: -f2)
W=$(sips -g pixelWidth "$filename" | grep 'pixelWidth' | cut -d: -f2)

H="$(echo -e "${H}" | sed -e 's/^[[:space:]]*//')"
W="$(echo -e "${W}" | sed -e 's/^[[:space:]]*//')"

H2x=$(echo 0.6039372*"${H}"/1 | bc)
W2x=$(echo 0.6039372*"${W}"/1 | bc)

H1x=$(($H2x / 2))
W1x=$(($W2x / 2))

# Output
fbname=$(basename "$filename" $extension)
file_3x_original="$fbname@3x$extension"
file_2x_original="$fbname@2x$extension"
file_1x_original="$fbname@1x$extension"

if [ ! -d "$directory" ]
then
    mkdir  "$directory"
fi

cp "$filename" "$directory/$file_3x_original"
logdebug "$file_3x_original created ($W x $H)"

sips --resampleHeight "$H2x" "$filename" --out "$directory/$file_2x_original" &> /dev/null
logdebug "$file_2x_original created ($W2x x $H2x)"

sips --resampleHeight "$H1x" "$filename" --out "$directory/$file_1x_original" &> /dev/null
logdebug "$file_1x_original created ($W1x x $H1x)"

if [ "$compress" != false ]
then
    image_compress -f "$directory/$file_3x_original" -d "$directory"
    image_compress -f "$directory/$file_2x_original" -d "$directory"
    image_compress -f "$directory/$file_1x_original" -d "$directory"
fi
