#!/bin/sh
set -e
. $WORKSPACE/tools/build-env.sh

case "$DOCKER_TAG" in

  last )
      X_DCKR_BASETAG="0.11"
    ;;

  latest|stable )
      X_DCKR_BASETAG="0.10.2"
    ;;

  dev )
      X_DCKR_BASETAG="master"
    ;;

  * )
      echo "No basetag for '$DOCKER_TAG'" >&2
      exit 1
    ;;

esac

DOCKER_TAGS="$DOCKER_TAGS baseimage-$X_DCKR_BASETAG"

VERSION=0.0.1-dev # basebox
