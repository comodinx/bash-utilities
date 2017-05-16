#! bash/bash Completion support for Android commands.

# Alias
# ---------------------------------------------------------------------------------------

alias android_dimens_generator='adimgen'
alias android_copy_resources='acopyres'
alias android_vector_2_png='avec2png'


# Functions
# ---------------------------------------------------------------------------------------

android_dimens_generator() {
    bash ~/bash/scripts/android/dimens.bash "$@"
}

android_copy_resources() {
    bash ~/bash/scripts/android/copyResources.bash "$@"
}

android_vector_2_png() {
    bash ~/bash/scripts/android/vector2Png.bash "$@"
}
