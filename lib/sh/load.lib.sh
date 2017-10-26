#!/bin/sh

set -e


# Lookup and load sh-lib on SCRIPTPATH
lib_load()
{
  local f_lib_load= f_lib_path=
  # __load_lib: true if inside util.sh:lib-load
  test -n "$__load_lib" || local __load_lib=1
  test -n "$1" || set -- str sys os std stdio src match main argv vc
  while test -n "$1"
  do
    lib_id=$(printf -- "${1}" | tr -Cs 'A-Za-z0-9_' '_')
    f_lib_loaded=$(eval printf -- \"\$${lib_id}_lib_loaded\")

    test -n "$f_lib_loaded" || {

        f_lib_path="$scriptpath/$1.lib.sh"
        test -e "$f_lib_path" || { echo "No path for lib '$1'" >&2 ; exit 1; }
        . $f_lib_path

        # again, func_exists is in sys.lib.sh. But inline here:
        type ${lib_id}_lib_load  2> /dev/null 1> /dev/null && {
           ${lib_id}_lib_load || error "in lib-load $1 ($?)" 1
        }

        eval ${lib_id}_lib_loaded=1
    }
    shift
  done
}

# Id: x-docker/
