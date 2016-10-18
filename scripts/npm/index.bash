# bash/bash Completion support for NPM.

# Alias
# ---------------------------------------------------------------------------------------

alias npmu='npm_update'
alias npmc='npm_check'

# Functions
# ---------------------------------------------------------------------------------------

npm_update() {
    bash ~/bash/scripts/npm/update.bash "$@"
}

npm_check() {
    bash ~/bash/scripts/npm/check.bash "$@"

    return $?
}
