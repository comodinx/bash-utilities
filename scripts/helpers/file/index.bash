#! bash/bash Completion support for File commands.

# Alias
# ---------------------------------------------------------------------------------------

alias filegl='file_get_line'
alias filed='file_append_line'
alias filerepl='file_replace_line'
alias filehl='file_has_line'
alias filerl='file_remove_line'
alias filer='file_remove'
alias filet='file_transform'


# Functions
# ---------------------------------------------------------------------------------------

file_get_line() {
    bash ~/bash/scripts/helpers/file/getLine.bash "$@"
}

file_append_line() {
    bash ~/bash/scripts/helpers/file/appendLine.bash "$@"
}

file_replace_line() {
    bash ~/bash/scripts/helpers/file/replaceLine.bash "$@"
}

file_has_line() {
    bash ~/bash/scripts/helpers/file/hasLine.bash "$@"

    return $?
}

file_remove_line() {
    bash ~/bash/scripts/helpers/file/removeLine.bash "$@"
}

file_remove() {
    bash ~/bash/scripts/helpers/file/remove.bash "$@"
}

file_transform() {
    bash ~/bash/scripts/helpers/file/transform.bash "$@"
}
