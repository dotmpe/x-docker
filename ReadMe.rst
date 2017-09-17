Testbed dockerfile's
====================

alpine-bats
	Build::

		make build:alpine-bats TAG=edge

  Usage::

    docker run -v DIR:/project bvberkum/alpine-bats [ARGV | -- CMD [ -- CMD ]*]

  Test project, ie. bats itself::

		make run:alpine-bats FLAGS="-v $(cd /srv/project-local/bats && pwd -P):/project"

  The main issue for test nodes is getting specific dependencies.

  Besides ``bash bats``, aditional tools installed into the base image are
  ``ncurses jq curl``.

  To trigger additional run-time APK package installs use `X_DCKR_APK`, e.g.
  ``X_DCKR_APK='git python elinks'``.
