#!/bin/sh


date_lib_load()
{
  export _1DAY=86400
  export _1WEEK=604800

  export _1MONTH=$(( 4 * $_1WEEK ))
  export _1YEAR=$(( 365 * $_1DAY ))
}

date_lib_init()
{
  lib_assert sys os str || return
  case "$uname" in
    Darwin ) gdate="gdate" ;;
    Linux ) gdate="date" ;;
  esac
}

# Copy: User-scripts/r0.0 src/sh/lib/date.lib.sh
# Id: x-docker/0.0.2-dev src/sh/date.lib.sh
