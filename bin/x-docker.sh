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
    stderr "GIT checkout left in unresolved state, cannot return to $1"
    return 1
  } || {
    git checkout $1
  }
}

xdckr_git_update()
{
  test -n "$1" || stderr "branch name expected" 1
  git checkout $1 &&
  git pull origin $1 && {

    git merge $2 || {
      { test -e README.md && git checkout README.md; } ||
        stderr "Unexpected merge conflict" 1
    }
  } || {

    git merge --abort
    return 1
  }

	xdckr__link_custom_readme $1 && {
    {
      git add -f README.md &&
        git commit -m "Updating $1 for README"
    }|| return $?
  } || {

    test ! -e README.md || {
      git rm -f README.md &&
      git commit -m "Updating for README"
    }
  }
  not_trueish "$return" || {
    git push || return $?
  }
}


xdckr__git_update_all()
{
  test -n "$1" || stderr "branch expected" 1
  git checkout master &&
    git pull origin master &&
		xdckr__git_update $1
}


xdckr__git_update()
{
  test -n "$1" || stderr "branch name expected" 1
  test -n "$current_branch" ||
    local current_branch="$(git rev-parse --abbrev-ref HEAD)"
  xdckr_git_update "$1" "$current_branch" || return $?
  not_trueish "$return" || {
    xdckr_return_to_branch "$current_branch" || return $?
  }
}


xdckr__git_update_downstream()
{
	local current_branch="$(git rev-parse --abbrev-ref HEAD)"
	grep -v '^#' gitflow.tab | cut -f 2 -d ' ' | while read downstream
	do
		xdckr__git_update $downstream || return $?
	done
  not_trueish "$return" || {
    xdckr_return_to_branch || return $?
  }
}


xdckr_man_1__link_custom_readme='
With the autobuilder, README.md overrules all other matches
'
xdckr__link_custom_readme()
{
  test -n "$1" || stderr "branch/readme name expected" 1
	# Set custom README for branch
	local name=$( echo "$1" | cut -d '-' -f 1 )
	test -e ReadMe-$name.md && {
    test -e "README.md" -a "$(readlink README.md)" = "ReadMe-$name.md" && {
      return
    } || {
      rm README.md
    }
    ln -s ReadMe-$name.md README.md
	} || return 1
}


xdckr__release() # [ Version-Tag ]
{
  test -n "$1" || stderr "release tag expected" 1
  local current_branch="$(git rev-parse --abbrev-ref HEAD)" version="$1"

  local tag="$current_branch-$version"
  git show-ref --verify -q "refs/tags/$tag" &&
    stderr "Release exists: $tag" 1

  sys_confirm "Retag $current_branch and create $tag?" && {
    git tag -d $current_branch || true
    git tag $current_branch
    title="$(str_title "$current_branch")"
    git tag -a -m "$title $version" $tag
    # Start building the tag
    git push origin $tag
  }
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
