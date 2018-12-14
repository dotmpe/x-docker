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
