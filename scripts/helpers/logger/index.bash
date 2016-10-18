#! bash/bash Completion support for Log commands.

# Alias
# ---------------------------------------------------------------------------------------

alias lcolors='logcolors'
alias lprint='logprint'
alias ltrace='logtrace'
alias ldebug='logdebug'
alias linfo='loginfo'
alias lwarn='logwarn'
alias lerror='logerror'
alias lsuccess='logsuccess'
alias lnote='lognote'


# Functions
# ---------------------------------------------------------------------------------------

logcolors() {
    bash ~/bash/scripts/helpers/logger/colors.bash "$@"
}

logprint() {
    bash ~/bash/scripts/helpers/logger/print.bash "$@"
}

logtrace() {
    logprint -m "$1"
}

logdebug() {
    logprint -m "[c:green]$1"
}

loginfo() {
    logprint -m "[c:blueb]$1"
}

logwarn() {
    logprint -m "[c:yellow]➜ $1"
}

logerror() {
    logprint -m "[c:red]✖ $1"
}

logsuccess() {
    logprint -m "[c:green]✔ $1"
}

lognote() {
    logprint -m "[c:blackb]$(tput sgr 0 1)Note:$(tput sgr0) $1"
}
