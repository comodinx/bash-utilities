#! bash/bash Completion support for Images commands.

# Alias
# ---------------------------------------------------------------------------------------

alias imgres='image_resize'
alias imgcom='image_compress'


# Includes
# ---------------------------------------------------------------------------------------

source ~/bash/scripts/helpers/index.bash


# Functions
# ---------------------------------------------------------------------------------------

image_resize() {
    bash ~/bash/scripts/images/resize.bash "$@"
}

image_compress() {
    bash ~/bash/scripts/images/compress.bash "$@"
}