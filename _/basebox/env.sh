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


eval $(docker run --rm phusion/baseimage:$X_DCKR_BASETAG \
  bash -c 'cat /etc/os-release' | grep -v '^VERSION=' )

PHUSION_CODENAME=$UBUNTU_CODENAME
PHUSION_VER=$ID-$VERSION_ID


# Override tags with commit-msg tag, using basetag from branch/tag
echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' | grep -qv '\[hub:' && {

  DOCKER_TAGS="$(echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' |
    sed -E 's/.*\[hub: ([^]]*\].*/\1/' )"
} || {

  DOCKER_TAGS="$DOCKER_TAGS baseimage-$X_DCKR_BASETAG baseimage-$X_DCKR_BASETAG-$PHUSION_CODENAME baseimage-$X_DCKR_BASETAG-$PHUSION_VER"
}

VERSION=0.0.4-dev # basebox
