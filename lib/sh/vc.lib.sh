#!/bin/sh

vc_branch_git()
{
  git rev-parse --abbrev-ref HEAD
}

vc_branch_for_ref() # Commit
{
  test -n "$1" || set -- "$(git rev-parse HEAD)"
  git show-ref --heads | grep "^$1" | awk '{print $2}' | cut -d'/' -f3-
}
