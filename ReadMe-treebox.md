## ``dotmpe/treebox`` [![image version](https://images.microbadger.com/badges/version/dotmpe/treebox.svg)](https://microbadger.com/images/dotmpe/treebox "microbadger.com version metadata") [ ![Dockerfile](https://img.shields.io/badge/Dockerfile-GitHub-blue.svg) ](https://github.com/dotmpe/x-docker/blob/master/_/treebox/Dockerfile) [ ![docker autobuild status](https://img.shields.io/docker/build/dotmpe/treebox.svg) ](https://cloud.docker.com/repository/docker/dotmpe/treebox) ![docker hub pulls](https://img.shields.io/docker/pulls/dotmpe/treebox.svg) ![code](https://img.shields.io/github/languages/code-size/dotmpe/x-docker.svg) ![repo](https://img.shields.io/github/repo-size/dotmpe/x-docker.svg) ![](https://img.shields.io/maintenance/yes/2019.svg) ![commits per year](https://img.shields.io/github/commit-activity/y/dotmpe/x-docker.svg) ![repo license](https://img.shields.io/github/license/dotmpe/x-docker.svg)

An image for development/testing with `treebox` user (ssh, sudo, staff and supergroup) and installations for:

- Python (PIP)
- Node.JS (NPM, N)
- PHP
- Ruby (gem)
- Shell package manager and tester [Basher](https://github.com/basherpm/basher), [Bats](https://github.com/bats-core/bats-core)

There is no password for the user. To let the treebox user excercise its sudoers
rights either allow for no-password use, or set a password. One of these lines:
```
echo treebox:password | chpasswd
echo "%supergroup  ALL=NOPASSWD:ALL" >>/etc/sudoers.d/treebox
```

#### ``:dev`` ![last commit on treebox-dev](https://img.shields.io/github/last-commit/dotmpe/x-docker/treebox-dev.svg) [![image size/layers](https://images.microbadger.com/badges/image/dotmpe/treebox:dev.svg)](https://microbadger.com/images/dotmpe/treebox:dev "Get your own image badge on microbadger.com")

#### ``:latest`` [![image size/layers](https://images.microbadger.com/badges/image/dotmpe/treebox.svg)](https://microbadger.com/images/dotmpe/treebox "microbadger.com image metadata")
[![image version](https://images.microbadger.com/badges/version/dotmpe/treebox.svg)](https://microbadger.com/images/dotmpe/treebox "microbadger.com version metadata")


## Autobuilds
Branch                       | Dockerfile       | Tag
---------------------------- | -----------------| ----------------------------
``/^treebox-(.*)$/``         | ``/_/treebox``   | ``{\1}``

Additional tags set in [customized highlander-build hooks](https://github.com/dotmpe/x-docker/tree/treebox-dev/tools/hooks)


## Tags
(0.0.7)
: ...

0.0.6
: - Moving builds to Github workflows. Rewrote tags again, removing old build hooks.
  
0.0.5
  - Now from ``dotmpe/testbox`` ``latest`` ``0.0.4``.
    Removed tagged autobuilds, now tagging manually to properly re-use images.
  - TODO: see about replacing version managers with asdf; remove nvm, and ruby,
    python, go, Haskel, and PHP setup. See about Redis, ImageMagick and Postgres
    too. <https://github.com/asdf-vm/asdf-plugins> [2019-01-10]

0.0.4
  - Added go.

0.0.3
  - Lots more build tools, a string of shells, missing bits like `binutils`, `jq`.
  - Fixed docker labels a bit.
  - Added more extensive user setup; Basher, user-scripts.
  - Added KCov install, Oil shell.

0.0.2
  - responds to files in update-motd.d by updating the login message
  - Testing with libffi_convenience, but no joy.
    phusion/baseimage:latest is 0.10.0
  - Looked to introduce baseimage tag in build/docker tag maybe, updated docs
    a bit and cleaning up hooks.

0.0.1
  - is SSH accessible after mounting startup script and user authorized_keys.
  - has user in supergroup, adding NOPASSWD sudoers line works as expected
  - has a customized SSH "Treebox" banner
