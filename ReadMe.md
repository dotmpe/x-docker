# Testbed dockerfile's

Experimenting with Dockerfile builds, and autobuilds at hub.docker.com.

## Autobuilds

No need to clone and rebuild, pull images here:

- [alpine-bats](https://hub.docker.com/r/bvberkum/alpine-bats/)
- [debian-bats](https://hub.docker.com/r/bvberkum/debian-bats/)
- [ubuntu-bats](https://hub.docker.com/r/bvberkum/ubuntu-bats/)

* [alpine-docker](https://hub.docker.com/r/bvberkum/alpine-docker/)
* [debian-docker](https://hub.docker.com/r/bvberkum/debian-docker/)
* [ubuntu-docker](https://hub.docker.com/r/bvberkum/ubuntu-docker/)


## Bats

Flexible BATS shell test. Usage:

```
docker run -v DIR:/project \
		bvberkum/BASE-bats [ARGV | -- CMD [ -- CMD ]*]
```

There are builds based on alpine and debian distros for now, and also
a second series of dev images with BATS installed from source.

Test project with files from `test` dir:
```
docker run -v $(pwd -P):/project bvberkum/BASE-bats ./test/
```

The main issue for flexible test nodes is getting specific dependencies, so the
entry-point allows both installing additiona packages, and/or executing several
script lines in sequence.

Besides `bash` and `bats`, aditional tools installed into the base image are
`jq`, `curl` and `ncurses` if needed for ``tput``.


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


### alpine-bats-dev
Exactly like alpine-bats, but with BATS installed into ``/usr/local``
from GIT source.


### debian-bats-dev
Exactly like debian-bats, but with BATS installed into ``/usr/local``
from GIT source.


## Testing
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


## docker-in-docker (DinD)

Only docker, for simple experimental purposes.

TODO: Not sure about if and where of an official build with support at 
/r/docker, /r/alpine..

Bases: alpine, debian and ubuntu.



## Building
``make build``, or see docker hub for autobuilds.


## Issues
- All builds get rebuild on a push at master. This is tedious and wastefull,
  and introduces a big lag.

  Make a branch setup. Tags are not really needed for now.
  Or maybe figure out a way to cancel builds, build only on changes to
  Dockerfile.

- Multiple autobuilds from one GIT repo works well, but the one issue is the
  description that gets updated from the generic project ReadMe. This mentions
  dev setup and other builds, which is confusing.


---

hub.docker.com uses docker/highland_builder, a good start for (undocumented)
features is
<https://github.com/docker/hub-feedback/issues/508#issuecomment-240616319>
