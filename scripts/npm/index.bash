# bash/bash Completion support for NPM.

# Alias
# ---------------------------------------------------------------------------------------

alias npmu='npm_update'
alias npmc='npm_check'

# Functions
# ---------------------------------------------------------------------------------------

npm_update() {
    logtrace 'Deleting [c:blueb]node_modules[c:green] folder...'
    rm -rf node_modules
    logtrace 'Installing modules...'
    npm i
    logdebug 'Finish process'
}

npm_check() {
    bash ~/bash/scripts/npm/check.bash "$@"

    return $?
}
