#!/bin/sh

x_dckr_lib_load()
{
  true
}

x_dckr_check_readme() # [Branch-Name]
{
  test "$(readlink README.md)" = "$(x_dckr_branch_readme_filename "$1")"
}

fnmatch() { case "$2" in $1 ) ;; * ) return 1;; esac; }

x_dckr_branch_readme_filename() # [Branch-Name]
{
  x_dckr_branch_readme "$1" && echo ReadMe-$name.md || echo ReadMe-master.md
}

x_dckr_branch_readme() # [Branch-Name]
{
  test -n "$1" || set "$( vc_branch_git )"

  while test ! -e ReadMe-$1.md
  do
    fnmatch "*-*" "$1" || break
    set -- "$(echo "$1" | sed 's/-[^-]*$//g')"
    test -e ReadMe-$1.md || continue
    name=$1
  done
  return 1
}

# Copy: User-scripts/r0.0 src/sh/lib/x-dckr.lib.sh
# Id: x-docker/0.0.2-dev src/sh/x-dckr.lib.sh
