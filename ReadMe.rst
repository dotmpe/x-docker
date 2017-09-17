Testbed dockerfile's
====================

Bats
  Usage::

    docker run -v DIR:/project bvberkum/BASE-bats [ARGV | -- CMD [ -- CMD ]*]

  Test project, ie. bats itself::

		make run:BASE-bats FLAGS="-v $(cd /srv/project-local/bats && pwd -P):/project"

  The main issue for test nodes is getting specific dependencies.

  Besides ``bash bats``, aditional tools installed into the base image are
  ``ncurses jq curl``.


  Bases
    alpine-bats
      There is `an autobuild at docker hub <https://hub.docker.com/r/bvberkum/alpine-bats/>`__

      Build::

        make build:alpine-bats TAG=edge

    To trigger additional run-time APK package installs use `X_DCKR_APK`, e.g.
    ``X_DCKR_APK='git python elinks'``.

    debian-bats
      ..

