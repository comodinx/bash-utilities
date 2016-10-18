#! bash/bash Completion support for Read commands.

# Alias
# ---------------------------------------------------------------------------------------

alias readc='read_confirm'
alias readi='read_input'


# Functions
# ---------------------------------------------------------------------------------------

read_confirm() {
    bash ~/bash/scripts/helpers/read/readConfirm.bash "$@"

    return $?
}

read_input() {
    echo "$(bash ~/bash/scripts/helpers/read/readInput.bash "$@")"
}
