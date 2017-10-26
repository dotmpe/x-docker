#!/bin/sh


# OS: files, paths


# Read file filtering octotorphe comments, like this one and empty lines
# XXX: this one support leading whitespace but others in ~/bin/*.sh do not
read_nix_style_file()
{
  test -n "$1" || return 1
  test -z "$2" || error "read-nix-style-file: surplus arguments '$2'" 1
  cat $cat_f "$1" | grep -Ev '^\s*(#.*|\s*)$' || return 1
}
