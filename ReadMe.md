# Testbed for dockerfile's

Version: 0.0.2-dev

Experimenting with Dockerfile builds, and autobuilds at hub.docker.com.


## Autobuilds

### bvberkum/treebox

Branch           | Dockerfile                   | Tag
---------------- | -----------------------------| ----------------------------
treebox-dev      | ``/_/treebox``               | dev
treebox          | ``/_/treebox``               | latest

Tag                          | Dockerfile       | Tag
---------------------------- | -----------------| ----------------------------
/^treebox-([0-9.]+)/         | ``/_/treebox``   | {\1}


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
  But exit 1 in a hook would suffice too. Can even scan the commit message if
  the above does not work.

  For example, could check that Dockerfile, or subdir for base actually has
  changes and don't bother with an entire rebuild/tag/push without reason.
 
  However, there is no easy way I can see to find the previous build ID. 
  Short of spinning up the image for an older tag and checking for markers placed during the previous build.

- Multiple autobuilds from one GIT repo works well, but it has issues.
  One issue is the description that gets updated from the generic project ReadMe.

  `highland builder`\ 's ``get_readme`` would allow for ``README.md`` to take
  precedence over secondary matches (``[Rr][Ee][Aa][Dd][Mm][Ee]*``). [#]

  Using hooks is of no use, the ReadMe seems be set before. So instead,
  each branch has its own ``README.md``.

- Merging and keeping a custom README.md per branch is a bit of a pain too.
  Tried to setup some help in bin/x-docker.sh

- Also, when using version tags these like the branches need a pre- or -suffix
  to distinguish them from versions for the other builds.

- The main issue I see with docker hub autobuilds is the lack of secrets.
  Its fine for public content, but alos only public services.
  Ie. no pushing to GIT, no remote DB or REST access and such.

  Because of this, even with an autobuild, much is done manually. Only this
  time through GIT or mercurial. Branching and tagging now corresponding to
  docker image tags as well.

  Docker builds on Travis are also possible.


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
