# Testbed dockerfile's

## Bats

Usage:

```
docker run -v DIR:/project \
    bvberkum/BASE-bats [ARGV | -- CMD [ -- CMD ]*]
```

Test project, ie. bats itself:

```
make run:BASE-bats \
    FLAGS="-v $(cd /srv/project-local/bats && pwd -P):/project"
```

The main issue for flexible test nodes is getting specific dependencies, so the
entry-point allows both installing additiona packages, and/or executing several
script lines in sequence.

Besides `bash` and `bats`, aditional tools installed into the base image are
`jq`, `curl` and `ncurses` if needed for ``tput``.

### Bases

### alpine-bats
Build:

  make build:alpine-bats TAG=edge

- There is [an autobuild at docker hub](https://hub.docker.com/r/bvberkum/alpine-bats/)
- To trigger additional run-time `apk` package installs use `X_DCKR_APK`, e.g. ``X_DCKR_APK='git python elinks'``.

### debian-bats
Build:

  make build:debian-bats TAG=latest
  make build:debian-bats TAG=sid
  make build:debian-bats TAG=stable
  make build:debian-bats TAG=unstable

- There are [autobuilds at docker hub](https://hub.docker.com/r/bvberkum/alpine-bats/)
- To trigger additional run-time `apt` package installs use `X_DCKR_APT`, e.g.
  ``X_DCKR_APT='git python elinks'``.
