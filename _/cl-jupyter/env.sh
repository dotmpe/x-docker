#!/bin/sh
set -e
. $WORKSPACE/tools/build-env.sh

INAME=cl-jupyter

case "$SOURCE_BRANCH" in

  cl-jupyter-dev )
      X_DCKR_BASE=dotmpe/treebox
      X_DCKR_TAG=dev
    ;;

  #cl-jupyter/treebox-dev )
  #    X_DCKR_BASE=dotmpe/treebox
  #    X_DCKR_TAG=dev
  #  ;;

  cl-jupyter/baseimage-dev )
      X_DCKR_BASE=phusion/baseimage
      X_DCKR_TAG=0.10.0
    ;;

esac

X_DCKR_BASETAG=

#DOCKER_TAGS=cl-jupyter
