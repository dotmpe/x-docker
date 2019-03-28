#!/bin/sh

set -e


stderr()
{
  echo "[$scriptname] $1" >&2
  test -z "$2" || exit $2
}

# Copy: User-scripts/r0.0 src/sh/lib/std.lib.sh
# Id: x-docker/0.0.2-dev src/sh/std.lib.sh
