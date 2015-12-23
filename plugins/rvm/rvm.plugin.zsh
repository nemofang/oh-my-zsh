fpath=($rvm_path/scripts/zsh/Completion $fpath)

# Load RVM, if you are using it
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

alias rubies='rvm list rubies'
alias gemsets='rvm gemset list'

function rubies {
  rvm list
}

function switch_ruby {
  rvm use $1
}

function switch_default_ruby {
  rvm --default $1
}

function rvm-update {
	rvm get stable --auto-dotfiles
}

# TODO: Make this usable w/o rvm.
function gems {
	local current_ruby=`rvm-prompt i v p`
	local current_gemset=`rvm-prompt g`

	gem list $@ | sed -E \
		-e "s/\([0-9, \.]+( .+)?\)/$fg[blue]&$reset_color/g" \
		-e "s|$(echo $rvm_path)|$fg[magenta]\$rvm_path$reset_color|g" \
		-e "s/$current_ruby@global/$fg[yellow]&$reset_color/g" \
		-e "s/$current_ruby$current_gemset$/$fg[green]&$reset_color/g"
}

function _rvm_completion {
  source $rvm_path"/scripts/zsh/Completion/_rvm"
}
compdef _rvm_completion rvm
