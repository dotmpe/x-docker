#!/usr/bin/env bash


. $WORKSPACE/tools/build-env.sh

INAME=treebox
BNAME=testbox


# Use GIT branch to set upstream (base-image) tag B, and target tag T
case "$DOCKER_TAG" in

  dev | latest )
      B=$DOCKER_TAG
      T=$DOCKER_TAG
    ;;

  [0-9]*.[0-9]* )
      B=$DOCKER_TAG
      T=baseimage-$DOCKER_TAG
    ;;

  * ) echo "No mapping for DOCKER_TAG '$DOCKER_TAG'"
      exit 1
    ;;

esac

X_DCKR_BASETAG=$B


docker pull dotmpe/$BNAME:$X_DCKR_BASETAG
eval $(docker run --rm dotmpe/$BNAME:$X_DCKR_BASETAG \
  bash -c 'cat /etc/os-release' | sed 's/^/PHUSION_OS_/g' )

for k in NAME VERSION ID ID_LIKE PRETTY_NAME VERSION_ID VERSION_CODENAME UBUNTU_CODENAME
do
  echo "Phusion Baseimage OS $k: $(eval echo \"\$PHUSION_OS_$k\")"
done


# Override tags with commit-msg tag, adding basetag from branch/tag also
echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' | grep -q '\[hub:' && {
  CI_TAGS="$(echo "$COMMIT_MSG" | tr 'A-Z' 'a-z' | sed -E 's/.*\[hub: ([^]]*)\].*/\1/' )"
} || CI_TAGS=


# Apply all tags
DOCKER_TAGS=""
for tag in $T $CI_TAGS $(git_rev_tags | grep $INAME- | cut -c9- | tr '\n' ' ')
do
  test -n "$tag" || continue
  DOCKER_TAGS="$DOCKER_TAGS $tag $tag-$PHUSION_OS_ID-$PHUSION_OS_VERSION_ID $tag-$PHUSION_OS_VERSION_CODENAME"
done
unset tag

VERSION=0.0.5 # treebox

echo "Building version '$VERSION' for tags: $DOCKER_TAGS"
