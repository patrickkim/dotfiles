
## colors ##
txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
txtwht='\033[0;37m' # White
txtmag='\033[0;35m' # Magenta

txtpk='\033[38;5;74m' # PK blue
txtin='\033[38;5;60m' # off grey
txtoh='\033[38;5;95m' # off magenta

bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan
bldwht='\033[1;37m' # White

unkblk='\033[4;30m' # Black - Underline
undred='\033[4;31m' # Red
undgrn='\033[4;32m' # Green
undylw='\033[4;33m' # Yellow
undblu='\033[4;34m' # Blue
undpur='\033[4;35m' # Purple
undcyn='\033[4;36m' # Cyan
undwht='\033[4;37m' # White

bakblk='\033[40m'   # Black - Background
bakred='\033[41m'   # Red
badgrn='\033[42m'   # Green
bakylw='\033[43m'   # Yellow
bakblu='\033[44m'   # Blue
bakpur='\033[45m'   # Purple
bakcyn='\033[46m'   # Cyan
bakwht='\033[47m'   # White

txtrst='\033[0m'    # Text Reset
txtdim='\033[2m'

## Custom shell scripts ##
function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    local color=$bldred
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    local color=$txtylw
  elif [[ $git_status =~ "nothing to commit" ]]; then
    local color=$txtgrn
  else
    local color=$txtoh
  fi

  echo -e "$color"
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo ":$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo ":$commit"
  fi
}

function where_am_i {
  local branch=$(git_branch)

  if [ ! -z "$branch" ]; then
    branch="(git$branch)"
  fi

  printf "\n $txtpk%s: $txtwht%s $txtrst%s\n" "$USER" "$PWD" "$branch"
}

## Bash Auto-completion ##
# brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

## Custom shell output ##
PS1="\[$txtwht\]\W"        # basename of pwd
PS1+="\[\$(git_color)\]"     # colors git status
PS1+="\$(git_branch)"        # prints current branch
PS1+="\[$txtpk\] \$ "        # '$'
PS1+="\[$txtin\]"            # color input text
export PS1

## helper functions ##
alias whereami=where_am_i
alias ?=where_am_i
alias bash_it="source ~/.bash_profile"

## git shortcuts ##
alias gcl='git clone '
alias gst='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit -m '
alias gdi='git diff '
alias gco='git checkout '
alias gpl='git pull '
alias gup='git pull --rebase'
alias gp='git push '

## rails shortcuts ##
alias rs='rails server'
alias rc='rails console'

## Folder shortcuts ##
alias work="cd ~/working_dir"
alias giddy="cd ~/working_dir/ruby/GiddyApps"
alias lix="cd ~/working_dir/lix"

## change to parent dir ##
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

## Colorize ls ##
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxexexabagacad

## Use a long listing format ##
alias ll='ls -la'


## Added by the Heroku Toolbelt ##
export PATH="/usr/local/heroku/bin:$PATH"

## RVM you pos ##
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
