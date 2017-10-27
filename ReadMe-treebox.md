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

Dev
![docker autobuild status](https://img.shields.io/docker/build/bvberkum/treebox.svg)
![last commit on treebox](https://img.shields.io/github/last-commit/bvberkum/x-docker/treebox.svg)
![image size](https://img.shields.io/imagelayers/image-size/bvberkum/treebox/dev.svg)
![image layers](https://img.shields.io/imagelayers/layers/bvberkum/treebox/dev.svg)
![docker hub pulls](https://img.shields.io/docker/pulls/bvberkum/treebox.svg)
![docker hub stars](https://img.shields.io/docker/stars/bvberkum/treebox.svg)
![repo license](https://img.shields.io/github/license/bvberkum/x-docker.svg)
![issues](https://img.shields.io/github/issues/bvberkum/x-docker.svg)
![commits per year](https://img.shields.io/github/commit-activity/y/bvberkum/x-docker.svg)
![](https://img.shields.io/github/size/bvberkum/x-docker/base/treebox/Dockerfile.svg)
![](https://img.shields.io/github/languages/code-size/bvberkum/x-docker.svg)
![](https://img.shields.io/github/repo-size/bvberkum/x-docker.svg)
![](https://img.shields.io/maintenance/yes/2017.svg)

Latest
[![](https://images.microbadger.com/badges/image/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com image metadata")
[![](https://images.microbadger.com/badges/version/bvberkum/treebox.svg)](https://microbadger.com/images/bvberkum/treebox "microbadger.com version metadata")
![image size](https://img.shields.io/imagelayers/image-size/bvberkum/treebox/latest.svg)
![image layers](https://img.shields.io/imagelayers/layers/bvberkum/treebox/latest.svg)

The is the ReadMe-treebox file. See repository ReadMe in x-docker for more on 
autobuild.

## Testing
No automated testing, but here is a checklist per tag.

0.0.1
  - is SSH accessible after mounting startup script and user authorized_keys.
  - has user in supergroup, adding NOPASSWD sudoers line works as expected
  - has a customized SSH "Treebox" banner

(0.0.2)
  - responds to files in update-motd.d by updating the login message
