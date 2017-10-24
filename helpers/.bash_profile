
# Aliases

# Aliases : Shortcuts
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias xcode="open -a Xcode"

# Aliases : Connections
alias connect-testing-api="ssh -i /Users/nicolasmolina/Certs/umewin/umewin-testing.pem ubuntu@54.235.23.82"
alias connect-testing-backend="ssh -i /Users/nicolasmolina/Certs/umewin/umewin-testing.pem ubuntu@54.157.141.35"
alias connect-jenkins="ssh -i /Users/nicolasmolina/Certs/umewin/umewin-testing.pem ubuntu@deployment.umewin.com"


# Helpers
source ~/bash/scripts/profile.bash

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
