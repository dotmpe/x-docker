#!/bin/sh

set -e


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

# Id: x-docker/
