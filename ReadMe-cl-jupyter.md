## ``dotmpe/cl-jupyter`` [![image version](https://images.microbadger.com/badges/version/dotmpe/cl-jupyter.svg)](https://microbadger.com/images/dotmpe/cl-jupyter "microbadger.com version metadata") [ ![Dockerfile](https://img.shields.io/badge/Dockerfile-GitHub-blue.svg) ](https://github.com/dotmpe/x-docker/blob/master/_/cl-jupyter/Dockerfile) [ ![docker autobuild status](https://img.shields.io/docker/build/dotmpe/cl-jupyter.svg) ](https://cloud.docker.com/repository/docker/dotmpe/cl-jupyter) ![docker hub pulls](https://img.shields.io/docker/pulls/dotmpe/cl-jupyter.svg) ![code](https://img.shields.io/github/languages/code-size/dotmpe/x-docker.svg) ![repo](https://img.shields.io/github/repo-size/dotmpe/x-docker.svg) ![](https://img.shields.io/maintenance/yes/2018.svg) ![commits per year](https://img.shields.io/github/commit-activity/y/dotmpe/x-docker.svg)

Jupyter with SBCL and other kernels installed.

#### ``:dev`` ![last commit on cl-jupyter-dev](https://img.shields.io/github/last-commit/dotmpe/x-docker/cl-jupyter-dev.svg) [ ![image size/layers](https://images.microbadger.com/badges/image/dotmpe/cl-jupyter:dev.svg) ](https://microbadger.com/images/dotmpe/cl-jupyter:dev "microbadger.com")
#### ``:latest`` [![image size/layers](https://images.microbadger.com/badges/image/dotmpe/cl-jupyter.svg)](https://microbadger.com/images/dotmpe/cl-jupyter "microbadger.com image metadata")

Lots of install based on treebox.

#### ``:baseimage-dev`` ![last commit on cl-jupyter/baseimage-dev](https://img.shields.io/github/last-commit/dotmpe/x-docker/cl-jupyter/baseimage-dev.svg) [ ![image size/layers](https://images.microbadger.com/badges/image/dotmpe/cl-jupyter:baseimage-dev.svg) ](https://microbadger.com/images/dotmpe/cl-jupyter:baseimage-dev "microbadger.com")
#### ``:baseimage-latest`` [![image size/layers](https://images.microbadger.com/badges/image/dotmpe/cl-jupyter:baseimage-latest.svg)](https://microbadger.com/images/dotmpe/cl-jupyter:baseimage-latest "microbadger.com image metadata")

Latest ``phusion/baseimage``.


```
docker pull dotmpe/cl-jupyter &&
docker run -d -p 8888:8888 \
  -v $(realpath /srv/docker-volumes-local)/notebooks:/notebooks \
  dotmpe/cl-jupyter
```
```
docker exec -ti <container> bash
# echo treebox:password | chpasswd
```

[2018-12-13] Added copy of sergiobuj/cl-jupyter perhaps to experiment a bit more with CL dev stack.
<https://gist.github.com/sergiobuj/ebf0a95ab96480dbc75f>
Already installs latest Quicklisp.

After switching to latest baseimage (0.10.0) and SBCL 1.4.14 latest release
docker build completes OK. Image seems to run fine.


## Autobuilds
Branch           | Dockerfile                   | Tag
---------------- | -----------------------------| ----------------------------
cl-jupyter-dev   | ``/_/cl-jupyter``            | dev

Tag                                             | Dockerfile        | Tag
----------------------------------------------- | ------------------| --------
cl-jupyter                                      | ``/_/cl-jupyter`` | latest
``/^cl-jupyter-([0-9\.]+[-a-z0-9+_-]*)/``       | ``/_/cl-jupyter`` | {\1}

## Tags
(0.0.2)
  - Restructured Dockerfile. Tried to change to run as user but no luck so far.
    Also getting strange root permission issues with NPM/JS kernels.
  - Added a bunch of Jupyter/IPython kernels:

    - bash, metakernel_bash
    - gnuplot
    - redis
    - TODO: nodejs

0.0.1
  Initial treebox/baseimage install.
