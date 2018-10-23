#!/bin/sh
set -e

mkdir -p _tmp
rm _tmp/__test__*
echo "echo 0: \$0" >> _tmp/__test__.do
echo "echo 1: \$1" >> _tmp/__test__.do
echo "echo 2: \$2" >> _tmp/__test__.do

test -n "$IMAGE_NAME" || IMAGE_NAME="$ONAME/$LNAME:$DOCKER_TAG"

docker run --rm \
  -v $(realpath _tmp):/_tmp/ \
  -ti $IMAGE_NAME redo /_tmp/__test__


{ cat <<EOM
0: __test__.do
1: __test__
2: __test__
EOM
  } > _tmp/__expected__

diff -bqr \
  _tmp/__test__ \
  _tmp/__expected__
