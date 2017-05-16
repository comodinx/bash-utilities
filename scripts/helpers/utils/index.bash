#! bash/bash Completion support for Utils commands.

# Includes
# ---------------------------------------------------------------------------------------

source ~/bash/scripts/helpers/utils/json.bash
source ~/bash/scripts/helpers/utils/network.bash
source ~/bash/scripts/helpers/utils/editing.bash


# Functions
# ---------------------------------------------------------------------------------------

utils_help() {
    bash ~/bash/scripts/helpers/utils/help.bash "$@"
}

is_os_mac() {
    if [[ "$OSTYPE" == "darwin"* ]]
    then
        return 0
    fi
    return 1
}
