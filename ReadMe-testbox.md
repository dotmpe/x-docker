## ``dotmpe/testbox`` [![image version](https://images.microbadger.com/badges/version/dotmpe/testbox.svg)](https://microbadger.com/images/dotmpe/testbox "microbadger.com version metadata") [ ![Dockerfile](https://img.shields.io/badge/Dockerfile-GitHub-blue.svg) ](https://github.com/dotmpe/x-docker/blob/master/_/testbox/Dockerfile) [ ![docker autobuild status](https://img.shields.io/docker/build/dotmpe/testbox.svg) ](https://cloud.docker.com/repository/docker/dotmpe/testbox) ![docker hub pulls](https://img.shields.io/docker/pulls/dotmpe/testbox.svg) ![code](https://img.shields.io/github/languages/code-size/dotmpe/x-docker.svg) ![repo](https://img.shields.io/github/repo-size/dotmpe/x-docker.svg) ![](https://img.shields.io/maintenance/yes/2019.svg) ![commits per year](https://img.shields.io/github/commit-activity/y/dotmpe/x-docker.svg) ![repo license](https://img.shields.io/github/license/dotmpe/x-docker.svg)

A smaller treebox (no PHP, Node or Ruby).

#### ``:dev`` ![last commit on testbox-dev](https://img.shields.io/github/last-commit/dotmpe/x-docker/testbox-dev.svg) [![image size/layers](https://images.microbadger.com/badges/image/dotmpe/testbox:dev.svg)](https://microbadger.com/images/dotmpe/testbox:dev "Get your own image badge on microbadger.com")

#### ``:latest`` [![image size/layers](https://images.microbadger.com/badges/image/dotmpe/testbox.svg)](https://microbadger.com/images/dotmpe/testbox "microbadger.com image metadata")
[![image version](https://images.microbadger.com/badges/version/dotmpe/testbox.svg)](https://microbadger.com/images/dotmpe/testbox "microbadger.com version metadata")


## Autobuilds
Branch                     | Dockerfile         | Tag
-------------------------- | -------------------| ----------------------------
``/^testbox-(.*)$/``       | ``/_/testbox``     | ``{\1}``

Additional tags set in [customized highlander-build hooks](https://github.com/dotmpe/x-docker/tree/testbox-dev/tools/hooks)


## Tags
(0.0.3)
  - Fixed curly-braces expansion in Dockerfile.

0.0.2
  - Fixed metadata.
  - Using ``dotmpe/basebox:0.0.3``

0.0.1
  - Copy Dockerfile from treebox.

    Using ``dotmpe/basebox:0.0.1`` for upgraded ``apt`` packages on
    ``phusion/baseimage`` ``latest`` ``0.10.0``
