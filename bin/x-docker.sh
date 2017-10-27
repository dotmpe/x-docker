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

xdckr_return_to_branch()
{
  git status --porcelain | grep -q '\(U.\)\|\(.U\)' && {
    stderr "GIT checkout left in unresolved state, cannot return to $current_branch"
    return 1
  } || {
    git checkout $current_branch
  }
}

xdckr__git_update_all()
{
  test -n "$1" || stderr "branch expected" 1
  git checkout master &&
    git pull &&
		xdckr__git_update $1
}

xdckr_git_update()
{
  git checkout $1 &&
  git pull origin $1 &&
  git merge master || {
      git merge --abort
      return 1
    }
	xdckr__link_custom_readme $1 && {
    git add README.md &&
      git commit -m "Updating $1 for README"
  } || {
    test ! -e README.md || {
      git rm README.md &&
      git commit -m "Updating for README"
    }
  }
}

xdckr__git_update()
{
  test -n "$current_branch" ||
    local current_branch="$(git rev-parse --abbrev-ref HEAD)"
  xdckr_git_update || return $?
  xdckr_return_to_branch
}


xdckr__git_update_downstream()
{
	local current_branch="$(git rev-parse --abbrev-ref HEAD)"
	grep -v '^#' gitflow.tab | cut -f 2 -d ' ' | while read downstream
	do
		xdckr__git_update $downstream || return $?
	done
  xdckr_return_to_branch
}

xdckr_man_1__link_custom_readme='
With the autobuilder, README.md overrules all other matches
'
xdckr__link_custom_readme()
{
  test -n "$1" || stderr "branch name expected" 1
	# Set custom README for branch
	echo ReadMe-$1.md

	test -e ReadMe-$1.md && {

    test "$(readlink README.md)" = "ReadMe-$1.md" && {
      return
    } || {
      rm README.md
    }
    ln -s ReadMe-$1.md README.md
	} || return 1
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
