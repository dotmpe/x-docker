#!/usr/bin/env bash


. $WORKSPACE/tools/build-env.sh


# Handle GIT branch: set upstream tag
case "$DOCKER_TAG" in

  * )
      T=$DOCKER_TAG
      X_DCKR_BASETAG=$T
    ;;

esac


eval $(docker run --rm dotmpe/testbox:$X_DCKR_BASETAG \
  bash -c 'cat /etc/os-release' | grep -v '^VERSION=' )

PHUSION_CODENAME=$UBUNTU_CODENAME
PHUSION_VER=$ID-$VERSION_ID


# Override tags with commit-msg tag, adding basetag from branch/tag also
echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' | grep -q '\[hub:' && {

  for tag in $(echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' | \
    sed -E 's/.*\[hub: ([^]]*)\].*/\1/' )
  do
    DOCKER_TAGS="$DOCKER_TAGS $tag $tag-$T $tag-$T-$PHUSION_CODENAME $tag-$T-$PHUSION_VER"
  done
} || {

  # Or start with tag from branch
  DOCKER_TAGS="$T $T-$PHUSION_VER baseimage-$T-$PHUSION_CODENAME baseimage-$T-$PHUSION_VER"

  # Handle GIT tags
  for tag in $(git_rev_tags | grep treebox- | tr '\n' ' ')
  do
    tag="$(echo "$tag"|cut -c9-)"
    DOCKER_TAGS="$DOCKER_TAGS $tag $tag-$T $tag-$T-$PHUSION_CODENAME $tag-$T-$PHUSION_VER"
  done
}
unset tag

VERSION=0.0.2-dev
