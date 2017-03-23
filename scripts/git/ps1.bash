# bash/zsh Completion GIT support for PS1.

if type -P tput &>/dev/null && tput setaf 1 &>/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

# git status with a dirty flag
function __git_status_flag {
  local git_status="$(git status 2> /dev/null)"
  local remote_pattern="^# Your branch is (.*) of"
  local diverge_pattern="# Your branch and (.*) have diverged"
  local clean_pattern="working tree|directory clean"
  local state=""
  local spacer=""
  local remote=""

  if [[ ! ${git_status} =~ ${clean_pattern} ]]; then
    state="⚡"
    spacer=" "
  fi

  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    spacer=" "
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  fi

  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
    spacer=" "
  fi

  echo "${state}${remote}${spacer}"
}

function __repo () {
    local branch=$(type __git_ps1 &>/dev/null && __git_ps1 | sed -e "s/^.*(//" -e "s/)$//")
    local vcs=""
    local repo=""

    if [ "$branch" != "" ]; then
        vcs=git
    else
        branch=$(type -P hg &>/dev/null && hg branch 2>/dev/null)
        if [ "$branch" != "" ]; then
            vcs=hg
        elif [ -e .bzr ]; then
            vcs=bzr
        elif [ -e .svn ]; then
            vcs=svn
        else
            vcs=
        fi
    fi
    if [ "$vcs" != "" ]; then
        if [ "$branch" != "" ]; then
            repo=$branch
        else
            repo=$vcs
        fi
        echo -n " [$(__git_status_flag)$repo] "
    fi
    return 0
}

if [ "$color_prompt" = yes ]; then
    PS1='\[\e[01;32m\]ಠ_ಠ\[\e[00m\]:\[\e[01;34m\]\w\[\e[0;35m\]$(__repo)\[\e[00m\]\$ '
else
    PS1='\u@\h:\w$(__repo)\$ '
fi
unset color_prompt

case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;\W\a\]$PS1"
  ;;
*)
  ;;
esac
