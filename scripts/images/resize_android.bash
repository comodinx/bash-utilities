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


### Parse arguments
while getopts ":f:s:d:ch" opt; do
    case "${opt}" in
        f)  filename=$OPTARG;;
        s)  filesize=$OPTARG;;
        d)  directory=$OPTARG;;
        c)  compress=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n image_resize_android -a imgresand -d 'Resize image for Android to ldpi, mdpi, hdpi, xhdpi, xxhdpi and xxxhdpi' -o '-f Your file image to resize (.png or .jpg)' -o '-s (?) Current image size (ldpi, mdpi, hdpi, xhdpi, xxhdpi or xxxhdpi). Default "xxxhdpi"' -o '-c (?) Compress images. Default false'
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

extension=${filename: -4}
if [ "$extension" != '.png' ] && [ "$extension" != '.jpg' ]
then
    logwarn 'File must be a .png or .jpg'
    exit 1
fi

if [ ! -d "$directory" ]
then
    directory="$(basename "$filename")"
    directory="${directory%.*}/android"
fi

### Source function
mkdir -p "$directory"

height=$(sips -g pixelHeight "$filename" | grep 'pixelHeight' | cut -d: -f2)
width=$(sips -g pixelWidth "$filename" | grep 'pixelWidth' | cut -d: -f2)

height="$(echo -e "${height}" | sed -e 's/^[[:space:]]*//')"
width="$(echo -e "${width}" | sed -e 's/^[[:space:]]*//')"

# 0.75x for low-density
# 1x    baseline for medium-density
# 1.5x  for high-density
# 2x    for extra-high-density
# 3x    for extra-extra-high-density
# 4x    for extra-extra-extra-high-density (launcher icon only; see note above)

# Defaults density for "filesize" option
if [ "$filesize" == "xxxhdpi" ]
then
    multiple_xxxhdpi=1
    multiple_xxhdpi=0.88
    multiple_xhdpi=0.66
    multiple_hdpi=0.5
    multiple_mdpi=0.33
    multiple_ldpi=0.3

elif [ "$filesize" == "xxhdpi" ]
then
    multiple_xxxhdpi=2
    multiple_xxhdpi=1
    multiple_xhdpi=0.88
    multiple_hdpi=0.66
    multiple_mdpi=0.5
    multiple_ldpi=0.33

elif [ "$filesize" == "xhdpi" ]
then
    multiple_xxxhdpi=3
    multiple_xxhdpi=2
    multiple_xhdpi=1
    multiple_hdpi=0.88
    multiple_mdpi=0.66
    multiple_ldpi=0.5

elif [ "$filesize" == "hdpi" ]
then
    multiple_xxxhdpi=4
    multiple_xxhdpi=3
    multiple_xhdpi=2
    multiple_hdpi=1
    multiple_mdpi=0.88
    multiple_ldpi=0.66

elif [ "$filesize" == "mdpi" ]
then
    multiple_xxxhdpi=4
    multiple_xxhdpi=3
    multiple_xhdpi=2
    multiple_hdpi=1.5
    multiple_mdpi=1
    multiple_ldpi=0.88

elif [ "$filesize" == "ldpi" ]
then
    multiple_xxxhdpi=4
    multiple_xxhdpi=3
    multiple_xhdpi=2
    multiple_hdpi=1.5
    multiple_mdpi=1
    multiple_ldpi=1
fi

resize() {
    local density="$1"
    local multiple="$2"

    mkdir -p "$directory/drawable-$density"

    w=$(echo "${multiple}"*"${width}"/1 | bc)
    h=$(echo "${multiple}"*"${height}"/1 | bc)

    sips --resampleHeight "$h" "$filename" --out "$directory/drawable-$density/$filename" &> /dev/null
    logdebug "drawable-$density/$filename created ($w x $h)"

    if [ "$compress" != "false" ]
    then
        image_compress -f "$directory/drawable-$density/$filename" -d "$directory/drawable-$density" -r
    fi
    return 0
}

resize "xxxhdpi" "$multiple_xxxhdpi"
resize "xxhdpi" "$multiple_xxhdpi"
resize "xhdpi" "$multiple_xhdpi"
resize "hdpi" "$multiple_hdpi"
resize "mdpi" "$multiple_mdpi"
resize "ldpi" "$multiple_ldpi"
