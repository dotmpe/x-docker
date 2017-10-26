#!/usr/bin/env bash

set -e
shopt -s extglob

version=0.0.2-dev # x-docker
script="$0"
test -h "$script" && script="$(realpath "$script")"
scriptpath="$(cd "$(dirname "$script")" && pwd -P)/../lib/sh"
scriptname="$(basename "$script" .sh)"

__load=ext . $scriptpath/load.lib.sh
lib_load std sys os str


load()
{
  true
}


xdckr__usage()
{
	echo TODO
}


xdckr__git_update_downstream()
{
	grep -v '^#' gitflow.tab | cut -f 2 -d ' ' | while read downstream
	do
		git checkout $downstream && git merge master || git merge --abort
		name="$(echo $downstream | cut -f 2 -d '-')"

		# Set custom README for branch
		test -e ReadMe-$name.md && {
			ln -s ReadMe-$name.md README.md
			git add README.md &&
				git ci -m "Updating $downstream" || continue
		}
	done

	git checkout master
}


# Main
main()
{
  cmd="$1"
  test $# -gt 1 && shift

  cmdid="$(mkcid "$cmd" && echo "$cid")"
  [ -n "$def_func" -a -z "$cmd" ] \
    && func="$def_func" \
    || func="xdckr__$cmdid"

  # look for alias if no shell function with name is defined
  type $func &> /dev/null || {

    cmd_als="$(eval echo \"\$xdckr_als__$cmdid\")"

    # Allow subcmd args in alias
    fnmatch *" "* "$als_args" && {
      als_args=$( echo $cmd_als | cut -d ' ' -f 2- )
      # Unshift alias and shift args
      set -- "$als_args" "$@"
      cmd_als=$( echo $cmd_als | cut -d ' ' -f 1 )
    }
    cmdid="$(mkcid "$cmd_als" && echo "$cid")"
    func=xdckr__$cmdid
  }

  # load/exec if func exists
  type $func &> /dev/null && { func_exists=1 ; load

    $func "$@"

  } || { e=$?

    # handle non-zero return or print usage for non-existant func
    test -z "$cmd" && {
      stderr 'No command' 1
    } || {
      test "$e" = "1" -a -z "$func_exists" && {
        load
        xdckr__usage
        stderr "No such command: '$cmd'" 1
      } || {
        test -n "$*" && argv="$cmd $*" || argv="$cmd"
        stderr "Command failure: '$argv', exit $e" $e
      }
    }
  }
}


main "$@"

# Id: x-docker/
