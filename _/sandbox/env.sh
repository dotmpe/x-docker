#!/usr/bin/env bash


. $WORKSPACE/tools/build-env.sh

INAME=sandbox


# Handle GIT branch: set upstream tag
case "$DOCKER_TAG" in

  * )
      T=$DOCKER_TAG
      B=$T
    ;;

esac

X_DCKR_BASETAG=$B


#DOCKER_TAGS=treebox

VERSION=0.0.1-dev # sandbox
