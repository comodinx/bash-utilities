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
        c)  compress=true;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n image_resize_ios -a imgresios -d 'Resize image for IOS to 1x, 2x and 3x' -o '-f Your file image to resize (.png or .jpg)' -o '-d Your directory for output files. Default image name without extension' -o '-c (?) Compress images. Default false'
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

if [ -z "$directory" ]
then
    directory="$(basename "$filename")"
    directory="${directory%.*}/ios"
fi


### Source function
mkdir -p "$directory"

H=$(sips -g pixelHeight "$filename" | grep 'pixelHeight' | cut -d: -f2)
W=$(sips -g pixelWidth "$filename" | grep 'pixelWidth' | cut -d: -f2)

H="$(echo -e "${H}" | sed -e 's/^[[:space:]]*//')"
W="$(echo -e "${W}" | sed -e 's/^[[:space:]]*//')"

H2x=$(echo 0.6039372*"${H}"/1 | bc)
W2x=$(echo 0.6039372*"${W}"/1 | bc)

H1x=$(($H2x / 2))
W1x=$(($W2x / 2))

fbname=$(basename "$filename" $extension)
file_3x_original="$fbname@3x$extension"
file_2x_original="$fbname@2x$extension"
file_1x_original="$fbname@1x$extension"

cp "$filename" "$directory/$file_3x_original"
logdebug "$file_3x_original created ($W x $H)"

sips --resampleHeight "$H2x" "$filename" --out "$directory/$file_2x_original" &> /dev/null
logdebug "$file_2x_original created ($W2x x $H2x)"

sips --resampleHeight "$H1x" "$filename" --out "$directory/$file_1x_original" &> /dev/null
logdebug "$file_1x_original created ($W1x x $H1x)"

if [ "$compress" != false ]
then
    logdebug "Compress..."
    image_compress -f "$directory/$file_3x_original" -d "$directory" -r
    image_compress -f "$directory/$file_2x_original" -d "$directory" -r
    image_compress -f "$directory/$file_1x_original" -d "$directory" -r
fi

# Create ios folder for xcode
name="$(basename "$filename")"
name="${filename%.*}"

mkdir -p "$directory/$name.imageset"

cp "$directory/$file_3x_original" "$directory/$name.imageset/$file_3x_original"
cp "$directory/$file_2x_original" "$directory/$name.imageset/$file_2x_original"
cp "$directory/$file_1x_original" "$directory/$name.imageset/$file_1x_original"

cp ~/bash/scripts/images/defaults/Contents.json "$directory/$name.imageset/Contents.json"

file_replace_line -f "$directory/$name.imageset/Contents.json" -p "FILE_NAME_3x" -l "      \"filename\" : \"$file_3x_original\","
file_replace_line -f "$directory/$name.imageset/Contents.json" -p "FILE_NAME_2x" -l "      \"filename\" : \"$file_2x_original\","
file_replace_line -f "$directory/$name.imageset/Contents.json" -p "FILE_NAME_1x" -l "      \"filename\" : \"$file_1x_original\","
