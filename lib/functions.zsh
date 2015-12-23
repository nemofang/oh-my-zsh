function zsh_stats() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function uninstall_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

# about 'checks whether a website is down for you, or everybody'
# param '1: website url'
# example '$ down4me http://www.google.com'
function down4me ()
{
  curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

# about 'generates random password from dictionary words'
# param 'optional integer length'
# param 'if unset, defaults to 4'
# example '$ passgen'
# example '$ passgen 6'
function passgen ()
{
  local i pass length=${1:-4}
  pass=$(echo $(for i in $(eval echo "{1..$length}"); do pickfrom /usr/share/dict/words; done))
  echo "With spaces (easier to memorize): $pass"
  echo "Without (use this as the password): $(echo $pass | tr -d ' ')"
}

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
  find . -name "$1"
}

# List all files, long format, colorized, permissions in octal
function la () {
  ls -l  "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}

function lsgrep ()
{
  ls | grep "$*"
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

# get gzipped size
function gz() {
  echo "orig size    (bytes): "
  cat "$1" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# whois a domain or a URL
function whois() {
  local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
  if [ -z $domain ] ; then
    domain=$1
  fi
  echo "Getting whois record for: $domain …"

  # avoid recursion
  # this is the best whois server
  # strip extra fluff
  /usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

function usage ()
{
  if [ $(uname) = "Darwin" ]; then
    if [ -n $1 ]; then
      du -hd $1
    else
      du -hd 1
    fi

  elif [ $(uname) = "Linux" ]; then
    if [ -n $1 ]; then
      du -h --max-depth=1 $1
    else
      du -h --max-depth=1
    fi
  fi
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

# about 'disk usage per directory, in Mac OS X and Linux'
# param '1: directory name'
function usage ()
{
  if [ $(uname) = "Darwin" ]; then
    if [ -n $1 ]; then
      du -hd $1
    else
      du -hd 1
    fi

  elif [ $(uname) = "Linux" ]; then
    if [ -n $1 ]; then
      du -h --max-depth=1 $1
    else
      du -h --max-depth=1
    fi
  fi
}

# about 'creates iso from current dir in the parent dir (unless defined)'
# param '1: ISO name'
# param '2: dest/path'
# param '3: src/path'
# example 'mkiso'
# example 'mkiso ISO-Name dest/path src/path'
mkiso ()
{
  if type "mkisofs" > /dev/null; then
    [ -z ${1+x} ] && local isoname=${PWD##*/} || local isoname=$1
    [ -z ${2+x} ] && local destpath=../ || local destpath=$2
    [ -z ${3+x} ] && local srcpath=${PWD} || local srcpath=$3

    if [ ! -f "${destpath}${isoname}.iso" ]; then
      echo "writing ${isoname}.iso to ${destpath} from ${srcpath}"
      mkisofs -V ${isoname} -iso-level 3 -r -o "${destpath}${isoname}.iso" "${srcpath}"
    else
      echo "${destpath}${isoname}.iso already exists"
    fi
  else
    echo "mkisofs cmd does not exist, please install cdrtools"
  fi
}

# useful for administrators and configs
# about 'back up file with timestamp'
# param 'filename'
function buf ()
{
  local filename=$1
  local filetime=$(date +%Y%m%d_%H%M%S)
  cp -a "${filename}" "${filename}_${filetime}"
}

# about 'move files to hidden folder in tmp, that gets cleared on each reboot'
# param 'file or folder to be deleted'
# example 'del ./file.txt'
function del() {
  mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}

