#! bash/bash Completion support for Git commands.

# Alias
# ---------------------------------------------------------------------------------------

alias cget='config_get'
alias cput='config_put'
alias chas='config_has'
alias cremove='config_remove'
alias cshow='config_show'

# Functions
# ---------------------------------------------------------------------------------------

config_get() {
    bash ~/bash/scripts/config/get.bash "$@"
}

config_put() {
    bash ~/bash/scripts/config/put.bash "$@"
}

config_has() {
    bash ~/bash/scripts/config/has.bash "$@"

    return $?
}

config_remove() {
    bash ~/bash/scripts/config/remove.bash "$@"
}

config_show() {
    bash ~/bash/scripts/config/show.bash "$@"
}
