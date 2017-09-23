# Testbed dockerfile's

Experimenting with Dockerfile builds, and autobuilds at hub.docker.com.

- [alpine-bats](https://hub.docker.com/r/bvberkum/alpine-bats/)
- [debian-bats](https://hub.docker.com/r/bvberkum/debian-bats/)
- [ubuntu-bats](https://hub.docker.com/r/bvberkum/ubuntu-bats/)

* [alpine-bats_dev](https://hub.docker.com/r/bvberkum/alpine-bats_dev/)
* [debian-bats_dev](https://hub.docker.com/r/bvberkum/debian-bats_dev/)
* [ubuntu-bats_dev](https://hub.docker.com/r/bvberkum/ubuntu-bats_dev/)

- [alpine-docker](https://hub.docker.com/r/bvberkum/alpine-docker/)
- [debian-docker](https://hub.docker.com/r/bvberkum/debian-docker/)
- [ubuntu-docker](https://hub.docker.com/r/bvberkum/ubuntu-docker/)

* [ubuntu-treebox](https://hub.docker.com/r/bvberkum/ubuntu-treebox/)


## Bats

Flexible BATS shell test, [usage](ReadMe-bats.md).

There are builds based on alpine and debian distros for now, and also
a second series of dev images with BATS installed from source.


### Issues

Test `39 testing IFS not modified by run` is failing for every container. This
may be some curiosity in Docker.

The [Travis build](https://travis-ci.org/bvberkum/bats) is not showing this
issue.


### Bases

#### alpine-bats
Build:
```
make build:alpine-bats TAG=edge
```

- To trigger additional run-time `apk` package installs use `X_DCKR_APK`, e.g. ``X_DCKR_APK='git python elinks'``.

#### debian-bats
Build:
```
make build:debian-bats TAG=latest
make build:debian-bats TAG=sid
make build:debian-bats TAG=stable
make build:debian-bats TAG=unstable
```

- To trigger additional run-time `apt` package installs use `X_DCKR_APT`, e.g.
	``X_DCKR_APT='git python elinks'``.


#### alpine-bats_dev, debian-bats_dev, ubuntu-bats_dev
Exactly like BASE-bats, but with BATS installed into ``/usr/local``
from GIT source.


### Testing
Run local example test-cases with all builds, stop on first error:
```
make test-bats
make test-bats ARGS=test/example-fail.bats
```

Or the same, but instead of local build use the autobuilds at ``bvberkum/BASE-bats``:
```
make test-bats LOCAL=false
make test-bats LOCAL=false ARGS=test/example-fail.bats
```

Run official BATS tests, in all builds:
```
make test-official-bats
```

Run your project BATS tests, in all builds:
```
make test-other-bats GIT_URL=... GIT_BRANCH=...
```

## Treebox

An image for development/testing with passwordless sudo.

- [ReadMe-treebox](ReadMe-treebox.md)


## Docker

### docker-in-docker (DinD)

Only docker, for simple experimental purposes.

TODO: Not sure about if and where of an official build with support at 
/r/docker, /r/alpine..

Bases: alpine, debian and ubuntu.


## Building
``make build``, or see docker hub for autobuilds.


## Issues
- All builds get rebuild on a push at master. This is tedious and wastefull,
  and introduces a big lag.

  Solved by a per-branch autobuild setup, one for each specific build.
  Could go more fine-grained using tags.

  Does not look highland_builder does abort or skip builds. 
  But try ``exit 1``. Check that Dockerfile or subdir for base actually has
  changes or don't bother.

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
