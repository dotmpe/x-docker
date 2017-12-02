Version: 0.0.2-dev

An image for development/testing with `treebox` user (ssh, sudo, staff and supergroup) and installations for:

- Python (PIP)
- Node.JS (NPM, N)
- PHP
- Ruby (gem)
- [Basher](https://github.com/basherpm/basher)

There is no password for the user. To let the treebox user excercise its sudoers
rights either allow for no-password use, or set a password. One of these lines:
```
echo treebox:password | chpasswd
echo "%supergroup  ALL=NOPASSWD:ALL" >>/etc/sudoers.d/treebox
```

### Dev ![docker autobuild status](https://img.shields.io/docker/build/bvberkum/treebox.svg) ![last commit on treebox-dev](https://img.shields.io/github/last-commit/bvberkum/x-docker/treebox-dev.svg) [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/treebox:dev.svg)](https://microbadger.com/images/bvberkum/treebox:dev "Get your own image badge on microbadger.com") ![docker hub pulls](https://img.shields.io/docker/pulls/bvberkum/treebox.svg) ![docker hub stars](https://img.shields.io/docker/stars/bvberkum/treebox.svg) ![repo license](https://img.shields.io/github/license/bvberkum/x-docker.svg) ![issues](https://img.shields.io/github/issues/bvberkum/x-docker.svg) ![commits per year](https://img.shields.io/github/commit-activity/y/bvberkum/x-docker.svg) ![readme](https://img.shields.io/github/size/bvberkum/x-docker/ReadMe-treebox.md.svg) ![code](https://img.shields.io/github/languages/code-size/bvberkum/x-docker.svg) ![repo](https://img.shields.io/github/repo-size/bvberkum/x-docker.svg) ![](https://img.shields.io/maintenance/yes/2017.svg) 


[comment]: <> (This is a comment, it will not be included)
[//]: # (This may be the most platform independent comment)
[//]: <> (This is also a comment.)

[]( ![last commit on treebox](https://img.shields.io/github/last-commit/bvberkum/x-docker/treebox.svg) )

### Latest [![image size/layers](https://images.microbadger.com/badges/image/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com image metadata") [![image version](https://images.microbadger.com/badges/version/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com version metadata")


## Autobuilds
Branch           | Dockerfile                   | Tag
---------------- | -----------------------------| ----------------------------
treebox-dev      | ``/_/treebox``               | dev

Tag                                             | Dockerfile       | Tag     
----------------------------------------------- | -----------------| ---------
treebox                                         | ``/_/treebox``   | latest
``/^treebox-([0-9\.]+[-a-z0-9+_-]*)/``          | ``/_/treebox``   | {\1}  

## Testing
No automated testing, but here is a checklist per tag.

0.0.1
  - is SSH accessible after mounting startup script and user authorized_keys.
  - has user in supergroup, adding NOPASSWD sudoers line works as expected
  - has a customized SSH "Treebox" banner

(0.0.2)
  - responds to files in update-motd.d by updating the login message
