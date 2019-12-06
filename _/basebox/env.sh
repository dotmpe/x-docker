#!/usr/bin/env bash


. $WORKSPACE/tools/build-env.sh


# Handle GIT branch: set upstream tag
case "$DOCKER_TAG" in

  dev )
      X_DCKR_BASETAG=master
    ;;

  * )
      X_DCKR_BASETAG="$DOCKER_TAG"
      DOCKER_TAGS=$X_DCKR_BASETAG
    ;;

esac


# Handle GIT tags
for tag in $(git_rev_tags | grep basebox- | tr '\n' ' ')
do
  DOCKER_TAGS="$DOCKER_TAGS $(echo "$tag"|cut -c9-)"
done
unset tag


DOCKER_TAGS="$DOCKER_TAGS baseimage-$X_DCKR_BASETAG"

VERSION=0.0.4-dev # basebox
