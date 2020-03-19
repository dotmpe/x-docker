# Testbed for dockerfile's

Version: 0.0.2-dev

Experimenting with Dockerfile builds, and autobuilds at hub.docker.com.

## Autobuilds
Trying to:

- keep default tag `latest` a stable version
- keep older versions by tagging them
- autobuilding latest commits to `dev` tag

### dotmpe/treebox [![Treebox ReadMe](https://img.shields.io/badge/ReadMe-Treebox_docker-blue.svg)](ReadMe-treebox.md) [![docker autobuild status](https://img.shields.io/docker/build/dotmpe/treebox.svg)](https://hub.docker.com/r/dotmpe/treebox/)

### dotmpe/alpine-bats [![Bats ReadMe](https://img.shields.io/badge/ReadMe-Bats_docker-blue.svg)](ReadMe-bats.md) [![docker autobuild status](https://img.shields.io/docker/build/dotmpe/alpine-bats.svg)](https://hub.docker.com/r/dotmpe/alpine-bats/)

### dotmpe/alpine-docker [![Docker ReadMe](https://img.shields.io/badge/ReadMe-docker-blue.svg)](ReadMe-docker.md) [![docker autobuild status](https://img.shields.io/docker/build/dotmpe/alpine-bats.svg)](https://hub.docker.com/r/dotmpe/alpine-bats/)


## Building
``make build``, or see docker hub for autobuilds.


## Issues
1. Could check that Dockerfile, or subdir for base actually has changes and
   create a new build without good reason.

   However, there is no easy way I can see to find the previous build ID or
   know much without either using docker images or some other remote service
   besides docker registry.

   Ie. short of spinning up the image for an older tag and checking for markers
   placed during the previous build, or asking a public service.

2. Multiple autobuilds from one GIT repo works well, but it has issues.
   One issue is the description that gets updated from the generic project ReadMe.

   `highland builder`\ 's ``get_readme`` would allow for ``README.md`` to take
   precedence over secondary matches (``[Rr][Ee][Aa][Dd][Mm][Ee]*``). [#]

   Using hooks is of no use, the ReadMe seems be set before.
   So instead, each branch has its own ``README.md``.
   A bit of a hassle but using different branches in a multi-image repo is the
   only way, without a fancy version tracking mentioned in issue 1.

3. But merging and keeping a custom README.md per branch is a bit of a pain,
   Tried to setup some help in bin/x-docker.sh

4. Also, when using version tags these like the branches need a pre- or -suffix
   to distinguish them from versions for the other builds.

   The other slight issue is docker hub builds each commitish separately,
   creating unique containers for what is a single source version.

   Only solution is to use one SCM triggered autobuild, or select which to run
   using a hook and then cancel all but one. Everything using only data available
   from the checkout, or public services.

   Again, version tracking system or service would need to coordinate.

5. Another issue with docker hub autobuilds is the lack of secrets.

   So for pushing to GIT, remote DB or REST access and such some additional
   challenge would be required iot. trust the docker cloud builder.

   Note that docker builds on Travis are also possibility.


---

## Customizing builds

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

  :  Build image with IMAGE_NAME and then tag as 'this', and as 'DOCKER_REPO:<alias_tag>'
     for each DOCKER_TAGS[1:] (since IMAGE_NAME contains the default tag name)
     ```
     IMAGE_NAME = '{}:{}'.format(DOCKER_REPO, DOCKER_TAGS[0])
     tag=IMAGE_NAME
     ```

- post_build
- pre_test
- test

  :  Look for ``[.-]test.yml`` docker-compose files.
     For each file,
     run `sut` service, read all log lines, wait for return status and cleanup.

- post_test
- pre_push
- push

  :  DOCKER_TAG is 'latest' if not provided in shell env
     Push every DOCKER_TAGS (a csv, derived from DOCKER_TAG with spaces stripped)

Shell environment variables can be added to the current hub.docker.com build
system, including secrets. It is up to the maintainer of the autobuild to
prevent leaks, but the build logs are not exposed to the public anyway. The SSH
private key used to check out Git are available as env variable as well.

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
DOCKER_REPO=index.docker.io/dotmpe/treebox
COMMIT_MSG=......................................
BUILD_PATH=/_/treebox
SOURCE_TYPE=git
DOCKERFILE_PATH=
DOCKER_HOST=unix:///var/run/docker.sock
PWD=/src/......................./_/treebox
IMAGE_NAME=index.docker.io/dotmpe/treebox:dev
```

---

# Auto-build post url specs

At three points highland_builder takes an JSON file with::

  { "url": ... , "fields": ... }

And POSTs::

  requests.post(post_spec['url'],
    data=post_spec['fields'],
    files={'file': fd})

for paths at env vars::

  DOCKERFILE_POST_SPEC
  README_POST_SPEC
  LOGS_POST_SPEC

Probably to store Dockerfile, README and logs in docker cloud builder.
