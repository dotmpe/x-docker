# Bats

Flexible BATS shell test, [usage](ReadMe-bats.md).

There are builds based on alpine and debian distros for now, and also
a second series of dev images with BATS installed from source.


## Issues

Test `39 testing IFS not modified by run` is failing for every container. This
may be some curiosity in Docker.

The [Travis build](https://travis-ci.org/dotmpe/bats) is not showing this
issue.


## Bases

### alpine-bats
Build:
```
make build:alpine-bats TAG=edge
```

- To trigger additional run-time `apk` package installs use `X_DCKR_APK`, e.g. ``X_DCKR_APK='git python elinks'``.

### debian-bats
Build:
```
make build:debian-bats TAG=latest
make build:debian-bats TAG=sid
make build:debian-bats TAG=stable
make build:debian-bats TAG=unstable
```

- To trigger additional run-time `apt` package installs use `X_DCKR_APT`, e.g.
	``X_DCKR_APT='git python elinks'``.


### alpine-bats_dev, debian-bats_dev
Exactly like BASE-bats, but with BATS installed into ``/usr/local``
from GIT source.


## Testing
Run local example test-cases with all builds, stop on first error:
```
make test-bats
make test-bats ARGS=test/example-fail.bats
```

Or the same, but instead of local build use the autobuilds at ``dotmpe/BASE-bats``:
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

