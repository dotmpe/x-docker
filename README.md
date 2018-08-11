Usage:
```
docker run -v DIR:/project \
		bvberkum/BASE-bats [ARGV | -- CMD [ -- CMD ]*]
```

Test project with files from `test` dir:
```
docker run -v $(pwd -P):/project bvberkum/BASE-bats ./test/
```

The main issue for flexible test nodes is getting specific dependencies, so the
entry-point allows both installing additiona packages, and/or executing several
script lines in sequence.

Besides `bash` and `bats`, aditional tools installed into the base image are
`jq`, `curl` and `ncurses` if needed for ``tput``.

----

- [Treebox](https://hub.docker.com/r/bvberkum/treebox)
  - [Sitefile](https://hub.docker.com/r/bvberkum/node-sitefile)
- [Sandbox](https://hub.docker.com/r/bvberkum/sandbox)
