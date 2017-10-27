# Testbed for dockerfile's

Version: 0.0.2-dev

Experimenting with Dockerfile builds, and autobuilds at hub.docker.com.


## Autobuilds

### bvberkum/treebox

Branch           | Dockerfile                   | Tag
---------------- | -----------------------------| ----------------------------
treebox-dev      | ``/_/treebox``               | dev
treebox          | ``/_/treebox``               | latest

Tag              | Dockerfile                   | Tag
---------------- | -----------------------------| ----------------------------
/^[0-9.]+$/      | ``/_/treebox``               | {sourceref}

* [treebox](https://hub.docker.com/r/bvberkum/treebox/)
  [![](https://images.microbadger.com/badges/image/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com image metadata")
  [![](https://images.microbadger.com/badges/version/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com version metadata")

### bvberkum/alpine-bats
- [alpine-bats](https://hub.docker.com/r/bvberkum/alpine-bats/)
  [![](https://images.microbadger.com/badges/image/bvberkum/alpine-bats.svg)](https://microbadger.com/images/bvberkum/alpine-bats "microbadger.com")
- [debian-bats](https://hub.docker.com/r/bvberkum/debian-bats/)
  [![](https://images.microbadger.com/badges/image/bvberkum/debian-bats.svg)](https://microbadger.com/images/bvberkum/debian-bats "microbadger.com")

* [alpine-bats_dev](https://hub.docker.com/r/bvberkum/alpine-bats_dev/)
  [![](https://images.microbadger.com/badges/image/bvberkum/alpine-bats-dev.svg)](https://microbadger.com/images/bvberkum/alpine-bats-dev "microbadger.com")
* [alpine-bats_2017](https://hub.docker.com/r/bvberkum/alpine-bats_dev/)
  [![](https://images.microbadger.com/badges/image/bvberkum/alpine-bats-2017.svg)](https://microbadger.com/images/bvberkum/alpine-bats-2017 "microbadger.com")

* [debian-bats_dev](https://hub.docker.com/r/bvberkum/debian-bats_dev/)

### bvberkum/alpine-docker
- [alpine-docker](https://hub.docker.com/r/bvberkum/alpine-docker/)
  [![](https://images.microbadger.com/badges/image/bvberkum/alpine-docker.svg)](https://microbadger.com/images/bvberkum/alpine-docker "microbadger.com")


## Building
``make build``, or see docker hub for autobuilds.


## Issues
- Does not look highland_builder does abort or skip builds. 

  May try the 'ci skip'/'skip ci' that others like travis or drone support.

  also need to fixup the gitflow setup & deal with merge commits at branches.
  <http://readme.drone.io/usage/skipping-builds/>

  But othterwise just ``exit 1`` in a hook.
  Check that Dockerfile or subdir for base actually has
  changes or don't bother and prevent rebuild/tag/push this way.
 
  However, there is no easy way I can see to find the previous build ID. 
  Short of spinning up the image for an older tag and checking for markers placed during the previous build.
  Before that, going to play with commit in drone a bit more. Maybe could use the hooks at docker hub to build/tag and separate image.. its not very pretty, but could work.

 
- Multiple autobuilds from one GIT repo works well, but the one issue is the
  description that gets updated from the generic project ReadMe. Not good.

  `highland builder`\ 's ``get_readme`` would allow for ``README.md`` to take
  precedence over secondary matches (``[Rr][Ee][Aa][Dd][Mm][Ee]*``). [#]

  Using hooks is of no use, the ReadMe seems be set before. So instead,
  each branch has its own ``README.md``.


---

hub.docker.com uses docker/highland_builder, a good start for (undocumented)
features is
<https://github.com/docker/hub-feedback/issues/508#issuecomment-240616319>
<https://hub.docker.com/r/docker/highland_builder/tags/>
<https://github.com/andyneff/highland_builder>

<https://github.com/andyneff/highland_builder/blob/master/builder.py>

Docker hub hooks are:

- post_checkout
- pre_build
- build
- post_build
- pre_test
- test
- post_test
- pre_push
- push


---

# Auto-build env

```
Executing build hook...
PUSH=true
HOSTNAME=............
SHLVL=0
HOME=/root
SIGNED_URLS={"post": {"debug": {"url": "https://docker- .......
PYTHONUNBUFFERED=1
BUILD_CODE= .......................
MAX_LOG_SIZE=67108864
DOCKER_TAG=dev
CACHE_TAG=
GIT_SHA1=0ce8aba530481bde90ded7b59cc7783ccb81c121
GIT_MSG= ......................................
SOURCE_BRANCH= ...........
DOCKERCFG={"https://index.docker.io/v1/": {"email": "highland@docker.com", "auth": "............................................................"}}
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
DOCKER_REPO=index.docker.io/bvberkum/treebox
COMMIT_MSG=......................................
BUILD_PATH=/_/treebox
SOURCE_TYPE=git
DOCKERFILE_PATH=
DOCKER_HOST=unix:///var/run/docker.sock
PWD=/src/......................./_/treebox
IMAGE_NAME=index.docker.io/bvberkum/treebox:dev
```
