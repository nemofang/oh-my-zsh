# Alias for zsh config, edit and reload
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias zshreload="source ~/.zshrc"

# General alias

# cl as clear shortcut
alias cl="clear"

# rm
alias rm='rm -i'

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# `cat` with beautiful colors. requires: sudo easy_install -U Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# Display whatever file is regular file or folder
catt() {
  for i in "$@"; do
    if [ -d "$i" ]; then
      ls "$i"
    else
      c "$i"
    fi
  done
}

# Trim new lines and copy to clipboard
alias trimcopy="tr -d '\n' | pbcopy"

# File size
alias fs="stat -f \"%z bytes\""

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# Alias top to htop for better looking and easy reading top info
if [[ -x `which htop` ]]; then alias top="htop"; fi

# Emacs alias
alias emacs="/usr/local/bin/emacs -nw"

# Other
alias edit="$EDITOR"
alias q='exit'

################################
# Brew Cask alias              #
################################
alias cask='brew cask' # i <3 u cask
alias bcup='brew-cask update'
alias bcin='brew-cask install'
alias bcrm='brew-cask uninstall'
alias bczp='brew-cask zap'
alias bccl='brew-cask cleanup'
alias bcsr='brew-cask search'
alias bcls='brew-cask list'
alias bcinf='brew-cask info'
alias bcdr='brew-cask doctor'
alias bced='brew-cask edit'

################################
# Docker alias                 #
################################
alias dklc='docker ps -l'  # List last Docker container
alias dklcid='docker ps -l -q'  # List last Docker container ID
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last Docker container
alias dkps='docker ps'  # List running Docker containers
alias dkpsa='docker ps -a'  # List all Docker containers
alias dki='docker images'  # List Docker images
alias dkrmac='docker rm $(docker ps -a -q)'  # Delete all Docker containers
alias dkrmlc='docker-remove-most-recent-container'  # Delete most recent (i.e., last) Docker container
alias dkrmui='docker images -q -f dangling=true |xargs -r docker rmi'  # Delete all untagged Docker images
alias dkrmli='docker-remove-most-recent-image'  # Delete most recent (i.e., last) Docker image
alias dkrmi='docker-remove-images'  # Delete images for supplied IDs or all if no IDs are passed as arguments
alias dkideps='docker-image-dependencies'  # Output a graph of image dependencies using Graphiz
alias dkre='docker-runtime-environment'  # List environmental variables of the supplied image ID
alias dkelc='docker exec -it `dklcid` bash' # Enter last container (works with Docker 1.3 and above)

################################
# Nginx alias                  #
################################
alias nginx_start='nginx'
alias nginx_stop='nginx -s stop'
alias nginx_reload='nginx -s reload'

# Other
which gshuf &> /dev/null
if [ $? -eq 0 ]
then
  alias shuf=gshuf
fi
