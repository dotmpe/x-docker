#!/bin/sh
set -e
. $WORKSPACE/tools/build-env.sh

case "$DOCKER_TAG" in

  dev )
      X_DCKR_BASETAG=dev

      DOCKER_TAGS="$DOCKER_TAGS basebox-$X_DCKR_BASETAG baseimage-master"
    ;;

  * )
      echo "No basetag for '$DOCKER_TAG'" >&2
      exit 1
    ;;

esac

VERSION=0.0.1-dev
