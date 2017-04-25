#! bash/bash Completion support for Editing commands.

# Functions
# ---------------------------------------------------------------------------------------

edit_bash_utils() {
    subl ~/bash
}

edit_bash_profile() {
    subl ~/.bash_profile
}

restore_bash_profile() {
    javac ~/bash/scripts/android/main.java
    source ~/.bash_profile
}
