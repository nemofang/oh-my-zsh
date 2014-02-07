# Easier to startup the development env
function community() {
  cd $HOME/StyleSaint/community/sites/community
  bundle exec rails s -p 3001
}

function ecom() {
  cd $HOME/StyleSaint/puma
  bundle exec rails s -p 3002
}

function filterby(){
  cd $HOME/Filteredby/filtered-by
  bundle exec rails s -p 3000
}
# End

function zsh_stats() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function uninstall_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

# Create a new directory and enter it
function md() {
        mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
    find . -name "$1"
}

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
function httpcompression() {
        encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}

# Syntax-highlight JSON strings or files
function json() {
        if [ -p /dev/stdin ]; then
                # piping, e.g. `echo '{"foo":42}' | json`
                python -mjson.tool | pygmentize -l javascript
        else
                # e.g. `json '{"foo":42}'`
                python -mjson.tool <<< "$*" | pygmentize -l javascript
        fi
}

# take this repo and copy it to somewhere else minus the .git stuff.
function gitexport(){
        mkdir -p "$1"
        git archive master | tar -x -C "$1"
}

# get gzipped size
function gz() {
        echo "orig size    (bytes): "
        cat "$1" | wc -c
        echo "gzipped size (bytes): "
        gzip -c "$1" | wc -c
}

# All the dig info
function digga() {
        dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
        printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
        echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
        perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
        echo # newline
}
