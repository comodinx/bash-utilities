#! bash/bash Completion support for JSON commands.


# Alias
# ---------------------------------------------------------------------------------------

alias jread='json_read'


# Functions
# ---------------------------------------------------------------------------------------

jsonnodevalue()
{
    source ~/bash/scripts/helpers/index.bash

    local json="$1"
    local value=$(node -pe 'function _v(o,v,k,i){try{if(!i){return o[k];}return v[k];}catch(e){return undefined;}}function _g(o,l,d){var v;l=typeof l==="string"?l.split("."):l||[];d=d||null;l.every(function(k,i){v=_v(o,v,k,i);return typeof v!=="undefined";});if(typeof v==="undefined"){return d;}return v;} _g(JSON.parse(process.argv[1]), process.argv[2])' ${json} "$2")

    if [[ ${value} == "undefined" || ${value} == "null" ]]
    then
        echo "$3"
        return 0
    fi

    echo "$value"
}

jsonvalue()
{
    if command_check -c "nodes"
    then
        jsonnodevalue ${1} ${2} ${3}
        return 0
    fi

    local value=`echo $1 | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $2`

    if [[ -z ${value} ]]
    then
        echo "$3"
        return 0
    fi

    echo ${value##*|}
}

jsonparse()
{
    echo $1 | \
    sed -e 's/[{}]/''/g' | \
    sed -e 's/", "/'\",\"'/g' | \
    sed -e 's/" ,"/'\",\"'/g' | \
    sed -e 's/" , "/'\",\"'/g' | \
    sed -e 's/","/'\"---SEPERATOR---\"'/g' | \
    awk -F=':' -v RS='---SEPERATOR---' "\$1~/\"$2\"/ {print}" | \
    sed -e "s/\"$2\"://" | \
    tr -d "\n\t" | \
    sed -e 's/\\"/"/g' | \
    sed -e 's/\\\\/\\/g' | \
    sed -e 's/^[ \t]*//g' | \
    sed -e 's/^"//'  -e 's/"$//'
}
