#! bash/bash Completion support for Android commands.

# Alias
# ---------------------------------------------------------------------------------------

alias android_dimens_generator='adimgen'
alias android_copy_resources='acopyres'


# Functions
# ---------------------------------------------------------------------------------------

android_dimens_generator() {
    bash ~/bash/scripts/android/dimens.bash "$@"
}

android_copy_resources() {
    bash ~/bash/scripts/android/copyResources.bash "$@"
}
