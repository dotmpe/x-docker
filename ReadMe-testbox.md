## ``bvberkum/testbox`` [![image version](https://images.microbadger.com/badges/version/bvberkum/testbox.svg)](https://microbadger.com/images/bvberkum/testbox "microbadger.com version metadata") [ ![Dockerfile](https://img.shields.io/badge/Dockerfile-GitHub-blue.svg) ](https://github.com/bvberkum/x-docker/blob/master/_/testbox/Dockerfile) [ ![docker autobuild status](https://img.shields.io/docker/build/bvberkum/testbox.svg) ](https://cloud.docker.com/repository/docker/bvberkum/testbox) ![docker hub pulls](https://img.shields.io/docker/pulls/bvberkum/testbox.svg) ![code](https://img.shields.io/github/languages/code-size/bvberkum/x-docker.svg) ![repo](https://img.shields.io/github/repo-size/bvberkum/x-docker.svg) ![](https://img.shields.io/maintenance/yes/2019.svg) ![commits per year](https://img.shields.io/github/commit-activity/y/bvberkum/x-docker.svg) ![repo license](https://img.shields.io/github/license/bvberkum/x-docker.svg)

A smaller treebox (no PHP, Node or Ruby).

#### ``:dev`` ![last commit on testbox-dev](https://img.shields.io/github/last-commit/bvberkum/x-docker/testbox-dev.svg) [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/testbox:dev.svg)](https://microbadger.com/images/bvberkum/testbox:dev "Get your own image badge on microbadger.com")

#### ``:latest`` [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/testbox.svg)](https://microbadger.com/images/bvberkum/testbox "microbadger.com image metadata")
[![image version](https://images.microbadger.com/badges/version/bvberkum/testbox.svg)](https://microbadger.com/images/bvberkum/testbox "microbadger.com version metadata")


## Autobuilds
Branch           | Dockerfile                   | Tag
---------------- | -----------------------------| ----------------------------
testbox-dev      | ``/_/testbox``               | dev

Tagged manually, to preserve identical layers iso. re-building per tag.

## Tags
0.0.2
  - Fixed metadata.
  - Using ``bvberkum/basebox:0.0.3``

0.0.1
  - Copy Dockerfile from treebox.

    Using ``bvberkum/basebox:0.0.1`` for upgraded ``apt`` packages on
    ``phusion/baseimage`` ``latest`` ``0.10.0``
