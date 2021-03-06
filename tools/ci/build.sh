#!/bin/sh

# Must link README.md using tag from branch name or use master.
check_readme()
{
  x_dckr_check_readme $BRANCH_NAME || {

    # Set ReadMe up for current branch
    test -e README.md && rm README.md
    ln -s ReadMe-$name.md README.md
  }
}


echo '-------- Build ('$(date --iso=ns)')'

test -z "${TRAVIS_BRANCH-}" &&
  BRANCH_NAME=$CIRCLE_BRANCH ||
  BRANCH_NAME=$TRAVIS_BRANCH

case "$BRANCH_NAME" in

  master ) check_readme ;;
  dev ) ;;
  test ) ;;
  * ) check_readme ;;

esac

# TODO: look at shell-ci workflow
# TODO: Commit any changes


# Merge changes to dockerfile to downstream branche,
# merge tooling changes to every downstream.

# Skip build on ci skip/no ci, and skip/no build commit tag.
# (also prevents dockerfile/tooling downstreams merge if affected).

BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"

# TODO: GIT workflow and incoorporate README checks etc
#case "$BRANCH_NAME" in
#
#  master )
#      # TODO: use gitflow or some metadata to do merge/rebase
#      git checkout dev && git merge master
#      git checkout treebox-dev && git merge dev
#      git checkout sandbox-dev && git merge treebox-dev
#      git checkout cl-dev && git merge dev
#      # TODO: use some hook setup to perform/check per-branch commit
#      # TODO: fix Dockerfile FROM
#      #git checkout cl-jupyter-dev && git merge cl-dev
#      #git checkout cl-jupyter/treebox-dev && git merge cl-jupyter-dev
#    ;;
#
#esac

# Sync: U-S:
# Sync: BIN:
