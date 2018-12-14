## ``bvberkum/treebox`` [![image version](https://images.microbadger.com/badges/version/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com version metadata") [ ![Dockerfile](https://img.shields.io/badge/Dockerfile-GitHub-blue.svg) ](https://github.com/bvberkum/x-docker/blob/master/_/treebox/Dockerfile) [ ![docker autobuild status](https://img.shields.io/docker/build/bvberkum/treebox.svg) ](https://cloud.docker.com/repository/docker/bvberkum/treebox) ![docker hub pulls](https://img.shields.io/docker/pulls/bvberkum/treebox.svg) ![code](https://img.shields.io/github/languages/code-size/bvberkum/x-docker.svg) ![repo](https://img.shields.io/github/repo-size/bvberkum/x-docker.svg) ![](https://img.shields.io/maintenance/yes/2018.svg) ![commits per year](https://img.shields.io/github/commit-activity/y/bvberkum/x-docker.svg) ![repo license](https://img.shields.io/github/license/bvberkum/x-docker.svg)

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

#### ``:dev`` ![last commit on treebox-dev](https://img.shields.io/github/last-commit/bvberkum/x-docker/treebox-dev.svg) [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/treebox:dev.svg)](https://microbadger.com/images/bvberkum/treebox:dev "Get your own image badge on microbadger.com")

#### ``:latest`` [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com image metadata")
[![image version](https://images.microbadger.com/badges/version/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com version metadata")


## Autobuilds
Branch           | Dockerfile                   | Tag
---------------- | -----------------------------| ----------------------------
treebox-dev      | ``/_/treebox``               | dev

Tag                                             | Dockerfile       | Tag
----------------------------------------------- | -----------------| ---------
treebox                                         | ``/_/treebox``   | latest
``/^treebox-([0-9\.]+[-a-z0-9+_-]*)/``          | ``/_/treebox``   | {\1}

## Tags
(0.0.4)

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
