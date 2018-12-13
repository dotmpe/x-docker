### Dev ![docker autobuild status](https://img.shields.io/docker/build/bvberkum/cl-jupyter.svg) ![last commit on cl-jupyter-dev](https://img.shields.io/github/last-commit/bvberkum/x-docker/cl-jupyter-dev.svg) [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/cl-jupyter:dev.svg)](https://microbadger.com/images/bvberkum/cl-jupyter:dev "Get your own image badge on microbadger.com") ![docker hub pulls](https://img.shields.io/docker/pulls/bvberkum/cl-jupyter.svg) ![docker hub stars](https://img.shields.io/docker/stars/bvberkum/cl-jupyter.svg) ![repo license](https://img.shields.io/github/license/bvberkum/x-docker.svg) ![issues](https://img.shields.io/github/issues/bvberkum/x-docker.svg) ![commits per year](https://img.shields.io/github/commit-activity/y/bvberkum/x-docker.svg) ![readme](https://img.shields.io/github/size/bvberkum/x-docker/ReadMe-cl-jupyter.md.svg) ![code](https://img.shields.io/github/languages/code-size/bvberkum/x-docker.svg) ![repo](https://img.shields.io/github/repo-size/bvberkum/x-docker.svg) ![](https://img.shields.io/maintenance/yes/2017.svg) 

[//]: # 'Not a tag. ![last commit on cl-jupyter](https://img.shields.io/github/last-commit/bvberkum/x-docker/cl-jupyter.svg)'

### Latest [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/cl-jupyter.svg)](https://microbadger.com/images/bvberkum/cl-jupyter "microbadger.com image metadata")
[![image version](https://images.microbadger.com/badges/version/bvberkum/cl-jupyter.svg)](https://microbadger.com/images/bvberkum/cl-jupyter "microbadger.com version metadata")

[Dockerfile](./_/cl-jupyter/Dockerfile]

```
docker pull bvberkum/cl-jupyter &&
docker run -d -p 8888:8888 -v $(realpath /srv/docker-volumes-local)/notebooks:/notebooks bvberkum/cl-jupyter
```

[2018-12-13] Added copy of sergiobuj/cl-jupyter perhaps to experiment a bit more with CL dev stack.
<https://gist.github.com/sergiobuj/ebf0a95ab96480dbc75f>
Already installs latest Quicklisp.

After switching to latest baseimage (0.10.0) and SBCL 1.4.14 latest release
docker build completes OK. Image seems to run fine.
