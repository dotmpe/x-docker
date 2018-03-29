#!/bin/sh

set -e


stderr()
{
  echo "[$scriptname] $1" >&2
  test -z "$2" || exit $2
}
