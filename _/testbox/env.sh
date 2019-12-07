#!/usr/bin/env bash


. $WORKSPACE/tools/build-env.sh


# Handle GIT branch: set upstream tag
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

# Override tags with commit-msg tag, adding basetag from branch/tag also
echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' | grep -q '\[hub:' && {

  for tag in $(echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' | \
    sed -E 's/.*\[hub: ([^]]*)\].*/\1/' )
  do
    DOCKER_TAGS="$DOCKER_TAGS $tag $tag-$T $tag-$T-$PHUSION_CODENAME $tag-$T-$PHUSION_VER"
  done
} || {

  # Or start with tag from branch
  DOCKER_TAGS="$T baseimage-$T-$PHUSION_CODENAME baseimage-$T-$PHUSION_VER"

  # Handle GIT tags
  for tag in $(git_rev_tags | grep basebox- | tr '\n' ' ')
  do
    tag="$(echo "$tag"|cut -c9-)"
    DOCKER_TAGS="$DOCKER_TAGS $tag $tag-$T $tag-$T-$PHUSION_CODENAME $tag-$T-$PHUSION_VER"
  done
}
unset tag

VERSION=0.0.1-dev
