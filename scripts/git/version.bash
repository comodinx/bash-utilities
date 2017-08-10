#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/git/index.bash


### Global variables
PATTERN_VERSION="^[0-9]+.[0-9]+.[0-9]+$"


### Local variables
help=false
force=false
current=false
increase=true
decrease=false
version=""
level=""


### Parse arguments
while getopts ":l:v:idcfh" opt; do
    case "${opt}" in
        l) level=${OPTARG};;
        v) version=${OPTARG};;
        i) increase=true;;
        d) decrease=true;;
        c) current=true;;
        f) force=true;;
        h) help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n git_version -a gver -d 'Calculate tagging code version in format Mayor.Minor.Patch' -o '-l (?) Level required (major (M), minor (m), patch (p)). Default is "patch".' -o '-v (?) Specific version required. Default is null.' -o '-i (?) Indicates that the version of the indicated type must be increased. Default is true' -o '-d (?) Indicates that the version of the indicated type must be decreased. Default is false' -o '-c (?) Print the current tagged version. Default is false' -o '-f (?) Force to find tagged version in tag list. Default is false' -N 'If -v argument is present, -l and -c arguments are ignored and use the user specific version. In other case use the last tag version with format major.minor.patch (Exam. 1.0.3).'
    exit 0
fi

if [ -z "${level}" ]
then
    level="patch"
fi

if [ "${level}" != "major" ] && [ "${level}" != "M" ] && [ "${level}" != "minor" ] && [ "${level}" != "m" ] && [ "${level}" != "patch" ] && [ "${level}" != "p" ]
then
    logwarn "Fatal Error: Invalid Level"
    exit 1
fi


### Source function
readTagFromList()
{
    local tags=($(git tag --list 2> /dev/null))
    local version=0
    local number=0
    local major=""
    local minor=""
    local patch=""
    local tag=""

    for t in "${tags[@]}"; do
        if [[ ! "${t}" =~ ${PATTERN_VERSION} ]]
        then
            continue
        fi

        major="$(cut -d'.' -f1 <<<"$t")"
        minor="$(cut -d'.' -f2 <<<"$t")"
        patch="$(cut -d'.' -f3 <<<"$t")"
        number="$major$minor$patch"
        number=$(($number + 0))

        if [[ ${version} -lt ${number} ]]
        then
            version=$number
            tag=$t
        fi
    done

    echo "$tag"
}

readTag()
{
    if [ "$force" != false ]
    then
        readTagFromList
        return
    fi

    echo "$(git describe --abbrev=0 --tags 2> /dev/null)"
}

readVersion()
{
    if [ -z "${version}" ]
    then
        readTag
        return
    fi

    echo "$version"
}

decreased()
{
    local v=$(readVersion)

    if [[ ! ${v} =~ ${PATTERN_VERSION} ]]
    then
        logwarn "Fatal Error: $v not match with pattern '$PATTERN_VERSION'"
        exit 1
    fi

    local major="$(cut -d'.' -f1 <<<"$v")"
    local minor="$(cut -d'.' -f2 <<<"$v")"
    local patch="$(cut -d'.' -f3 <<<"$v")"

    if [ "${level}" == "major" ] || [ "${level}" == "M" ]
    then
        major="$(($major - 1))"
    fi

    if [ "${level}" == "minor" ] || [ "${level}" == "m" ]
    then
        minor="$(($minor - 1))"
    fi

    if [ "${level}" == "patch" ] || [ "${level}" == "p" ]
    then
        patch="$(($patch - 1))"
    fi

    echo "$major.$minor.$patch"
}

increased()
{
    local v=$(readVersion)

    if [[ ! ${v} =~ ${PATTERN_VERSION} ]]
    then
        logwarn "Fatal Error: $v not match with pattern '$PATTERN_VERSION'"
        exit 1
    fi

    local major="$(cut -d'.' -f1 <<<"$v")"
    local minor="$(cut -d'.' -f2 <<<"$v")"
    local patch="$(cut -d'.' -f3 <<<"$v")"

    if [ "${level}" == "major" ] || [ "${level}" == "M" ]
    then
        major="$(($major + 1))"
        minor="0"
        patch="0"
    fi

    if [ "${level}" == "minor" ] || [ "${level}" == "m" ]
    then
        minor="$(($minor + 1))"
        patch="0"
    fi

    if [ "${level}" == "patch" ] || [ "${level}" == "p" ]
    then
        patch="$(($patch + 1))"
    fi

    echo "$major.$minor.$patch"
}

if [ "$current" != false ]
then
    echo $(readVersion)
    exit 0
fi

if [ "$decrease" != false ]
then
    decreased
    exit 0
fi

increased
