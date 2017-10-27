Usage:
```
docker run -v DIR:/project \
		bvberkum/BASE-bats [ARGV | -- CMD [ -- CMD ]*]
```

Test project with files from `test` dir:
```
docker run -v $(pwd -P):/project bvberkum/BASE-bats ./test/
```

The main issue for flexible test nodes is getting specific dependencies, so the
entry-point allows both installing additiona packages, and/or executing several
script lines in sequence.

Besides `bash` and `bats`, aditional tools installed into the base image are
`jq`, `curl` and `ncurses` if needed for ``tput``.

- [alpine-bats](https://hub.docker.com/r/bvberkum/alpine-bats/)
  [![](https://images.microbadger.com/badges/image/bvberkum/alpine-bats.svg)](https://microbadger.com/images/bvberkum/alpine-bats "microbadger.com")
- [debian-bats](https://hub.docker.com/r/bvberkum/debian-bats/)
  [![](https://images.microbadger.com/badges/image/bvberkum/debian-bats.svg)](https://microbadger.com/images/bvberkum/debian-bats "microbadger.com")

* [alpine-bats_dev](https://hub.docker.com/r/bvberkum/alpine-bats_dev/)
  [![](https://images.microbadger.com/badges/image/bvberkum/alpine-bats-dev.svg)](https://microbadger.com/images/bvberkum/alpine-bats-dev "microbadger.com")
* [alpine-bats_2017](https://hub.docker.com/r/bvberkum/alpine-bats_dev/)
  [![](https://images.microbadger.com/badges/image/bvberkum/alpine-bats-2017.svg)](https://microbadger.com/images/bvberkum/alpine-bats-2017 "microbadger.com")

* [debian-bats_dev](https://hub.docker.com/r/bvberkum/debian-bats_dev/)


## Autobuilds
Branch           | Dockerfile                    | Image/Tag
---------------- | ----------------------------- | ---------------------------
alpine-bats      | ``/alpine-bats/edge``         | alpine-bats:edge
alpine-bats      | ``/alpine-bats/3.6``          | alpine-bats:3.6
alpine-bats      | ``/alpine-bats/latest``       | alpine-bats:latest
alpine-bats_dev  | ``/alpine-bats_dev/edge``     | alpine-bats-dev:edge
alpine-bats_dev  | ``/alpine-bats_dev/3.6``      | alpine-bats-dev:3.6
alpine-bats_dev  | ``/alpine-bats_dev/latest``   | alpine-bats-dev:latest
debian-bats_dev  | ``/debian-bats_dev/sid``      | debian-bats-dev:sid
debian-bats_dev  | ``/debian-bats_dev/stable``   | debian-bats-dev:stable
debian-bats_dev  | ``/debian-bats_dev/unstable`` | debian-bats-dev:unstable
debian-bats_dev  | ``/debian-bats_dev/latest``   | debian-bats-dev:latest
