#!/bin/sh

set -e


str_lib_load()
{
  test -x "$(which php)" &&
    bin_php=1 || bin_php=0
}

mkcid()
{
	cid="$(printf -- "$1" | tr -C 'A-Za-z0-9_' '_' )"
}

# Use this to easily matching strings based on glob pettern, without
# adding a Bash dependency (keep it vanilla Bourne-style shell).
fnmatch()
{
  case "$2" in $1 ) return 0 ;; *) return 1 ;; esac
}

str_title()
{
  # Other ideas to test as ucwords:
  # https://stackoverflow.com/questions/12420317/first-character-of-a-variable-in-a-shell-script-to-uppercase
  trueish "$bin_php" && {
    trueish "$first_word_only" &&
      php -r "echo ucfirst('$1');" ||
      php -r "echo ucwords('$1');"
  } || {
    trueish "$first_word_only" && {
      echo "$1" | awk '{ print toupper(substr($0, 1, 1)) substr($0, 2) }'
    } || {
      first_word_only=1 str_title "$(echo "$1" | tr ' ' '\n')" | tr '\n' ' '
    }
  }
}

# Id: x-docker/
