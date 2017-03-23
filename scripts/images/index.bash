#! bash/bash Completion support for Images commands.

# Alias
# ---------------------------------------------------------------------------------------

alias imgres='image_resize'
alias imgresios='image_resize_ios'
alias imgresand='image_resize_android'
alias imgcom='image_compress'


# Includes
# ---------------------------------------------------------------------------------------

source ~/bash/scripts/helpers/index.bash


# Functions
# ---------------------------------------------------------------------------------------

image_resize() {
    bash ~/bash/scripts/images/resize.bash "$@"
}

image_resize_ios() {
    bash ~/bash/scripts/images/resize_ios.bash "$@"
}

image_resize_android() {
    bash ~/bash/scripts/images/resize_android.bash "$@"
}

image_compress() {
    bash ~/bash/scripts/images/compress.bash "$@"
}