#! bash/bash Completion support for Editing commands.

# Alias
# ---------------------------------------------------------------------------------------

alias initbash='restore_bash_profile'

# Functions
# ---------------------------------------------------------------------------------------

edit_bash_utils() {
    subl ~/bash
}

edit_bash_profile() {
    subl ~/.bash_profile
}

restore_bash_profile() {
    if command_check -c "javac"
    then
        javac ~/bash/scripts/android/dimens.java
        javac ~/bash/scripts/android/vector2Svg.java
    fi
    source ~/.bash_profile
}
