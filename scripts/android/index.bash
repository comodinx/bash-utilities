#! bash/bash Completion support for Android commands.

# Alias
# ---------------------------------------------------------------------------------------

alias android_dimens_generator='adimgen'
alias android_copy_resources='acopyres'
alias android_vector_2_png='avec2png'
alias android_gradlelize='agradlelize'


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

android_gradlelize() {
    bash ~/bash/scripts/android/gradlelize.bash "$@"
}
