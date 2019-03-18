ONAME=bvberkum
LNAME="$SOURCE_BRANCH"

true "${DOCKER_TAGS:="$DOCKER_TAG"}"

true "${X_DCKR_CI_TIME:="` git show -s --format=%cI $GIT_SHA1`"}"
true "${X_DCKR_AI_TIME:="` git show -s --format=%aI $GIT_SHA1`"}"
