# Shell history
alias history='fc -l 1'
alias h='history'

function hs
{
  history | grep $*
}

alias hsi='hs -i'

function rh {
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}
