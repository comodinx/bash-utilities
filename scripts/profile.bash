# Elevate the max watched files
ulimit -n 10000


# Display ps1 with colorful pwd and git status
# Acording to Jimmyxu .bashrc
# Modified by Ranmocy
source ~/bash/helpers/.git-prompt.sh
source ~/bash/helpers/.git-completion.bash
source ~/bash/scripts/git/ps1.bash


# Aliases
alias l='ls -la'
alias ll='ls -l'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'


# Helpers
source ~/bash/scripts/helpers/index.bash
source ~/bash/scripts/config/index.bash
source ~/bash/scripts/images/index.bash
source ~/bash/scripts/npm/index.bash
source ~/bash/scripts/git/index.bash
