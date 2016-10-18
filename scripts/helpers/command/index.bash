#! bash/bash Completion support for commands.

# Alias
# ---------------------------------------------------------------------------------------

alias cisrunning='command_is_running'
alias ccheck='command_check'
alias cinstall='command_install'


# Functions
# ---------------------------------------------------------------------------------------

command_is_running() {
    bash ~/bash/scripts/helpers/command/isRunning.bash "$@"

    return $?
}

command_check() {
    bash ~/bash/scripts/helpers/command/check.bash "$@"

    return $?
}

command_install() {
    bash ~/bash/scripts/helpers/command/install.bash "$@"
}
