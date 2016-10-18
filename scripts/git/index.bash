#! bash/bash Completion support for Git commands.

# Alias
# ---------------------------------------------------------------------------------------

alias gti='git'

alias git_mas='git_master'
alias gmas='git_master'
alias git_dev='git_development'
alias gdev='git_development'
alias gbr='git_br'
alias git_br_dev='git_br_development'
alias gbrdev='git_br_development'
alias gpus='git_push'
alias greb='git_rebase'
alias gmer='git_merge'
alias gtag='git_tag'
alias ginit='git_init'
alias gcheck='git_check'
alias gbrexists='git_br_exists'

alias gsta='greb -b staging'


# Functions
# ---------------------------------------------------------------------------------------

git_master() {
    bash ~/bash/scripts/git/rebaseMaster.bash "$@"
}

git_development() {
    bash ~/bash/scripts/git/rebaseDevelopment.bash "$@"
}

git_br() {
    bash ~/bash/scripts/git/branch.bash "$@"
}

git_br_development() {
    bash ~/bash/scripts/git/branchDevelopment.bash "$@"
}

git_push() {
    bash ~/bash/scripts/git/push.bash "$@"
}

git_rebase() {
    bash ~/bash/scripts/git/rebase.bash "$@"
}

git_merge() {
    bash ~/bash/scripts/git/merge.bash "$@"
}

git_tag() {
    bash ~/bash/scripts/git/tag.bash "$@"
}

git_init() {
    bash ~/bash/scripts/git/init.bash "$@"
}

git_check() {
    bash ~/bash/scripts/git/check.bash "$@"

    return $?
}

git_br_exists() {
    bash ~/bash/scripts/git/branchExists.bash "$@"

    return $?
}
